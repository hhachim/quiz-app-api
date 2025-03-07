package com.quiz.integration;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import com.quiz.integration.config.TestConfig;

@SpringBootTest(classes = TestConfig.class)
public class EmptyIntegrationTest {
    
    @Test
    void emptyTest() {
        // Ce test ne fait rien, mais permet de vérifier que la configuration de test est correcte
    }
}