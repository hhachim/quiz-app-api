// quiz-integration-tests/src/test/java/com/quiz/integration/config/TestConfig.java
package com.quiz.integration.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan(basePackages = "com.quiz")
@EntityScan(basePackages = "com.quiz.core.model")
@EnableJpaRepositories(basePackages = "com.quiz.core.repository")
public class TestConfig {

    public static void main(String[] args) {
        SpringApplication.run(TestConfig.class, args);
    }
}