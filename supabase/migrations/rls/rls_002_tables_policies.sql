-- rls_002_tables_policies.sql

-- ENABLE RLS
ALTER TABLE public.jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.candidates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.job_candidate_matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_summaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.processing_jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- Policies: allow select/insert/update by org members; restrict destructive actions to admins

-- Jobs: members can select/insert (insert must set organization_id = their org)
CREATE POLICY jobs_org_read ON public.jobs FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY jobs_org_insert ON public.jobs FOR INSERT WITH CHECK (is_org_member(organization_id));
CREATE POLICY jobs_admin_modify ON public.jobs FOR UPDATE, DELETE USING (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.jobs.organization_id AND m.role = 'admin')
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.jobs.organization_id AND m.role = 'admin')
);

-- Uploads: uploader (org member) can insert; members can view
CREATE POLICY uploads_org_read ON public.uploads FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY uploads_org_insert ON public.uploads FOR INSERT WITH CHECK (is_org_member(organization_id));
CREATE POLICY uploads_admin_modify ON public.uploads FOR UPDATE, DELETE USING (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.uploads.organization_id AND m.role = 'admin')
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.uploads.organization_id AND m.role = 'admin')
);

-- Candidates
CREATE POLICY candidates_org_read ON public.candidates FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY candidates_org_insert ON public.candidates FOR INSERT WITH CHECK (is_org_member(organization_id));
CREATE POLICY candidates_admin_modify ON public.candidates FOR UPDATE, DELETE USING (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.candidates.organization_id AND m.role = 'admin')
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.candidates.organization_id AND m.role = 'admin')
);

-- Matches & summaries
CREATE POLICY matches_org_read ON public.job_candidate_matches FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY matches_org_insert ON public.job_candidate_matches FOR INSERT WITH CHECK (is_org_member(organization_id));
CREATE POLICY summaries_org_read ON public.ai_summaries FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY summaries_org_insert ON public.ai_summaries FOR INSERT WITH CHECK (is_org_member(organization_id));

-- Processing jobs: only server/service role normally manipulates these, but allow org members to see
CREATE POLICY processing_org_read ON public.processing_jobs FOR SELECT USING (is_org_member(organization_id));
CREATE POLICY processing_admin_manage ON public.processing_jobs FOR INSERT, UPDATE, DELETE USING (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.processing_jobs.organization_id AND m.role = 'admin')
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.processing_jobs.organization_id AND m.role = 'admin')
);

-- Audit logs: only admins can read
CREATE POLICY audit_admin_read ON public.audit_logs FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.memberships m WHERE m.user_id = auth.uid() AND m.organization_id = public.audit_logs.organization_id AND m.role = 'admin')
);
