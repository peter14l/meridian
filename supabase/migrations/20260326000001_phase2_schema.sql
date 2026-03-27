-- Phase 2 Schema for Meridian AI & Primary Workflows

-- Daily Briefings
CREATE TABLE public.daily_briefings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  content_json JSONB NOT NULL,
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  dismissed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Job Applications
CREATE TYPE job_status AS ENUM ('saved', 'applied', 'oa', 'interview', 'offer', 'rejected');

CREATE TABLE public.job_applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  company TEXT NOT NULL,
  role TEXT NOT NULL,
  job_url TEXT,
  location TEXT,
  salary_range TEXT,
  status job_status DEFAULT 'saved',
  applied_at TIMESTAMPTZ,
  resume_version_id UUID,
  notes TEXT,
  follow_up_sent_at TIMESTAMPTZ,
  next_follow_up_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- Saved Items (Smart Capture)
CREATE TYPE saved_tag AS ENUM ('article', 'job', 'resource', 'tool', 'research');

CREATE TABLE public.saved_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  url TEXT NOT NULL,
  title TEXT,
  description TEXT,
  tag saved_tag,
  suggested_goal_id UUID REFERENCES public.goals(id) ON DELETE SET NULL,
  suggested_course_id UUID REFERENCES public.courses(id) ON DELETE SET NULL,
  ai_summary TEXT,
  ai_tags JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- AI Drafts
CREATE TABLE public.ai_drafts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  context_type TEXT NOT NULL,
  context_id UUID,
  prompt TEXT NOT NULL,
  response TEXT,
  model_used TEXT,
  tokens_used INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Row Level Security (RLS)
ALTER TABLE public.daily_briefings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.job_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saved_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_drafts ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can manage their own briefings" ON public.daily_briefings FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own job apps" ON public.job_applications FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own saved items" ON public.saved_items FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own AI drafts" ON public.ai_drafts FOR ALL USING (auth.uid() = user_id);
