-- 004_create_memberships.sql
CREATE TABLE IF NOT EXISTS public.memberships (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  role text NOT NULL CHECK (role IN ('admin','recruiter','viewer')) DEFAULT 'recruiter',
  created_at timestamptz DEFAULT now(),
  UNIQUE (organization_id, user_id)
);
