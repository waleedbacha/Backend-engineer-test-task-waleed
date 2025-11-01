-- 009_create_job_candidate_matches.sql
CREATE TABLE IF NOT EXISTS public.job_candidate_matches (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  job_id uuid NOT NULL REFERENCES public.jobs(id) ON DELETE CASCADE,
  candidate_id uuid NOT NULL REFERENCES public.candidates(id) ON DELETE CASCADE,
  score numeric CHECK (score >= 0 AND score <= 100),
  match_json jsonb,
  summary_id uuid REFERENCES public.ai_summaries(id),
  created_at timestamptz DEFAULT now(),
  UNIQUE (job_id, candidate_id)
);
CREATE INDEX IF NOT EXISTS idx_matches_job_score ON public.job_candidate_matches (job_id, score DESC);
