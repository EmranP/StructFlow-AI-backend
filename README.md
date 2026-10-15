# StructFlow — AI Project Structure Generator

<div align="center">

![StructFlow Banner](https://img.shields.io/badge/StructFlow-AI%20Powered-6366f1?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHRleHQgeT0iMjAiIGZvbnQtc2l6ZT0iMjAiPuKmoTwvdGV4dD48L3N2Zz4=)

![Angular](https://img.shields.io/badge/Angular-17-DD0031?style=flat-square&logo=angular)
![Go](https://img.shields.io/badge/Go-1.25-00ADD8?style=flat-square&logo=go)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat-square&logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-ready-2496ED?style=flat-square&logo=docker)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**Describe your project → AI designs the folder structure → Download and start coding**

[frontend](https://github.com/EmranP/StructFlow-AI-frontend)

</div>

---

## 📋 Table of Contents

- [About](#-about)
- [Setups](#️-setups)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
  - [Prerequisites](#prerequisites)
- [Database Schema](#-database-schema)

---

## 🧠 About

**StructFlow** is a full-stack web application that uses AI to generate project directory structures based on a developer's description. Instead of manually creating dozens of folders and files when starting a new project, you describe what you're building and the AI instantly produces multiple architecture variants — from a simple starter layout to a full enterprise-grade modular structure.

### The Problem

Every developer knows the pain of starting a new project:

- Googling "go project structure clean architecture" for the 10th time
- Copy-pasting folder layouts from old projects
- Spending 30 minutes creating files before writing a single line of code

### The Solution

Describe your project in plain text → StructFlow generates 3 ready-to-use directory structures → Download as a ZIP and start coding immediately.

---

## ⚙️ Setups

```bash
# Clone the repository
git clone https://github.com/your-username/structflow.git
cd structflow/backend

# Install dependencies
go mod download

# Copy environment config
cp .env.example .env
# Edit .env with your values

# Run database migrations
make migrate-up

# Start the server
make run
# or
go run cmd/main.go || air
```

**With Docker:**

### Step 1

```bash
# Run database migrations
make migrate-up
```

### Step 2

```bash
make up # or make up-d (background running)
```

### Work with DB (pgAdmin and GUI)

### 1. Web-UI pgAdmin (Docker)

The service is deployed in Docker for convenient database management. **pgAdmin**.

1. Open a browser and navigate to: [http://localhost:**port-pgadmin**](http://localhost:port-pgadmin)
2. Log in using the data from the file `.env`:
   - **Email:** `PGADMIN_EMAIL` (`pgadmin@admin.com`)
   - **Password:** `PGADMIN_PASS` (`12345`)
3. To add a database, click **Add New Server**:
   - **Tab General:**
     - **Name:** `SF-AI-DB` (any name)
   - **Tab Connection:**
     - **Host name/address:** `db` (name services PostgreSQL in the docker-network)
     - **Port:** `5432`
     - **Maintenance database:** `sf-ai-db` (value `POSTGRES_DB`)
     - **Username:** `emran_developer` (value `POSTGRES_USER`)
     - **Password:** `123456` (value `POSTGRES_PASSWORD`)
4. Click **Save**.

### 2. Connecting via a third-party GUI (DBeaver, DataGrip, Postico)

If you want to connect to the database directly from your local machine via a third-party client, use the port forwarded through the `port forwarder`:

- **Host:** `localhost` or `127.0.0.1`, (if db running in the docker + local `host.docker.internal`)
- **Port:** `5433` (passed through socat port-forwarder)
- **Database:** `sf-ai-db`
- **Username:** `emran_developer`
- **Password:** `qwert`

---

## ✨ Features

| Feature                      | Description                                                         |
| ---------------------------- | ------------------------------------------------------------------- |
| 🤖 **AI Generation**         | Describe your project in natural language, AI designs the structure |
| 📐 **3 Complexity Levels**   | Simple, Medium, Enterprise variants for every project size          |
| 📁 **Interactive File Tree** | Visual collapsible tree viewer with file type icons                 |
| 📦 **ZIP Download**          | Download the full directory structure instantly                     |
| 🔄 **Live Status Polling**   | Real-time generation progress with animated UI                      |
| 🗂️ **Project Management**    | Create, edit, delete projects with full history                     |
| 📜 **Generation History**    | Track all past generations per project with pagination              |
| 🔐 **JWT Auth**              | Secure authentication with protected routes                         |

---

## 🛠 Tech Stack

### Backend

| Technology     | Version | Purpose          |
| -------------- | ------- | ---------------- |
| **Go**         | 1.25.5  | Core language    |
| **Fiber**      | v2      | HTTP framework   |
| **PostgreSQL** | —       | Primary database |
| **JWT**        | —       | Authentication   |
| **Docker**     | —       | Containerization |

### Frontend

| Technology         | Version | Purpose                    |
| ------------------ | ------- | -------------------------- |
| **Angular**        | 17      | Core framework             |
| **TypeScript**     | 5.x     | Language                   |
| **SCSS**           | —       | Styling with CSS variables |
| **Angular Router** | —       | Client-side routing        |
| **HttpClient**     | —       | HTTP with JWT interceptor  |
| **Signals**        | —       | Reactive state             |

---

## 🚀 Architecture

### Prerequisites

- **Go** `1.21+`
- **Node.js** `18+`
- **PostgreSQL** `14+`
- **Docker** (optional, recommended for up db, swagger)

---

## 🗄 Database Schema

```sql
-- Users
users (id UUID PK, email VARCHAR UNIQUE, password_hash TEXT, created_at, updated_at)

-- Projects
projects (
  id UUID PK,
  user_id UUID FK → users,
  title VARCHAR,
  project_type VARCHAR,
  stack TEXT,
  architecture TEXT,
  features TEXT,
  additional_info TEXT,
  created_at, updated_at
)

-- Generations
generations (
  id UUID PK,
  project_id UUID FK → projects,
  status VARCHAR,       -- pending | process | completed | failed
  error_message TEXT,
  created_at, updated_at
)

-- Templates
templates (
  id UUID PK,
  generation_id UUID FK → generations,
  name VARCHAR,
  description TEXT,
  structure_json JSONB,
  created_at
)

-- Generated Templates (final output)
generated_templates (
  id UUID PK,
  generation_id UUID FK → generations,
  type VARCHAR,         -- simple | medium | enterprise
  content JSONB,        -- { files: [...], directories: [...] }
  created_at
)
```

**Relationships:**

---

<div align="center">
Built with ❤️ by developers, for developers
</div>
