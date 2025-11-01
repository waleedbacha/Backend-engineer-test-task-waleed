-- 006_create_uploads.sql
CREATE TABLE IF NOT EXISTS public.uploads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id uuid NOT NULL REFERENCES public.organizations(id) ON DELETE CASCADE,
  uploaded_by uuid,
  storage_path text NOT NULL,
  file_name text,
  content_type text,
  size_bytes bigint,
  status text CHECK (status IN ('pending','processing','processed','failed')) DEFAULT 'pending',
  created_at timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_uploads_org_status ON public.uploads (organization_id, status);
