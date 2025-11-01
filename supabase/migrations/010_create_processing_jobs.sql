-- 010_create_processing_jobs.sql
CREATE TABLE IF NOT EXISTS public.processing_jobs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid,
  type text CHECK (type IN ('extract_text','parse_candidate','match_to_job','generate_summary')),
  payload jsonb,
  status text CHECK (status IN ('queued','running','failed','done')) DEFAULT 'queued',
  attempts int DEFAULT 0,
  last_error text,
  started_at timestamptz,
  finished_at timestamptz,
  created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_processing_status ON public.processing_jobs (status, created_at);
