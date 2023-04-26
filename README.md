# Livrable projet 13 OC - Mettez à l'échelle une application Django en utilisant une architecture modulaire

Plusieurs domaine du site Orange County Lettings ont été améliorés à partir du projet [a link](https://github.com/OpenClassrooms-Student-Center/Python-OC-Lettings-FR)

1. Réduction de diverses dettes techniques sur le projet
2. Refonte de l'architecture modulaire
3. Ajout d'un pipeline CI/CD et le déploiment
4. Surveillance de l’application et suivi des erreurs via Sentry. 


## Développement local

### Prérequis

- Compte GitHub avec accès en lecture à ce repository
- Git CLI
- SQLite3 CLI
- Interpréteur Python, version 3.6 ou supérieure

Dans le reste de la documentation sur le développement local, il est supposé que la commande `python` de votre OS shell exécute l'interpréteur Python ci-dessus (à moins qu'un environnement virtuel ne soit activé).

### Windows

#### Cloner le repository

- `cd .\path\to\put\project\in`
- `git clone https://github.com/iuliancojocari/Python-OC-Lettings-FR.git`

#### Créer l'environnement virtuel

- `cd ./path/to/Python-OC-Lettings-FR`
- `python -m venv venv`
- Activer l'environnement `.\venv\Scripts\activate`
- Confirmer que la version de l'interpréteur Python est la version 3.6 ou supérieure `python --version`


## Variables d'environnement - création fichier .env

1. Créer fichier .env à la racine du projet 
2. Définir les variables suivaintes ainsi que leur valeurs (vous devez remplacers les valeurs ci-dessous avec vos propres informatiosn): 
    - SECRET_KEY='fp$9^593hsriajg$_%=5trot9g!1qa@ew(o-1#@=&4%=hp46(s'
    - SENTRY_DSN="votre_dsn_sentry"
    - HEROKU_APP_NAME=oc-letting


#### Exécuter le site

- `cd .\path\to\Python-OC-Lettings-FR`
- `.\venv\Scripts\activate`
- `pip install -r requirements.txt`
- `python manage.py runserver`
- Aller sur `http://localhost:8000` dans un navigateur.

#### Linting

- `.\path\to\Python-OC-Lettings-FR`
- `.\venv\Scripts\activate`
- `flake8`

#### Tests unitaires

- `.\path\to\Python-OC-Lettings-FR`
- `.\venv\Scripts\activate`
- `pytest`

#### Base de données

- `cd .\path\to\Python-OC-Lettings-FR`
- Ouvrir une session shell `sqlite3`
- Se connecter à la base de données `sqlite3 .\oc-lettings-site.sqlite3`
- Afficher les tables dans la base de données `.tables`
- Afficher les colonnes dans le tableau des profils, `pragma table_info(profiles_profile)`
- Lancer une requête sur la table des profils, `select user_id, favorite_city from profiles_profile where favorite_city like 'B%';`
- `.quit` pour quitter

#### Panel d'administration

- Aller sur `http://localhost:8000/admin`
- Connectez-vous avec l'utilisateur `admin`, mot de passe `Abc1234!`

## Docker conteneurisation

### Lancement de l'application en local en créant une image docker
1. Télécharger et installer Docker
2. Vous rendre dans le répertoire du projet `cd .\path\to\Python-OC-Lettings-FR`
3. Vérifier que le fichier .env nécessaire a été créé et que les variables ont été définies
4. Créer l'image `docker build -t <image-name> .` avec le nom de votre choix
5. Utiliser la commande `docker run -p 80:8000 -td <image-name>`, en remplaçant image-name par le nom de l'image créée
6. Vous pouvez accéder à l'application dans un navigateur via http://127.0.0.1

### Lancement de l'application en local en téléchargeant une image depuis DockerHub
1. Télécharger et installer Docker
2. Aller sur le repository Docker : https://hub.docker.com/repository/docker/icojocari42/oc_lettings/tags
3. Copier le tag de l'image de votre choix (de préférence le plus récent)
4. Utiliser la commande ddocker run -p 80:8000 -td icojocari42/oc_lettings:<image-tag>, en remplaçant image-tag par le tag de l'image souhaitée
5. Vous pouvez accéder à l'application dans un navigateur via http://127.0.0.1


# Déploiement

## Prérequis
Vous aurez besoin des comptes ci-dessous afin de pouvoir réaliser l'intégration continue et le déploiement de l'application : 

- [GitHub](https://github.com/)
- [CircleCI (avec autorisations sur le compte GitHub)](https://app.circleci.com/)
- [Docker](https://www.docker.com/)
- [Heroku](https://www.heroku.com/)
- [Sentry](https://sentry.io/)

Le déploiement de l'application est automatisé par un pipeline CircleCI. Lorsque des modifications sont apportées au niveau du repository Github, alors le pipeline lance l'exécution du Linting et des Tests, opérations qui sont éxécutées sur toutes les branches du repository. 

Lorsque des modifications sont apportées sur la branche master du repository, alors en plus de l'exécution du Linting et des Test, le pipeline va construire une image docker et va la pusher sur le Dockerhub et va effectuer le déploiement de l'application sur Heroku.
- Le build de l'image Docker est fait seulemement si les Linting et les Tests sont réussis
- Le déploiement de l'application est effectué seuelement si les Linting, les Tests et le build de l'image Docker sont réussis


# Configuration

## CircleCI

Après avoir récupéré le projet, mis en place l'environnement de développement local et créé les comptes requis, initialiser un projet sur CircleCI via "Set Up Project". Sélectionner la branche master comme source pour le fichier .circleci/config.yml.

Pour faire fonctionner le pipeline CircleCI, il est nécessaire de préciser des variables d'environnement.
Pour cela, aller dans Project Settings > Environment Variables. 

Voici les variables d'environnement à définir : 
1. `DOCKERHUB_IMAGE_NAME` -> Nom de l'image docker à 'builder' et 'pusher' sur Dockerhub
2. `DOCKERHUB_PASSWORD` -> Mot de passe du compte Dockerhub
3. `DOCKERHUB_REPOSITORY` -> Le repository Dockerhub
4. `DOCKERHUB_USERNAME` -> Nom d'utilisateur Dockerhub
5. `HEROKU_API_KEY` -> La clé secrete Heroku générée lors de la création de l'application
6. `HEROKU_APP_NAME` -> Le nom de l'application créée sur Heroku
7. `SECRET_KEY` -> La clé secrete Django
8. `SENTRY_DSN` -> Le DSN du projet configuré au niveau de Sentry


## Docker

Créer un repository sur DockerHub. Le nom du repository doit correspondre à la variable DOCKERHUB_REPOSITORY définie pour CircleCI.

Le workflow de CircleCI va créer et déposer l'image de l'application dans le repository DockerHub défini. Il tague les images avec le “hash” de commit CircleCI ($CIRCLE_SHA1).


## Heroku

Pour créer une application dans votre compte Heroku, vous pouvez passer via l'interface WEB :
- Créer manuellement l'application sur le site. Le nom de l'application doit correspondre à la variable HEROKU_APP_NAME définie pour CircleCI. 


## Sentry

Après avoir créé un compte Sentry, créer un projet pour la plateforme Django. Le SENTRY_DSN sera disponible dans Project Settings > Client Keys (DSN). Veillez à ajouter cette variable à CircleCI et dans le fichier .env
La journalisation Sentry peut être testée en naviguant vers /sentry-debug/, localement (avec runserver ou une image Docker) et sur l'application déployée via https://<HEROKU_APP_NAME>.herokuapp.com/sentry-debug/. Ce point de terminaison provoque une ZeroDivisionError