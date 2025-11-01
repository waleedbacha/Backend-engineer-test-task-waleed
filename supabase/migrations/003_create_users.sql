-- 003_create_users.sql
CREATE TABLE IF NOT EXISTS public.users (
  id uuid PRIMARY KEY, -- use auth.uid() when creating profile (keep in sync with Supabase auth)
  email text UNIQUE,
  full_name text,
  created_at timestamptz DEFAULT now()
);
