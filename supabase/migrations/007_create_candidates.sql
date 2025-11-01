-- 007_create_candidates.sql
CREATE TABLE IF NOT EXISTS public.candidates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  upload_id uuid REFERENCES public.uploads(id) ON DELETE SET NULL,
  full_name text,
  email text,
  phone text,
  location text,
  experience_years numeric,
  skills text[],
  raw_text text,
  created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_candidates_org ON public.candidates (organization_id);
CREATE INDEX IF NOT EXISTS idx_candidates_skills_gin ON public.candidates USING gin (skills);
