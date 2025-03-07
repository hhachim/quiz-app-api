# Application de Quiz

## Description du projet
Cette application offre une plateforme complète pour créer, gérer et participer à des quiz interactifs. L'architecture est modulaire, permettant une évolution progressive et une maintenance facilitée.

## Structure du projet
Le projet est organisé en modules suivant une architecture modulaire :

- **quiz-core** : Entités de base, interfaces de repository et DTOs
- **authentication** : Module d'authentification JWT et sécurité
- **user-management** : Gestion des utilisateurs
- **content-management** : Gestion des contenus de quiz
- **response-validation** : Validation des réponses aux quiz
- **reporting** : Génération de rapports et statistiques
- **data-control** : Contrôle de cohérence des données
- **api-gateway** : Couche d'exposition unifiée pour le frontend

## Prérequis techniques
- Java 17
- Maven 3.8+
- MySQL (production) / H2 (développement)
- Spring Boot 3.4.x

## Installation et démarrage
```bash
# Cloner le dépôt
git clone [url-du-repo]

# Compiler le projet
cd quiz-app
mvn clean install

# Lancer l'application (après les étapes de développement)
cd [module-principal]
mvn spring-boot:run
```

## Profils d'exécution
- **dev** : Utilise une base de données H2 en mémoire (par défaut)
- **prod** : Utilise une base de données MySQL

Pour lancer avec un profil spécifique :
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=prod
```

## Plan d'implémentation progressive
Le développement de l'application suit un plan en 10 étapes, chacune ajoutant progressivement des fonctionnalités :

1. Mise en place du projet parent et structure de base
2. Module quiz-core
3. Module d'authentification
4. Module de gestion des utilisateurs
5. Module de gestion des contenus de quiz
6. Module de validation des réponses
7. Module de reporting
8. Module de contrôle des données
9. API Gateway et couche d'exposition
10. Finalisation et optimisation

## Qualité du code
Le projet utilise plusieurs outils pour assurer la qualité du code :
- JaCoCo pour la couverture de tests
- PMD pour l'analyse statique du code
- SpotBugs pour la détection de bugs potentiels
- Checkstyle pour la conformité au style de codage

## Documentation
La documentation est générée via Maven Site et JavaDoc.

Pour générer la documentation complète :
```bash
mvn site
```

## Contribution
[Instructions pour contribuer au projet]

## Licence
[Informations sur la licence]