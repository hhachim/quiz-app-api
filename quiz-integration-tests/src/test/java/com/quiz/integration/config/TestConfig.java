package com.quiz.integration.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.quiz")
@EntityScan(basePackages = "com.quiz.core.model")
@EnableJpaRepositories(basePackages = "com.quiz.core.repository")
public class TestConfig {
    public static void main(String[] args) {
        SpringApplication.run(TestConfig.class, args);
    }
}