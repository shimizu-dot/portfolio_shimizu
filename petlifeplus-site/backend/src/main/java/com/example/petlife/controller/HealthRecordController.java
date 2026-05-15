package com.example.petlife.controller;

import com.example.petlife.dto.common.PageResponse;
import com.example.petlife.dto.health.HealthRecordCreateRequest;
import com.example.petlife.dto.health.HealthRecordResponse;
import com.example.petlife.dto.health.HealthRecordUpdateRequest;
import com.example.petlife.service.HealthRecordService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/health-records")
public class HealthRecordController {
    private final HealthRecordService healthRecordService;

    public HealthRecordController(HealthRecordService healthRecordService) {
        this.healthRecordService = healthRecordService;
    }

    @GetMapping
    public ResponseEntity<PageResponse<HealthRecordResponse>> list(@RequestParam(defaultValue = "1") int page,
                                                                   @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(healthRecordService.list(page, size));
    }

    @GetMapping("/{id}")
    public ResponseEntity<HealthRecordResponse> get(@PathVariable Long id) {
        return ResponseEntity.ok(healthRecordService.get(id));
    }

    @PostMapping
    public ResponseEntity<HealthRecordResponse> create(@Valid @RequestBody HealthRecordCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(healthRecordService.create(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<HealthRecordResponse> update(@PathVariable Long id, @Valid @RequestBody HealthRecordUpdateRequest request) {
        return ResponseEntity.ok(healthRecordService.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        healthRecordService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
