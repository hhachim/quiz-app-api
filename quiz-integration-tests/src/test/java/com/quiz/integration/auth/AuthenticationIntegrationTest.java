package com.quiz.integration.auth;

import com.quiz.core.model.User;
import com.quiz.core.repository.UserRepository;
import com.quiz.integration.util.TestDataUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.context.ActiveProfiles;
import io.restassured.RestAssured;
import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.notNullValue;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
public class AuthenticationIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestDataUtil testDataUtil;

    private User testUser;

    @BeforeEach
    void setUp() {
        RestAssured.port = port;
        userRepository.deleteAll();
        testUser = testDataUtil.createTestUser();
        userRepository.save(testUser);
    }

    @Test
    void testSuccessfulAuthentication() {
        given()
            .contentType("application/json")
            .body("{\"email\":\"test@example.com\",\"password\":\"password\"}")
        .when()
            .post("/api/auth/login")
        .then()
            .statusCode(200)
            .body("token", notNullValue())
            .body("refreshToken", notNullValue());
    }

    @Test
    void testFailedAuthentication() {
        given()
            .contentType("application/json")
            .body("{\"email\":\"test@example.com\",\"password\":\"wrong-password\"}")
        .when()
            .post("/api/auth/login")
        .then()
            .statusCode(401);
    }
}