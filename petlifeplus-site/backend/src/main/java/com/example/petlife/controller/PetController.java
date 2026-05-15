package com.example.petlife.controller;

import com.example.petlife.dto.common.PageResponse;
import com.example.petlife.dto.pet.PetCreateRequest;
import com.example.petlife.dto.pet.PetResponse;
import com.example.petlife.dto.pet.PetUpdateRequest;
import com.example.petlife.service.PetService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/pets")
public class PetController {
    private final PetService petService;

    public PetController(PetService petService) {
        this.petService = petService;
    }

    @GetMapping
    public ResponseEntity<PageResponse<PetResponse>> list(@RequestParam(defaultValue = "1") int page,
                                                          @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(petService.list(page, size));
    }

    @GetMapping("/{id}")
    public ResponseEntity<PetResponse> get(@PathVariable Long id) {
        return ResponseEntity.ok(petService.get(id));
    }

    @PostMapping
    public ResponseEntity<PetResponse> create(@Valid @RequestBody PetCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(petService.create(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<PetResponse> update(@PathVariable Long id, @Valid @RequestBody PetUpdateRequest request) {
        return ResponseEntity.ok(petService.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        petService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
