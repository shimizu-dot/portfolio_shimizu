package com.example.petlife.service;

import com.example.petlife.dto.common.PageResponse;
import com.example.petlife.dto.pet.PetCreateRequest;
import com.example.petlife.dto.pet.PetResponse;
import com.example.petlife.dto.pet.PetUpdateRequest;
import com.example.petlife.entity.PetEntity;
import com.example.petlife.exception.NotFoundException;
import com.example.petlife.mapper.PetMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PetService {
    private final PetMapper petMapper;

    public PetService(PetMapper petMapper) {
        this.petMapper = petMapper;
    }

    public PageResponse<PetResponse> list(int page, int size) {
        int safePage = Math.max(page, 1);
        int safeSize = Math.min(Math.max(size, 1), 100);
        int offset = (safePage - 1) * safeSize;
        List<PetResponse> items = petMapper.findAll(safeSize, offset).stream().map(this::toResponse).toList();
        return new PageResponse<>(items, safePage, safeSize, petMapper.countAll());
    }

    public PetResponse get(Long id) {
        PetEntity row = petMapper.findById(id);
        if (row == null) throw new NotFoundException("Pet not found: " + id);
        return toResponse(row);
    }

    public PetResponse create(PetCreateRequest req) {
        PetEntity row = new PetEntity(null, req.ownerUserId(), req.name(), req.species(), req.breed(), req.sex(), req.birthDate(),
                req.weightBaselineKg(), null, null, null);
        petMapper.insert(row);
        return get(row.id());
    }

    public PetResponse update(Long id, PetUpdateRequest req) {
        PetEntity existing = petMapper.findById(id);
        if (existing == null) throw new NotFoundException("Pet not found: " + id);
        PetEntity row = new PetEntity(id, existing.ownerUserId(), req.name(), req.species(), req.breed(), req.sex(), req.birthDate(),
                req.weightBaselineKg(), existing.deletedAt(), existing.createdAt(), existing.updatedAt());
        petMapper.update(row);
        return get(id);
    }

    public void delete(Long id) {
        if (petMapper.softDelete(id, LocalDateTime.now()) == 0) throw new NotFoundException("Pet not found: " + id);
    }

    private PetResponse toResponse(PetEntity row) {
        return new PetResponse(row.id(), row.ownerUserId(), row.name(), row.species(), row.breed(), row.sex(), row.birthDate(), row.weightBaselineKg());
    }
}
