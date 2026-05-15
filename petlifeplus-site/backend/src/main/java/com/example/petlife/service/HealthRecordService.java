package com.example.petlife.service;

import com.example.petlife.dto.common.PageResponse;
import com.example.petlife.dto.health.HealthRecordCreateRequest;
import com.example.petlife.dto.health.HealthRecordResponse;
import com.example.petlife.dto.health.HealthRecordUpdateRequest;
import com.example.petlife.entity.HealthRecordEntity;
import com.example.petlife.exception.NotFoundException;
import com.example.petlife.mapper.HealthRecordMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class HealthRecordService {
    private final HealthRecordMapper healthRecordMapper;

    public HealthRecordService(HealthRecordMapper healthRecordMapper) {
        this.healthRecordMapper = healthRecordMapper;
    }

    public PageResponse<HealthRecordResponse> list(int page, int size) {
        int safePage = Math.max(page, 1);
        int safeSize = Math.min(Math.max(size, 1), 100);
        int offset = (safePage - 1) * safeSize;
        List<HealthRecordResponse> items = healthRecordMapper.findAll(safeSize, offset).stream().map(this::toResponse).toList();
        return new PageResponse<>(items, safePage, safeSize, healthRecordMapper.countAll());
    }

    public HealthRecordResponse get(Long id) {
        HealthRecordEntity row = healthRecordMapper.findById(id);
        if (row == null) throw new NotFoundException("Health record not found: " + id);
        return toResponse(row);
    }

    public HealthRecordResponse create(HealthRecordCreateRequest req) {
        HealthRecordEntity row = new HealthRecordEntity(null, req.petId(), req.recordedByUserId(), req.recordDate(), req.weightKg(),
                req.mealMemo(), req.exerciseMinutes(), req.note(), null, null, null);
        healthRecordMapper.insert(row);
        return get(row.id());
    }

    public HealthRecordResponse update(Long id, HealthRecordUpdateRequest req) {
        HealthRecordEntity existing = healthRecordMapper.findById(id);
        if (existing == null) throw new NotFoundException("Health record not found: " + id);
        HealthRecordEntity row = new HealthRecordEntity(id, existing.petId(), existing.recordedByUserId(), req.recordDate(), req.weightKg(),
                req.mealMemo(), req.exerciseMinutes(), req.note(), existing.deletedAt(), existing.createdAt(), existing.updatedAt());
        healthRecordMapper.update(row);
        return get(id);
    }

    public void delete(Long id) {
        if (healthRecordMapper.softDelete(id, LocalDateTime.now()) == 0) throw new NotFoundException("Health record not found: " + id);
    }

    private HealthRecordResponse toResponse(HealthRecordEntity row) {
        return new HealthRecordResponse(row.id(), row.petId(), row.recordedByUserId(), row.recordDate(), row.weightKg(), row.mealMemo(), row.exerciseMinutes(), row.note());
    }
}
