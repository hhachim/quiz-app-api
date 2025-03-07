package com.quiz.integration.auth;

import com.quiz.core.model.User;
import com.quiz.core.repository.UserRepository;
import com.quiz.integration.config.TestConfig;
import com.quiz.integration.util.TestDataUtil;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ActiveProfiles;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest(classes = TestConfig.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public class AuthenticationIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestDataUtil testDataUtil;

    private TestRestTemplate restTemplate = new TestRestTemplate();
    private HttpHeaders headers = new HttpHeaders();
    private User testUser;

    @BeforeEach
    void setUp() {
        headers.setContentType(MediaType.APPLICATION_JSON);
        userRepository.deleteAll();
        testUser = testDataUtil.createTestUser();
        userRepository.save(testUser);
    }

    @Test
    void testSuccessfulAuthentication() {
        // Préparation de la requête
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("email", "test@example.com");
        requestBody.put("password", "password");
        
        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);
        
        // Envoi de la requête
        ResponseEntity<String> response = restTemplate.postForEntity(
                "http://localhost:" + port + "/api/auth/login", 
                request, 
                String.class);
        
        // Vérification du statut (échouera intentionnellement)
        assertEquals(200, response.getStatusCodeValue());
    }

    @Test
    void testFailedAuthentication() {
        // Préparation de la requête
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("email", "test@example.com");
        requestBody.put("password", "wrong-password");
        
        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);
        
        // Envoi de la requête
        ResponseEntity<String> response = restTemplate.postForEntity(
                "http://localhost:" + port + "/api/auth/login", 
                request, 
                String.class);
        
        // Vérification du statut (échouera intentionnellement)
        assertEquals(401, response.getStatusCodeValue());
    }
}