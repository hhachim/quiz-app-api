package com.quiz.integration.util;

import com.quiz.core.model.User;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class TestDataUtil {

    // Méthode pour créer un utilisateur de test
    public User createTestUser() {
        return User.builder()
                .email("test@example.com")
                .password("$2a$10$eDhncK/4cNH/1WCpPfpNNu3VcE5BxrdzhXHY8LsQlg9JzaTkNJBMa") // mot de passe: password
                .firstName("Test")
                .lastName("User")
                .createdAt(LocalDateTime.now())
                .isActive(true)
                .build();
    }
    
    // Vous pouvez ajouter d'autres méthodes pour créer d'autres types de données de test
}