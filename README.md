# Backend Test – Waleed Badshah

This project contains the database schema and Row Level Security (RLS) setup for the backend engineer test.

### 📂 Folder Structure
- `supabase/migrations/` – All SQL schema files.
- `supabase/seed.sql` – Sample data seeding.
- `.env.example` – Example environment configuration.

### 🧠 RLS Summary
The RLS policies ensure that users can only access records belonging to their organization, following roles: `admin`, `recruiter`, and `viewer`.
