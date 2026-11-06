# IBUKU &bull; Secure Certificate Name Registration Portal

A secure, high-integrity certificate name registration portal built with **Vue.js 3 (Vite SPA)**, **Ruby on Rails 7 (API mode)**, and **PostgreSQL**, styled with the **Gruvbox Light Mode** palette based on archival letterpress ledger design specifications.

---

## Architecture Overview

```
                                      +------------------------------------+
                                      |         Browser Client (Vue 3)     |
                                      |     Gruvbox Light Mode Interface   |
                                      +-----------------+------------------+
                                                        |
                                          HTTP REST API | Port 3000
                                       (Stateless Bearer| Token / Public)
                                                        v
                                      +------------------------------------+
                                      |         Ruby on Rails API          |
                                      |     (Stateless BCrypt/JWT Auth)    |
                                      +-----------------+------------------+
                                                        |
                                            ActiveRecord| Port 5432
                                                        v
                                      +------------------------------------+
                                      |        PostgreSQL Database         |
                                      |    Unique Composite Index Enforced |
                                      +------------------------------------+
```

### 1. Database Schema & Relational Integrity

* **Admins (`admins`)**:
  - `email` (string, unique, lowercase normalized)
  - `name` (string)
  - `role` (string)
  - `otp_digest` (string, BCrypt hash of one-time passcode)
  - `otp_sent_at` (datetime, 10-minute validity window)
* **Courses (`courses`)**:
  - `name` (string, e.g., "Advanced Systems Architecture & Distributed Systems")
  - `course_code` (string, unique indexed, e.g., `CS-4091`)
  - `start_date` (date)
  - `end_date` (date)
  - `registration_deadline` (datetime, strict cutoff validation)
  - `department` (string)
  - `cohort` (string)
  - `admin_id` (foreign key -> `admins.id`)
* **Registrations (`registrations`)**:
  - `course_id` (foreign key -> `courses.id`)
  - `key_number` (string, student token e.g., `KEY-8824-A`)
  - `full_name` (string, official legal specification)
  - `email` (string)
  - `status` (string, default: `confirmed`, `pending_review`)
  - `ledger_hash` (string, SHA-256 cryptographic digest)
  - **Constraint:** `add_index :registrations, [:course_id, :key_number], unique: true` (strictly prevents duplicate key registrations for a single course at the database engine level).

---

## WSL2 Development Environment Optimization

When developing on Windows Subsystem for Linux (WSL2):

1. **Host Binding for Network Access:**
   - Rails must bind to `0.0.0.0` (`rails s -b 0.0.0.0 -p 3000`) so that Windows browsers at `localhost:3000` can connect across the WSL virtual network switch.
   - Vite is configured with `server: { host: '0.0.0.0', port: 5173, strictPort: true }` in `vite.config.js`.

2. **Filesystem Watchers (Inotify Polling):**
   - File events crossing the Windows mount (`/mnt/c/...`) frequently drop Linux `inotify` signals.
   - Vite is configured with `watch: { usePolling: true, interval: 100 }` to guarantee instant Hot Module Replacement (HMR).

3. **CORS Headers (`rack-cors`):**
   - Rails `config/initializers/cors.rb` explicitly whitelists `http://localhost:5173` and `http://127.0.0.1:5173`.

---

## Quick Setup & Execution

### Option A: Local WSL2 Native Setup

#### 1. PostgreSQL Service
```bash
sudo service postgresql start
# Create development database user if not present:
sudo -u postgres createuser -s postgres
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
```

#### 2. Backend (Ruby on Rails)
```bash
cd backend

# Install Ruby gems
bundle install

# Setup database, run migrations, and load initial seeds
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start Rails API server (listening on 0.0.0.0 for WSL2 forwarding)
bin/rails server -b 0.0.0.0 -p 3000
```

#### 3. Frontend (Vue 3 SPA)
```bash
cd frontend

# Install node dependencies
npm install

# Run Vite development server
npm run dev
```
Open **`http://localhost:5173`** in your browser.

---

### Option B: Docker Compose (One-Command Stack)

```bash
docker compose up --build
```
This automatically provisions PostgreSQL, runs `rails db:prepare` + `db:seed`, and starts both services on `localhost:3000` and `localhost:5173`.

---

## Seeded Super-Admin & Test Data

The database seed provisions:
* **Default Primary Super-Admin:** `mithibeirungu@gmail.com` (Mithibe Irungu - Super-Admin L4)
  - Has full permissions to manage courses and provision/register new administrators.
  - Automatically bootstrapped on the fly if not yet in database.
* **Secondary Registrar Officer:** `registrar@ibuku.edu` (Prof. V. Sterling)
* **Sample Course:** `CS-4091` (Advanced Systems Architecture & Distributed Systems)
* **Sample Registrations:**
  - `KEY-7712-B` &rarr; Alexander M. Thorne (Confirmed)
  - `KEY-8824-A` &rarr; Dr. Eleanor Vance, M.Sc. (Confirmed)
  - `KEY-9102-C` &rarr; Marcus Chen (Pending Review)
  - `KEY-3301-D` &rarr; Sophia Kowalski (Confirmed)
  - `KEY-5542-E` &rarr; David O. Adeleke (Pending Review)

---

## Security & Architectural Design

### 1. Stateless OTP Authentication
- Admins request an access code via `/api/v1/auth/request_otp`.
- Rails generates a 6-digit cryptographically secure number (`SecureRandom.random_number(100_000..999_999)`).
- The raw OTP is hashed using `BCrypt::Password.create` into `otp_digest` and stored with a timestamp. The plaintext is never stored.
- Upon verification via `/api/v1/auth/verify_otp`, the OTP is validated, immediately wiped to prevent replay attacks, and a stateless HS256 JWT bearer token is issued containing expiration and admin metadata.
- In `development` mode, the response also includes `dev_otp` so developers can sign in without configuring external SMTP services.

### 2. Duplicate Registration Interception
- When a student registers on `/courses/:course_code/register`, entering an already-enrolled key number (`KEY-8824-A`) intercepts the request without raising a database conflict.
- The backend identifies the existing record and returns a HTTP 200 payload with `intercepted: true` and a redirect URL directly to their certificate record.
- If a race condition bypasses the controller check, the PostgreSQL composite index `[:course_id, :key_number]` rejects the insert with an `ActiveRecord::RecordNotUnique` exception.

### 3. Strict Cutoff Dates
- Before accepting a registration or name edit, the course's `registration_deadline` is validated against `Time.current`. Once passed, all mutations are locked.

### 4. Cryptographic Proof Slip & CSV Export
- Each registration calculates a SHA-256 hash digest derived from the course ID, student key, full name, and creation timestamp.
- The Admin Dashboard includes a 1-click **Download CSV / XLSX** export button for bulk graduation rolls and data transformation pipelines.

