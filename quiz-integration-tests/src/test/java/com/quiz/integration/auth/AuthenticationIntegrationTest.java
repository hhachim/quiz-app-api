package com.quiz.integration.auth;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@Disabled("Tests désactivés pour l'étape 1 - à activer lors de l'étape 3")
public class AuthenticationIntegrationTest {

    @Test
    void testSuccessfulAuthentication() {
        // À implémenter lors de l'étape 3
    }

    @Test
    void testFailedAuthentication() {
        // À implémenter lors de l'étape 3
    }
}