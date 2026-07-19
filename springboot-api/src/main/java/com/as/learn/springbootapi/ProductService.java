package com.as.learn.springbootapi;


import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    private final List<Product> products = List.of(
            new Product(1L, "Laptop", "Business Laptop", 1299.99),
            new Product(2L, "Monitor", "27 inch Monitor", 349.99),
            new Product(3L, "Keyboard", "Mechanical Keyboard", 99.99)
    );

    public List<Product> findAll() {
        return products;
    }

    public Product findById(Long id) {
        return products.stream()
                .filter(p -> p.id().equals(id))
                .findFirst()
                .orElse(null);
    }
}
