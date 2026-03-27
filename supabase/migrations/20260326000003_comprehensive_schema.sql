-- Comprehensive Schema Update for Meridian

-- 1. Update tasks to support shared group boards
ALTER TABLE public.tasks ADD COLUMN group_id UUID REFERENCES public.study_groups(id) ON DELETE CASCADE;

-- Update RLS for tasks to allow group members to see tasks
DROP POLICY IF EXISTS "Users can manage their own tasks" ON public.tasks;
CREATE POLICY "Users can manage their own tasks" ON public.tasks 
FOR ALL USING (
  auth.uid() = user_id OR 
  EXISTS (
    SELECT 1 FROM public.study_group_members 
    WHERE group_id = public.tasks.group_id AND user_id = auth.uid()
  )
);

-- 2. Study Sessions Table (F-07)
CREATE TABLE public.study_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  goal_id UUID REFERENCES public.goals(id) ON DELETE SET NULL,
  course_id UUID REFERENCES public.courses(id) ON DELETE SET NULL,
  duration_min INTEGER NOT NULL,
  started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  ended_at TIMESTAMPTZ,
  notes TEXT,
  pomodoros_completed INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Journal Entries (F-11 Weekly AI Reflection)
CREATE TABLE public.journal_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  entry_date DATE NOT NULL DEFAULT CURRENT_DATE,
  entry_type TEXT DEFAULT 'reflection', -- reflection, win, goal, etc.
  is_ai_generated BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Interview Prep (F-14)
CREATE TABLE public.interview_prep (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_application_id UUID NOT NULL REFERENCES public.job_applications(id) ON DELETE CASCADE,
  questions JSONB NOT NULL DEFAULT '[]', -- Array of likely questions
  answers JSONB NOT NULL DEFAULT '[]',    -- User's recorded/typed answers
  ai_feedback JSONB,                       -- Feedback per answer
  confidence_score INTEGER CHECK (confidence_score BETWEEN 0 AND 100),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Notifications (10.4)
CREATE TABLE public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  type TEXT NOT NULL, -- briefing, deadline, follow_up, weekly_review
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  action_url TEXT,
  read_at TIMESTAMPTZ,
  scheduled_at TIMESTAMPTZ NOT NULL,
  sent_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Subscriptions (Section 13)
CREATE TABLE public.subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  plan TEXT NOT NULL DEFAULT 'free', -- free, pro, team
  status TEXT NOT NULL, -- active, cancelled, paused, trialing
  provider TEXT, -- razorpay, stripe, apple, google
  provider_subscription_id TEXT,
  provider_customer_id TEXT,
  current_period_start TIMESTAMPTZ,
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN DEFAULT FALSE,
  cancelled_at TIMESTAMPTZ,
  country_code TEXT,
  ppp_tier NUMERIC(3,2) DEFAULT 1.0, -- Purchasing Power Parity multiplier
  price_paid INTEGER, -- In smallest currency unit
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. Institutions (F-15 B2B Dashboard)
CREATE TABLE public.institutions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  domain TEXT UNIQUE NOT NULL,
  country TEXT,
  seat_count INTEGER DEFAULT 0,
  contract_start DATE,
  contract_end DATE,
  admin_user_id UUID REFERENCES public.users(id),
  sso_config JSONB DEFAULT '{}',
  branding JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. Add institution_id to users
ALTER TABLE public.users ADD COLUMN institution_id UUID REFERENCES public.institutions(id) ON DELETE SET NULL;

-- Row Level Security (RLS)
ALTER TABLE public.study_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.interview_prep ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.institutions ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can manage their own study sessions" ON public.study_sessions FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can manage their own journal entries" ON public.journal_entries FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can see their own interview prep" ON public.interview_prep FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM public.job_applications 
    WHERE id = public.interview_prep.job_application_id AND user_id = auth.uid()
  )
);
CREATE POLICY "Users can manage their own interview prep" ON public.interview_prep FOR ALL USING (
  EXISTS (
    SELECT 1 FROM public.job_applications 
    WHERE id = public.interview_prep.job_application_id AND user_id = auth.uid()
  )
);
CREATE POLICY "Users can manage their own notifications" ON public.notifications FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Users can see their own subscriptions" ON public.subscriptions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Institution admins can see their institution" ON public.institutions FOR SELECT USING (auth.uid() = admin_user_id);

-- 9. Cron Jobs Setup (Requires pg_cron extension)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule Daily Briefing Generation (Placeholder for Edge Function call)
-- This cron job should run hourly and check if a briefing needs to be generated for any user
-- whose local wake time (converted to UTC) matches the current hour.
-- The actual logic would call the generate-briefing edge function.
-- SELECT cron.schedule('generate-briefings', '0 * * * *', $$
--   SELECT
--     net.http_post(
--       url:='https://<project-id>.supabase.co/functions/v1/generate-briefing',
--       headers:='{"Content-Type": "application/json", "Authorization": "Bearer <service-role-key>"}'::jsonb,
--       body:='{}'::jsonb
--     ) as request_id;
-- $$);

-- Schedule Notification Dispatch (Runs every minute)
-- SELECT cron.schedule('dispatch-notifications', '* * * * *', $$
--   SELECT
--     net.http_post(
--       url:='https://<project-id>.supabase.co/functions/v1/process-notifications',
--       headers:='{"Content-Type": "application/json", "Authorization": "Bearer <service-role-key>"}'::jsonb,
--       body:='{}'::jsonb
--     ) as request_id;
-- $$);
