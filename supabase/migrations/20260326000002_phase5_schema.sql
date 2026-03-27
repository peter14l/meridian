-- Phase 5 Schema for Meridian social & career features

-- Resume Vault
CREATE TABLE public.resume_versions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  file_url TEXT NOT NULL,
  file_size INTEGER,
  is_primary BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Study Groups
CREATE TABLE public.study_groups (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  invite_code TEXT UNIQUE NOT NULL,
  created_by UUID NOT NULL REFERENCES public.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Study Group Members
CREATE TYPE group_role AS ENUM ('admin', 'member');

CREATE TABLE public.study_group_members (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id UUID NOT NULL REFERENCES public.study_groups(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  role group_role DEFAULT 'member',
  joined_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(group_id, user_id)
);

-- Study Group Messages (for in-app messaging)
CREATE TABLE public.group_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id UUID NOT NULL REFERENCES public.study_groups(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security (RLS)
ALTER TABLE public.resume_versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.study_group_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.group_messages ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can manage their own resumes" ON public.resume_versions FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users can see groups they belong to" ON public.study_groups 
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.study_group_members 
    WHERE group_id = public.study_groups.id AND user_id = auth.uid()
  )
);

CREATE POLICY "Users can manage groups they created" ON public.study_groups 
FOR ALL USING (created_by = auth.uid());

CREATE POLICY "Members can see other members" ON public.study_group_members 
FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.study_group_members AS m
    WHERE m.group_id = public.study_group_members.group_id AND m.user_id = auth.uid()
  )
);

CREATE POLICY "Members can see and send messages" ON public.group_messages 
FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.study_group_members 
    WHERE group_id = public.group_messages.group_id AND user_id = auth.uid()
  )
);
