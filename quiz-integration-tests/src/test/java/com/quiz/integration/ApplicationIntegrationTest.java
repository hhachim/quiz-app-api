package com.quiz.integration;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@Disabled("Tests désactivés pour l'étape 1 - à activer lors de l'étape 3")
public class ApplicationIntegrationTest {

    @Test
    void contextLoads() {
        // Ce test vérifie simplement que le contexte Spring se charge correctement
    }
}