-- seed_full.sql
INSERT INTO public.organizations (id, name, domain, created_at)
VALUES ('11111111-1111-1111-1111-111111111111','Acme Recruiting','acme.com', now())
ON CONFLICT (id) DO NOTHING;

-- create a user (replace id with your auth.uid() for real tests if needed)
INSERT INTO public.users (id, email, full_name, created_at)
VALUES ('22222222-2222-2222-2222-222222222222','recruiter@acme.com','Test Recruiter', now())
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.memberships (organization_id, user_id, role, created_at)
VALUES ('11111111-1111-1111-1111-111111111111','22222222-2222-2222-2222-222222222222','admin', now())
ON CONFLICT (organization_id, user_id) DO NOTHING;

INSERT INTO public.jobs (organization_id, title, description, requirements, created_by)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  'Frontend React Developer',
  'Build user-facing applications in React.js',
  '["React.js","Redux","HTML","CSS"]',
  '22222222-2222-2222-2222-222222222222'
) ON CONFLICT DO NOTHING;

INSERT INTO public.uploads (organization_id, uploaded_by, storage_path, file_name, content_type, size_bytes, status, created_at)
VALUES ('11111111-1111-1111-1111-111111111111','22222222-2222-2222-2222-222222222222','cvs/sample_ali_khan.pdf','sample_ali_khan.pdf','application/pdf',50000,'processed', now())
ON CONFLICT DO NOTHING;

INSERT INTO public.candidates (organization_id, upload_id, full_name, email, phone, skills, experience_years, raw_text, created_at)
VALUES (
  '11111111-1111-1111-1111-111111111111',
  (SELECT id FROM public.uploads WHERE file_name='sample_ali_khan.pdf' LIMIT 1),
  'Ali Khan','ali@example.com','03001234567', ARRAY['React.js','Redux','HTML','CSS'], 3, 'Sample CV text with React experience', now()
)
ON CONFLICT DO NOTHING;
