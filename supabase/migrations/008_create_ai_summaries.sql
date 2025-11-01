-- 008_create_ai_summaries.sql
CREATE TABLE IF NOT EXISTS public.ai_summaries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  model text,
  summary text,
  tokens_used int,
  confidence numeric,
  created_at timestamptz DEFAULT now()
);
