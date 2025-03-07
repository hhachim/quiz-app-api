package com.quiz.integration;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import com.quiz.integration.config.TestConfig;

@SpringBootTest(classes = TestConfig.class)
@ActiveProfiles("test")
public class ApplicationIntegrationTest {

    @Test
    @Disabled("À activer lorsque le module d'authentification sera implémenté")
    void contextLoads() {
        // Ce test vérifie simplement que le contexte Spring se charge correctement
    }
}