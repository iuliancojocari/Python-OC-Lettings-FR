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
    - SENTRY_DSN="https://8f9e336562cc4d2da557052d5d5f10b2@o4505065345974272.ingest.sentry.io/4505065396633600"
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


