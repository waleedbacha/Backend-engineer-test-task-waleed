-- 005_create_jobs.sql
CREATE TABLE IF NOT EXISTS public.jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text,
  requirements jsonb,
  location text,
  created_by uuid,
  created_at timestamptz DEFAULT now(),
  is_active boolean DEFAULT true
);
CREATE INDEX IF NOT EXISTS idx_jobs_org_created ON public.jobs (organization_id, created_at);
