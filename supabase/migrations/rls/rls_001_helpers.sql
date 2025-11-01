-- rls_001_helpers.sql
CREATE OR REPLACE FUNCTION public.is_org_member(org uuid) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.memberships m WHERE m.organization_id = org AND m.user_id = auth.uid()
  );
$$;
