hortcuts for common Artisan + Docker commands

Opinionated folder structure optimized for multi-project workflows

Clean .gitignore tuned for Laravel

Ready for CI/CD pipelines (GitHub Actions, GitLab CI, etc.)

Zero system-level dependencies required beyond Docker and Git

🧱 Architecture Overview
laravel-starter/
├── docker/
│   └── app/
│       └── Dockerfile        # PHP 8.2 + Composer container
├── docker-compose.yml        # Laravel + MySQL + phpMyAdmin
├── Makefile                  # Developer convenience commands
├── src/                      # Laravel application lives here
└── README.md

Container Network Diagram
+----------------------+     +--------------------+     +--------------------+
|   PHP 8.2 App        | <-- |   MySQL 8 Database | --📘 Laravel Starter (Docker + PHP 8.2 + MySQL 8)

A fully containerized, production-ready Laravel starter kit featuring PHP 8.2, MySQL 8, phpMyAdmin, and a modular Docker workflow.
This template standardizes Laravel development across freelance client projects and internal applications by providing:

A consistent Docker environment

Makefile-powered productivity shortcuts

Clean project structure

CI/CD-ready configuration

A repeatable workflow for creating new Laravel apps in minutes

Built for serious freelance work — fast, stable, and professional.

🚀 Features at a Glance

PHP 8.2 environment with Composer pre-installed

MySQL 8 database container

phpMyAdmin for direct DB management (port 8081)

Dedicated Dockerfile for Laravel development

Makefi> |   phpMyAdmin UI    |
|  Laravel + Composer  |     |   Port 3306        |     |   Port 8081        |
|  Port 8000           |     |                    |     |                    |
+----------------------+     +--------------------+     +--------------------+

📦 Requirements

Docker Desktop (macOS / Windows / Linux)

Git

PhpStorm or VS Code (recommended)

No PHP or MySQL installation needed on your host machine.

⚡ Getting Started

Clone the starter repository:

git clone git@github.com:brnagn7/laravel-starter.git
cd laravel-starter

1️⃣ Build Containers
docker compose build

2️⃣ Create a New Laravel App
mkdir src
docker compose run --rm app composer create-project laravel/laravel .

3️⃣ Configure Environment
cp src/.env.example src/.env


Update the DB section:

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=app
DB_USERNAME=appuser
DB_PASSWORD=appsecret

4️⃣ Start the Development Stack
make up


Laravel app → http://localhost:8000

phpMyAdmin → http://localhost:8081

🔧 Makefile Commands

The Makefile turns long Docker/Artisan commands into short aliases:

Command	Description
make up	Start containers
make down	Stop containers
make restart	Restart stack
make bash	Enter PHP container
make migrate	Run migrations
make seed	Run seeders
make fresh	Fresh migrate + seed
make test	Run tests
make optimize	Optimize Laravel
📁 Project Structure (After Laravel Install)
src/
├── app/
├── bootstrap/
├── config/
├── database/
├── public/
├── resources/
├── routes/
├── storage/
└── vendor/

🔐 Environment Strategy

This template respects Laravel security best practices:

.env never committed to Git

Each project keeps its own environment file

Production servers maintain their own .env

GitHub Actions can handle migration steps securely

Your laptop .env is for development only — not shared with servers.

🚀 Deployment Ready

This starter is pre-structured for modern CI/CD workflows:

SSH-based deploy scripts

composer install --no-dev automation

Database migration commands

Asset compilation (Vite)

Caching & optimization

Add a GitHub Actions file and you have automatic deployments triggered by:

git push origin main

🧩 Future Enhancements

Planned integrations:

new-laravel project generator script (1-minute project creation)

Automatic GitHub repo creation via API

CI/CD workflow with zero-downtime deploys

Pest testing scaffold

Laravel Sail optional support

🧑‍💻 Author

brnagn7
Modern Laravel Development • Dockerized Workflows • CI/CD Automation
