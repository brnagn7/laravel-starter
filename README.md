── src/                 (Laravel app will be created here)
└── README.md

---

## Requirements

- Docker Desktop
- Git
- PhpStorm or VSCode

---

## Getting Started

Clone the repo:
git clone git@github.com:brnagn7/laravel-starter.git
cd laravel-starter

1. Build containers:
docker compose build

2. Create a new Laravel project:
mkdir src
docker compose run --rm app composer create-project laravel/laravel .

3. Configure environment:
cp src/.env.example src/.env

Update DB values in .env:
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=app
DB_USERNAME=appuser
DB_PASSWORD=appsecret

4. Start the stack:
make up

Laravel: http://localhost:8000
phpMyAdmin: http://localhost:8081

---

## Makefile Commands

make up       — Start containers
make down    # Laravel Starter (Docker + PHP 8.2 + MySQL 8)

A fully containerized Laravel starter kit using PHP 8.2, Composer, MySQL 8, and phpMyAdmin. Includes a clean project structure, Makefile shortcuts, and CI/CD-ready configuration. Built to streamline new Laravel project creation for freelance and production workflows.

---

## Features

- PHP 8.2 container with Composer
- MySQL 8 database container
- phpMyAdmin for database management (port 8081)
- Dockerized development environment
- Makefile shortcuts for common tasks
- Clean Laravel-optimized .gitignore
- CI/CD-ready structure
- Standardized folder layout for repeatable workflows

---

## Architecture

laravel-starter/
├── docker/
│   └── app/
│       └── Dockerfile
├── docker-compose.yml
├── Makefile
├ — Stop containers
make restart  — Restart stack
make bash     — Enter PHP container
make migrate  — Run migrations
make seed     — Run seeders
make fresh    — Fresh migrate + seed
make test     — Run tests
make optimize — Optimize Laravel

---

## Project Structure (After Laravel Install)

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

---

## Deployment Notes

- .env is never committed
- Local .env stays local; server .env stays on the server
- Works with SSH-based deployment and GitHub Actions

---

## Author

brnagn7  
Laravel • Docker • CI/CD • Freelance Development

