#!/bin/bash

# Script pour créer la structure du projet quiz-application

# Créer le répertoire racine si on n'est pas déjà dedans
if [ ! -d "quiz-application" ]; then
  mkdir -p quiz-application
  cd quiz-application
fi

# Liste des modules à créer
MODULES=("quiz-core" "quiz-auth" "quiz-user" "quiz-content" "quiz-validation" "quiz-reporting" "quiz-data-control" "quiz-api-gateway")

# Créer les répertoires pour chaque module
for MODULE in "${MODULES[@]}"; do
  echo "Création du module $MODULE..."
  
  # Créer la structure de base du module
  mkdir -p $MODULE/src/main/java/com/quiz/${MODULE#quiz-}
  mkdir -p $MODULE/src/main/resources
  mkdir -p $MODULE/src/test/java/com/quiz/${MODULE#quiz-}
  mkdir -p $MODULE/src/test/resources
  
  # Créer les sous-répertoires spécifiques selon le module
  case $MODULE in
    quiz-core)
      mkdir -p $MODULE/src/main/java/com/quiz/core/{model,repository,dto,event,exception,service}
      ;;
    quiz-auth)
      mkdir -p $MODULE/src/main/java/com/quiz/auth/{config,controller,dto,security,service}
      ;;
    quiz-user)
      mkdir -p $MODULE/src/main/java/com/quiz/user/{controller,dto,service}
      ;;
    quiz-content)
      mkdir -p $MODULE/src/main/java/com/quiz/content/{controller,dto,service}
      ;;
    quiz-validation)
      mkdir -p $MODULE/src/main/java/com/quiz/validation/{controller,dto,service,strategy}
      ;;
    quiz-reporting)
      mkdir -p $MODULE/src/main/java/com/quiz/reporting/{controller,dto,service}
      ;;
    quiz-data-control)
      mkdir -p $MODULE/src/main/java/com/quiz/datacontrol/{job,validator,alert,service}
      ;;
    quiz-api-gateway)
      mkdir -p $MODULE/src/main/java/com/quiz/api/{config,controller,dto,filter}
      ;;
  esac
  
  # Créer un fichier application.properties vide
  touch $MODULE/src/main/resources/application.properties
  
  # Ajouter des .gitkeep dans tous les répertoires pour permettre de les commiter
  find $MODULE -type d -empty -exec touch {}/.gitkeep \;
done

# Créer le POM parent
cat > pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.4.3</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    
    <groupId>com.quiz</groupId>
    <artifactId>quiz-application</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>pom</packaging>
    <name>Quiz Application</name>
    <description>Application de quiz avec Spring Boot</description>
    
    <modules>
        <module>quiz-core</module>
        <module>quiz-auth</module>
        <module>quiz-user</module>
        <module>quiz-content</module>
        <module>quiz-validation</module>
        <module>quiz-reporting</module>
        <module>quiz-data-control</module>
        <module>quiz-api-gateway</module>
    </modules>
    
    <properties>
        <java.version>17</java.version>
        <jjwt.version>0.11.5</jjwt.version>
        <maven.compiler.source>${java.version}</maven.compiler.source>
        <maven.compiler.target>${java.version}</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencyManagement>
        <dependencies>
            <!-- Dépendances internes -->
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-core</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-auth</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-user</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-content</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-validation</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-reporting</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-data-control</artifactId>
                <version>${project.version}</version>
            </dependency>
            <dependency>
                <groupId>com.quiz</groupId>
                <artifactId>quiz-api-gateway</artifactId>
                <version>${project.version}</version>
            </dependency>
            
            <!-- JWT Dependencies -->
            <dependency>
                <groupId>io.jsonwebtoken</groupId>
                <artifactId>jjwt-api</artifactId>
                <version>${jjwt.version}</version>
            </dependency>
            <dependency>
                <groupId>io.jsonwebtoken</groupId>
                <artifactId>jjwt-impl</artifactId>
                <version>${jjwt.version}</version>
                <scope>runtime</scope>
            </dependency>
            <dependency>
                <groupId>io.jsonwebtoken</groupId>
                <artifactId>jjwt-jackson</artifactId>
                <version>${jjwt.version}</version>
                <scope>runtime</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
    
    <dependencies>
        <!-- Dépendances communes à tous les modules -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <reporting>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-project-info-reports-plugin</artifactId>
                <version>3.9.0</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-report-plugin</artifactId>
                <version>3.5.2</version>
            </plugin>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.12</version>
                <reportSets>
                    <reportSet>
                        <reports>
                            <report>report</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-pmd-plugin</artifactId>
                <version>3.26.0</version>
            </plugin>
            <plugin>
                <groupId>com.github.spotbugs</groupId>
                <artifactId>spotbugs-maven-plugin</artifactId>
                <version>4.9.2.0</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-checkstyle-plugin</artifactId>
                <version>3.6.0</version>
                <reportSets>
                    <reportSet>
                        <reports>
                            <report>checkstyle</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-javadoc-plugin</artifactId>
                <version>3.5.0</version>
                <configuration>
                    <source>17</source>
                </configuration>
            </plugin>
        </plugins>
    </reporting>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-site-plugin</artifactId>
                <version>3.21.0</version>
            </plugin>
            <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>0.8.12</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-pmd-plugin</artifactId>
                <version>3.26.0</version>
                <configuration>
                    <linkXRef>true</linkXRef>
                    <sourceEncoding>UTF-8</sourceEncoding>
                    <minimumTokens>100</minimumTokens>
                    <targetJdk>17</targetJdk>
                    <excludes>
                        <exclude>**/generated/*.java</exclude>
                    </excludes>
                    <excludeRoots>
                        <excludeRoot>target/generated-sources</excludeRoot>
                    </excludeRoots>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

# Créer les POMs pour chaque module
# POM pour quiz-core
cat > quiz-core/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-core</artifactId>
    <name>Quiz Core</name>
    <description>Module central avec les entités et services de base</description>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-auth
cat > quiz-auth/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-auth</artifactId>
    <name>Quiz Authentication</name>
    <description>Module d'authentification avec JWT</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-user
cat > quiz-user/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-user</artifactId>
    <name>Quiz User Management</name>
    <description>Module de gestion des utilisateurs</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-auth</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-mail</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-content
cat > quiz-content/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-content</artifactId>
    <name>Quiz Content Management</name>
    <description>Module de gestion des contenus de quiz</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-auth</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-validation
cat > quiz-validation/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-validation</artifactId>
    <name>Quiz Validation</name>
    <description>Module de validation des réponses</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-reporting
cat > quiz-reporting/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-reporting</artifactId>
    <name>Quiz Reporting</name>
    <description>Module de reporting et statistiques</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-data-control
cat > quiz-data-control/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-data-control</artifactId>
    <name>Quiz Data Control</name>
    <description>Module de contrôle des données</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-core</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    </dependencies>
</project>
EOF

# POM pour quiz-api-gateway
cat > quiz-api-gateway/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>com.quiz</groupId>
        <artifactId>quiz-application</artifactId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    
    <artifactId>quiz-api-gateway</artifactId>
    <name>Quiz API Gateway</name>
    <description>Module de façade API et point d'entrée principal</description>
    
    <dependencies>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-auth</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-user</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-content</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>com.quiz</groupId>
            <artifactId>quiz-reporting</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>io.micrometer</groupId>
            <artifactId>micrometer-tracing-bridge-brave</artifactId>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
EOF

# Créer quelques classes de base pour le module quiz-core
# Créer un fichier User.java dans le module quiz-core
cat > quiz-core/src/main/java/com/quiz/core/model/User.java << 'EOF'
package com.quiz.core.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @Column(nullable = false)
    private String password;
    
    private String firstName;
    
    private String lastName;
    
    @Column(nullable = false)
    private LocalDateTime createdAt;
    
    @Column(nullable = false)
    private Boolean isActive;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        isActive = true;
    }
}
EOF

# S'assurer que tous les répertoires vides (même les nouveaux) ont un .gitkeep
find . -type d -empty -not -path "*/\.*" -exec touch {}/.gitkeep \;

echo "Structure du projet créée avec succès!"
echo "Des fichiers .gitkeep ont été ajoutés dans tous les dossiers vides pour faciliter le commit Git."