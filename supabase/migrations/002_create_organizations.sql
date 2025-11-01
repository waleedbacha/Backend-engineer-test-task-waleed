-- 002_create_organizations.sql
CREATE TABLE IF NOT EXISTS public.organizations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  domain text,
  created_at timestamptz DEFAULT now()
);
