package com.as.learn.springbootapi;

public record Product(
        Long id,
        String name,
        String description,
        Double price
) {
}
