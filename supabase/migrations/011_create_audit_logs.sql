-- 011_create_audit_logs.sql
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid,
  user_id uuid,
  action text,
  resource jsonb,
  ip inet,
  created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_audit_org ON public.audit_logs (organization_id, created_at);
