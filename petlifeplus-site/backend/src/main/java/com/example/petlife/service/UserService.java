package com.example.petlife.service;

import com.example.petlife.dto.common.PageResponse;
import com.example.petlife.dto.user.UserCreateRequest;
import com.example.petlife.dto.user.UserResponse;
import com.example.petlife.dto.user.UserUpdateRequest;
import com.example.petlife.entity.UserEntity;
import com.example.petlife.exception.BadRequestException;
import com.example.petlife.exception.NotFoundException;
import com.example.petlife.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserService {
    private final UserMapper userMapper;

    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public PageResponse<UserResponse> list(int page, int size) {
        int safePage = Math.max(page, 1);
        int safeSize = Math.min(Math.max(size, 1), 100);
        int offset = (safePage - 1) * safeSize;
        List<UserResponse> items = userMapper.findAll(safeSize, offset).stream().map(this::toResponse).toList();
        return new PageResponse<>(items, safePage, safeSize, userMapper.countAll());
    }

    public UserResponse get(Long id) {
        UserEntity row = userMapper.findById(id);
        if (row == null) throw new NotFoundException("User not found: " + id);
        return toResponse(row);
    }

    public UserResponse create(UserCreateRequest req) {
        if (userMapper.existsByEmail(req.email()) > 0) {
            throw new BadRequestException("Email already exists");
        }
        UserEntity row = new UserEntity(null, req.roleId() == null ? 2L : req.roleId(), req.name(), req.email(), req.password(), req.phone(),
                "ACTIVE", null, null, null, null);
        userMapper.insert(row);
        return get(row.id());
    }

    public UserResponse update(Long id, UserUpdateRequest req) {
        UserEntity existing = userMapper.findById(id);
        if (existing == null) throw new NotFoundException("User not found: " + id);

        UserEntity row = new UserEntity(id, existing.roleId(), req.name(), req.email(), existing.passwordHash(), req.phone(),
                req.status(), existing.lastLoginAt(), existing.deletedAt(), existing.createdAt(), existing.updatedAt());
        userMapper.update(row);
        return get(id);
    }

    public void delete(Long id) {
        if (userMapper.softDelete(id, LocalDateTime.now()) == 0) {
            throw new NotFoundException("User not found: " + id);
        }
    }

    private UserResponse toResponse(UserEntity row) {
        return new UserResponse(row.id(), row.roleId(), row.name(), row.email(), row.phone(), row.status());
    }
}
