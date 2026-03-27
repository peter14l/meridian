**◈ MERIDIAN**

_Your AI-Powered Student Command Center_

Product Requirements Document · v1.0

_Confidential — Founder Copy_

# **Table of Contents**

1\. Product Vision & Mission

2\. Target Platforms

3\. User Personas

4\. Design System — UI/UX Philosophy

5\. Color Schemes: Light & Dark Mode

6\. Full Feature Specification (MVP → Advanced)

7\. Detailed User Workflows

8\. Database Architecture & Diagrams

9\. Tech Stack

10\. Backend Architecture

11\. Frontend Architecture

12\. AI Components & Design

13\. Pricing Strategy (PPP-adjusted)

14\. Build Cost Analysis

15\. Versioning Roadmap

# **1\. Product Vision & Mission**

### **Vision**

Meridian is the calm, intelligent layer that sits between a student's chaos and their goals — aggregating their deadlines, learning resources, job hunt, and daily priorities into one proactive, beautiful command center.

### **Mission**

Replace the anxiety of fragmented tools with a single AI-native surface that tells students what matters today, not what was saved last week.

### **Core Philosophy**

- Proactive over reactive — the app surfaces things, you don't hunt for them
- Calm over noisy — no badge overload, no notification spam
- Action over storage — every screen leads to something you can do right now
- Beautiful by default — design is a product differentiator, not a layer on top

# **2\. Target Platforms**

### **Primary (Launch)**

| **Platform** | **Priority** | **Rationale** |
| --- | --- | --- |
| Android (Flutter) | P0 — Launch | Dominant in India & Southeast Asia, your initial market |
| iOS (Flutter) | P0 — Launch | Needed for global & premium users; shared codebase with Android |
| Web App (Flutter Web) | P1 — 3 months post-launch | Laptop/desktop use-case for studying, job applications |

### **Secondary (Post-PMF)**

| **Platform** | **Priority** | **Rationale** |
| --- | --- | --- |
| macOS (Flutter Desktop) | P2 — v2.0 | Native experience for Mac-heavy college demographic |
| Windows (Flutter Desktop) | P2 — v2.0 | Broadens reach significantly |
| Browser Extension (JS) | P1 — v1.5 | Core to Smart Capture feature; Chrome + Firefox |

# **3\. User Personas**

### **Primary: The Overwhelmed Achiever**

|     |     |
| --- | --- |
| Age: 18–22<br><br>First/second year college student<br><br>Juggles 5 courses + internship hunt<br><br>Uses: Notion, Google Calendar, WhatsApp<br><br>Pain: Nothing talks to each other | Goal: Feel in control without spending time organising<br><br>Willing to pay: ₹250–500/mo<br><br>Platform: Android + occasional laptop<br><br>Tech comfort: High |

### **Secondary: The Career-Focused Junior**

|     |     |
| --- | --- |
| Age: 20–24<br><br>Third/fourth year, internship/placement season<br><br>Managing 10+ applications simultaneously<br><br>Pain: Forgetting to follow up, losing track | Goal: Structured job hunt without spreadsheet hell<br><br>Willing to pay: ₹400–800/mo<br><br>Platform: iOS + Web<br><br>Tech comfort: Very high |

# **4\. Design System — UI/UX Philosophy**

### **Core Principles**

- Calm UI — Maximum 3 actions visible at any time. No overwhelming dashboards.
- Spatial hierarchy — Important things are large, ambient things are small and muted.
- Micro-motion, not spectacle — Transitions serve navigation, never distraction.
- Honest feedback — Every AI action shows a subtle processing state, never instant fake results.
- One-handed mobile-first — All primary actions reachable in the thumb zone.

### **Typography**

| **Role** | **Font** | **Weight** | **Size** |
| --- | --- | --- | --- |
| Display / Hero | Plus Jakarta Sans | Bold 700 | 32–40sp |
| Heading 1 | Plus Jakarta Sans | SemiBold 600 | 24–28sp |
| Heading 2 | Plus Jakarta Sans | Medium 500 | 20sp |
| Body | Inter | Regular 400 | 15–16sp |
| Label / Caption | Inter | Regular 400 | 12–13sp |
| Monospace (code/data) | JetBrains Mono | Regular 400 | 14sp |

### **Spacing System (8pt grid)**

All spacing uses multiples of 8: 4, 8, 16, 24, 32, 48, 64, 80. No arbitrary values. This creates visual rhythm and makes the UI feel designed even at small sizes.

### **Corner Radius**

| **Element** | **Radius** |
| --- | --- |
| Cards & Sheets | 20dp |
| Buttons (primary) | 14dp |
| Input fields | 12dp |
| Chips & badges | 999dp (pill) |
| Bottom nav | 0dp (edge to edge) |

### **Motion & Transitions**

- Page transitions: Shared element transitions for navigating into detail views. Slide-up for modals. Fade-scale for overlays.
- List animations: Staggered fade-up on first load (30ms delay per item). No animation on scroll.
- AI components: Shimmer pulse while loading → content fades in with a subtle upward drift (translateY: 8px → 0, opacity 0 → 1, 300ms ease-out).
- Bottom sheet: Spring physics (friction: 0.8, tension: 180). Feels like lifting a card off a table.
- Button press: Scale 0.97 on press, 1.0 on release. 150ms. Haptic feedback on primary actions.
- Tab switches: Crossfade content (200ms). Icon fills on active state with a small bounce.

# **5\. Color Schemes: Light & Dark Mode**

### **Dark Mode (Default)**

| **Role** | **Hex** | **Usage** |
| --- | --- | --- |
| Background | #0F0F1A | App background — near black with a blue undertone |
| Surface | #1A1A2E | Cards, sheets, nav bar |
| Surface Elevated | #22223B | Modals, dropdown menus |
| Primary | #6C63FF | Buttons, active states, key highlights |
| Primary Muted | #3D3580 | Pressed states, secondary fills |
| Accent / Teal | #2DD4BF | Success indicators, progress bars |
| AI Glow Start | #818CF8 | Gradient border start (AI components) |
| AI Glow End | #C084FC | Gradient border end (AI components) |
| Text Primary | #F0EFFF | Main body text |
| Text Secondary | #9CA3AF | Labels, captions, placeholders |
| Divider | #2D2D4E | Subtle separators |
| Error | #FF6B6B | Error states |
| Warning | #FBBF24 | Warning/reminder indicators |

### **Light Mode**

| **Role** | **Hex** | **Usage** |
| --- | --- | --- |
| Background | #F8F7FF | App background — warm near-white |
| Surface | #FFFFFF | Cards, sheets |
| Surface Elevated | #EDEDFF | Modals, dropdowns |
| Primary | #5B52E8 | Buttons, active states (slightly deeper for contrast) |
| Primary Muted | #EAE8FF | Pressed states, icon backgrounds |
| Accent / Teal | #0D9488 | Success indicators, progress bars |
| AI Glow Start | #6366F1 | Gradient border start (AI components) |
| AI Glow End | #A855F7 | Gradient border end (AI components) |
| Text Primary | #1E1B4B | Main body text |
| Text Secondary | #6B7280 | Labels, captions |
| Divider | #E0E7FF | Subtle separators |
| Error | #DC2626 | Error states |
| Warning | #D97706 | Warning states |

### **AI Component — Gradient Border Glow Effect**

**Border Gradient Glow Specification**

Every AI-powered component (Daily Briefing card, AI Suggestions, Smart Capture result,

AI Draft previews) uses a signature gradient border glow to signal AI presence.

Dark Mode Implementation:

• Container: Surface (#1A1A2E) with 20dp corner radius

• Border: 1.5dp stroke, gradient from #818CF8 → #C084FC → #2DD4BF (135° angle)

• Outer glow: BoxShadow — spread 0, blur 18dp, color #818CF8 at 40% opacity

• Inner glow: BoxShadow inset — blur 8dp, color #6C63FF at 20% opacity

• Shimmer: While loading — animated gradient sweep from left to right, 1.4s loop

Light Mode Implementation:

• Container: White (#FFFFFF) with 20dp corner radius

• Border: 1.5dp stroke, gradient from #6366F1 → #A855F7 (135°)

• Outer glow: BoxShadow — spread 0, blur 14dp, color #6366F1 at 25% opacity

• No inner glow (too heavy on light bg)

Flutter Code Pattern:

Container → ShaderMask (gradient border) → ClipRRect → Stack:

\[BlurredGlowLayer, ContentCard\]

Use package: gradient_borders or custom CustomPainter

# **6\. Full Feature Specification**

_MVP = v1.0.0 | Core = v1.x | Advanced = v2.x | Complete = v3.x_

## **v1.0.0 — MVP (Weeks 1–8)**

### **F-01: Onboarding & Profile Setup**

- Sign up with Google OAuth or email/password
- Onboarding wizard: select your college, year, current courses (add up to 8)
- Set goals: Placement prep, CGPA target, skill learning, side projects
- Link Google Calendar (OAuth, optional but recommended)
- Set preferred wake-up time for Daily Briefing delivery

### **F-02: Daily AI Briefing**

**The hero feature. Every morning, Meridian generates a personalised briefing — a single scroll — that tells you what matters today.**

- Sections: Today's agenda (from calendar), Due soon (assignments), Job actions pending, Learning goal nudge
- AI writes each briefing in a warm, brief tone — 3 sentences max per section
- Generated fresh each morning at the user's wake-up time via background job
- Card uses AI gradient border glow (the signature visual treatment)
- One-tap dismiss each section; cleared sections remember state for the day

### **F-03: Unified Task & Deadline Manager**

- Manual task entry with title, due date, course tag, priority (P1–P3)
- Auto-import from Google Calendar events containing keywords (assignment, submit, exam, quiz)
- Kanban-lite view: Not started / In Progress / Done — swipe to move
- List view with sort by due date, priority, or course
- Overdue detection — red indicator, appears in Daily Briefing
- Recurring task support (weekly quizzes, lab reports, etc.)

### **F-04: Smart Capture (Browser Extension + In-App)**

- Browser Extension (Chrome/Firefox): One-click save any URL — article, job posting, YouTube video, docs
- In-app: Share-sheet integration on mobile (save from any app)
- AI auto-tags each saved item: Article / Job / Resource / Tool / Research
- AI suggests which Goal or Course the item is relevant to
- Saved library with filter by tag, course, date

### **F-05: Job Hunt Tracker**

- Add a job application: Company, Role, Date Applied, Status, Link, Notes
- Status pipeline: Saved → Applied → OA/Test → Interview → Offer / Rejected
- AI follow-up reminder: auto-suggests following up if no response in 7 days
- AI email drafter: generates a follow-up email for any application in one tap
- Summary stats: Total applied, response rate, interview conversion

### **F-06: Core Settings & Preferences**

- Dark / Light / System mode toggle
- Notification preferences (briefing time, reminder types)
- Connected accounts management (Google Calendar)
- Course management (add/edit/remove courses)
- Data export (JSON) and account deletion

## **v1.x — Core Features (Months 3–6)**

### **F-07: AI Study Session Planner**

- Input: upcoming exams/deadlines + available time slots
- Output: a personalised study schedule distributed across days
- AI adjusts schedule if you mark a session as skipped
- Pomodoro timer integrated per session with session notes

### **F-08: Resource Linker & Goal Graph**

- Create learning Goals (e.g. "Learn React", "DSA for Placements")
- Attach saved resources, tasks, and notes to each goal
- Visual progress ring per goal based on completed tasks / resources consumed
- AI suggests next resource to consume based on goal and what you've already done

### **F-09: Smart Inbox**

- Connect Gmail (read-only, scoped to recruitment emails)
- AI auto-detects and surfaces: recruiter messages, interview invites, OA links, rejections
- One-tap: Add to Job Tracker from a detected email
- No email management — purely extraction and surfacing

### **F-10: Collaboration (Study Groups)**

- Create or join a study group (up to 10 members)
- Shared task board — assign tasks to members, track collectively
- Group briefing: "Your group has 3 tasks due this week"
- In-app messaging (lightweight, Supabase Realtime)

### **F-11: Weekly Review & AI Reflection**

- Every Sunday: AI generates a Weekly Review card
- Content: tasks completed, missed, job hunt progress, study hours, wins
- Tone: encouraging, specific, not generic ("You completed 8/10 tasks — better than last week")
- One reflection prompt for the user to respond to (stored as a journal entry)

### **F-12: Resume Vault**

- Upload up to 5 resume versions (PDF)
- Tag each version (General / Frontend / Data Science / etc.)
- When adding a job application, select which resume version was used
- AI: suggests which resume version to use based on job description (paste JD → get recommendation)

## **v2.x — Advanced Features (Months 7–12)**

### **F-13: AI Course Assistant**

- Upload syllabus PDF or paste course outline
- AI generates topic map and flags high-weightage areas
- Ask questions about course material — RAG over uploaded notes
- AI generates 5 practice questions per topic on demand
- NOT a replacement for NotebookLM — this is syllabus-aware and exam-focused

### **F-14: Interview Prep Mode**

- Add a scheduled interview to Job Tracker
- AI generates 10 likely questions based on role + company
- Mock answer flow: record or type answer → AI gives structured feedback
- Track prep progress per interview: questions practiced, confidence score

### **F-15: Institutional Dashboard (B2B)**

- College admin portal (web): view aggregate usage stats for their students
- Bulk seat management and SSO integration
- Custom branding per institution
- Analytics: engagement rates, feature usage, cohort benchmarks

### **F-16: Widgets & Lock Screen (Mobile)**

- Android/iOS Home Screen widget: today's top 3 tasks + briefing summary
- Lock screen widget (iOS 16+, Android 14+): next deadline countdown
- Dynamic Island integration (iOS) — active Pomodoro timer

### **F-17: Offline Mode & Local-First Sync**

- All core data available offline (tasks, saved resources, job tracker)
- Background sync when connection restored
- Conflict resolution: last-write-wins with user override on conflicts

## **v3.x — Complete Product (Year 2)**

### **F-18: Meridian AI Agent**

- Conversational AI that knows your full context (tasks, goals, applications, notes)
- "What should I work on this evening?" → AI gives reasoned suggestion based on deadlines + energy
- "Draft a cold email to this company" → uses your resume + job context
- "Am I on track for placements?" → honest progress assessment

### **F-19: Career Roadmap**

- Input: target role + timeline
- Output: skill gaps, learning path, project suggestions, timeline to readiness
- Connects to Goal Graph — automatically creates goals and links resources

### **F-20: Integrations Marketplace**

- Notion sync (two-way task sync)
- GitHub activity feed (contributions appear as study activity)
- LinkedIn Easy Apply tracker (auto-detect applications via extension)
- Slack/Discord study group integration

# **7\. Detailed User Workflows**

### **Workflow 1: Morning Routine**

1.  User opens app at their set briefing time
2.  Home screen shows the Daily Briefing card (AI glow border, prominent)
3.  Briefing loads with: Today's calendar events, 2 upcoming deadlines, 1 job action, 1 learning nudge
4.  User taps any section to expand into full view
5.  User taps "Mark done" on completed tasks inline
6.  User taps "Draft follow-up" on a job application → AI email composer opens
7.  User dismisses briefing — it collapses to a small summary strip

### **Workflow 2: Smart Capture Flow**

1.  User is browsing — finds a useful DSA tutorial on YouTube
2.  Taps extension icon → "Save to Meridian" sheet opens
3.  AI pre-fills: Tag = Resource, Suggested Goal = "DSA for Placements"
4.  User confirms in 1 tap — item saved
5.  Next morning, briefing may include: "You saved 3 DSA resources this week. Ready to study?"

### **Workflow 3: Job Application Flow**

1.  User finds a job posting → saves via extension
2.  Extension detects job posting → offers "Add to Job Tracker"
3.  User opens Job Tracker → application pre-filled with company/role from AI extraction
4.  User sets status: Applied, attaches resume version used
5.  7 days later: app sends reminder "No response from Razorpay — follow up?"
6.  User taps → AI drafts a polite follow-up email → user reviews and sends via Gmail

### **Workflow 4: Study Session**

1.  User opens Study Planner → sees today's AI-scheduled sessions
2.  Taps session → Pomodoro timer starts (25 min work, 5 min break)
3.  Timer runs in foreground with DI/notification persistence
4.  After session, user adds brief notes (optional)
5.  Session marked complete → goal progress ring updates

# **8\. Database Architecture & Diagrams**

_Database: PostgreSQL via Supabase. All tables use UUID primary keys and soft deletes (deleted_at)._

### **Entity Relationship Overview**

**CORE SCHEMA — MERIDIAN DATABASE**

┌─────────────────────────────────────────────────────────────────┐

│ users │

│ id (UUID PK) │ email │ name │ avatar_url │ plan │ created_at │

│ college │ year │ wake_time │ timezone │ onboarded_at │

└──────────────────────────┬──────────────────────────────────────┘

│ 1 : many

┌───────────────┼───────────────────────┐

│ │ │

▼ ▼ ▼

┌──────────────────┐ ┌──────────────┐ ┌───────────────────────┐

│ courses │ │ goals │ │ daily_briefings │

│ id │ user_id │ │ id │ │ id │ user_id │

│ name │ code │ │ user_id │ │ date │ content_json │

│ color │ credits │ │ title │ │ generated_at │

│ semester │ │ description │ │ dismissed_at │

└────────┬─────────┘ │ target_date │ └───────────────────────┘

│ │ progress_pct│

│ └──────┬───────┘

│ │

▼ ▼

┌──────────────────────────────────────────────────────────────────┐

│ tasks │

│ id (UUID PK) │

│ user_id (FK → users) │

│ course_id (FK → courses, nullable) │

│ goal_id (FK → goals, nullable) │

│ title │ description │ due_at │ priority (1-3) │

│ status (todo/in_progress/done) │ is_recurring │

│ recurrence_rule │ completed_at │ created_at │ deleted_at │

└──────────────────────────────────────────────────────────────────┘

**JOB HUNT & SMART CAPTURE SCHEMA**

┌──────────────────────────────────────────────────────────────────┐

│ job_applications │

│ id (UUID PK) │

│ user_id (FK → users) │

│ company │ role │ job_url │ location │ salary_range │

│ status (saved/applied/oa/interview/offer/rejected) │

│ applied_at │ resume_version_id (FK → resume_versions) │

│ notes │ follow_up_sent_at │ next_follow_up_at │

│ created_at │ deleted_at │

└──────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────┐ ┌──────────────────────────────┐

│ saved_items │ │ resume_versions │

│ id │ user_id │ │ id │ user_id │

│ url │ title │ description │ │ label │ file_url │

│ tag (article/job/resource/ │ │ file_size │ created_at │

│ tool/research) │ └──────────────────────────────┘

│ suggested_goal_id │

│ suggested_course_id │ ┌──────────────────────────────┐

│ ai_summary │ ai_tags (jsonb) │ │ interview_prep │

│ created_at │ deleted_at │ │ id │ job_application_id │

└─────────────────────────────────┘ │ questions (jsonb array) │

│ answers (jsonb array) │

│ ai_feedback (jsonb) │

│ created_at │

└──────────────────────────────┘

**STUDY & SOCIAL SCHEMA**

┌────────────────────────────────┐ ┌──────────────────────────────┐

│ study_sessions │ │ study_groups │

│ id │ user_id │ │ id │ name │ invite_code │

│ goal_id (nullable) │ │ created_by (FK → users) │

│ course_id (nullable) │ │ created_at │

│ duration_min │ started_at │ └──────────────┬───────────────┘

│ ended_at │ notes │ │

│ pomodoros_completed │ ┌──────────────▼───────────────┐

└────────────────────────────────┘ │ study_group_members │

│ id │ group_id │ user_id │

┌────────────────────────────────┐ │ role (admin/member) │

│ ai_drafts │ │ joined_at │

│ id │ user_id │ └──────────────────────────────┘

│ context_type (followup/ │

│ coldmail/studyplan/review) │ ┌──────────────────────────────┐

│ context_id (polymorphic) │ │ notifications │

│ prompt │ response (text) │ │ id │ user_id │

│ model_used │ tokens_used │ │ type │ title │ body │

│ created_at │ │ action_url │ read_at │

└────────────────────────────────┘ │ scheduled_at │ sent_at │

└──────────────────────────────┘

**SUBSCRIPTIONS & BILLING SCHEMA**

┌─────────────────────────────────────────────────────────────────┐

│ subscriptions │

│ id (UUID PK) │

│ user_id (FK → users) │ plan (free/pro/team) │

│ status (active/cancelled/paused/trialing) │

│ provider (razorpay/stripe/apple/google) │

│ provider_subscription_id │ provider_customer_id │

│ current_period_start │ current_period_end │

│ cancel_at_period_end │ cancelled_at │

│ country_code │ ppp_tier │ price_paid │

│ created_at │ updated_at │

└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────┐

│ institutions │

│ id │ name │ domain │ country │

│ seat_count │ contract_start │

│ contract_end │ admin_user_id │

│ sso_config (jsonb) │ branding │

│ created_at │

└─────────────────────────────────────┘

# **9\. Tech Stack**

| **Layer** | **Technology** | **Reason** | **Cost** |
| --- | --- | --- | --- |
| Mobile/Web Frontend | Flutter 3.x (Dart) | Single codebase for Android, iOS, Web, Desktop. Fast, beautiful UI. | Free |
| State Management | Riverpod 2.x | Reactive, testable, scales well. Better than Provider/Bloc for this scope. | Free |
| Backend / Database | Supabase | Postgres + Auth + Realtime + Storage + Edge Functions. Generous free tier. | Free (up to 500MB DB, 5GB storage) |
| Authentication | Supabase Auth | Google OAuth, Apple Sign-in, Email/Password. Built in. | Free |
| File Storage | Supabase Storage | Resume uploads, profile pictures | Free (5GB) |
| AI / LLM | Claude API (Anthropic) | Briefing generation, email drafting, smart tagging, Q&A | $0.003/1K tokens — ~$0.01/user/day at moderate use |
| Background Jobs | Supabase Edge Functions + pg_cron | Daily briefing generation, reminder scheduling | Free tier sufficient for early stage |
| Browser Extension | Vanilla JS + Manifest V3 | Chrome/Firefox extension. Lightweight, no framework needed. | Free |
| Push Notifications | Firebase Cloud Messaging | Cross-platform push. Free for unlimited notifications. | Free |
| Email (transactional) | Resend | Clean API, 3,000 emails/mo free tier | Free (3K/mo) |
| Payments — India | Razorpay | Best UPI + card + netbanking support in India. 2% per transaction. | 2% per txn, no setup fee |
| Payments — Global | Stripe | Standard global payments, strong API | 2.9% + 30¢ per txn |
| Analytics | PostHog (self-hosted or cloud) | Product analytics, funnel tracking. Free tier: 1M events/mo | Free (1M events) |
| Error Monitoring | Sentry | Flutter SDK. Free for 5K errors/mo | Free |
| CI/CD | GitHub Actions + Fastlane | Auto-build and deploy to Play Store / App Store | Free (public repo) |

# **10\. Backend Architecture**

### **Architecture Pattern: Serverless-first with Supabase**

No dedicated server to manage at launch. All logic lives in Supabase Edge Functions (Deno runtime). This eliminates server costs until meaningful scale (~50K MAU).

### **Key Backend Services**

**10.1 — AI Briefing Generator (Edge Function: generate-briefing)**

- Triggered by: pg_cron job at user's wake time (stored in UTC in users table)
- Process: Fetch user's tasks due in 3 days + calendar events (via Google API) + pending job actions + last goal activity
- Compose structured prompt → call Claude API → parse response → store in daily_briefings table
- Idempotent: if briefing exists for today, skip

**10.2 — Smart Capture AI Tagger (Edge Function: tag-saved-item)**

- Triggered by: INSERT on saved_items table (Supabase webhook)
- Fetches page title + meta description (or user-provided text)
- Calls Claude API: classify type, extract summary, suggest goal/course from user's existing data
- Updates the saved_items row with AI fields

**10.3 — Email Draft Generator (Edge Function: draft-email)**

- Called on-demand from client
- Receives: application context + draft type (follow-up / cold)
- Calls Claude API with user's resume summary + company/role context
- Returns draft text — not sent automatically, always user-reviewed

**10.4 — Notification Scheduler (pg_cron + Edge Function)**

- Cron runs hourly, checks notifications table for scheduled_at <= now()
- Batches and sends via FCM
- Types: Deadline reminders (D-3, D-1, day-of), follow-up reminders, briefing ready, weekly review ready

**10.5 — Row Level Security (RLS) — All tables**

- Supabase RLS ensures users can only read/write their own data
- Service role key (kept server-side in Edge Functions only) used for cross-user operations (e.g. study groups)
- No sensitive key ever in Flutter app bundle

### **Scalability Considerations**

- Supabase scales PostgreSQL vertically initially (free → Pro → Enterprise tiers)
- Edge Functions are stateless and horizontally scalable by default
- At 100K+ MAU: introduce Redis (Upstash, free tier) for caching briefings and AI responses
- At 500K+ MAU: move to dedicated Postgres with read replicas, consider migrating to Railway/Fly.io backend
- AI costs scale linearly — mitigate with response caching (same user, same context = return cached briefing)

# **11\. Frontend Architecture (Flutter)**

### **Folder Structure**

**Flutter Project Structure**

lib/

├── main.dart # App entry point, theme setup

├── app/

│ ├── router.dart # GoRouter routes

│ └── theme.dart # ThemeData light + dark

├── core/

│ ├── constants/ # Colors, spacing, text styles

│ ├── utils/ # Date helpers, formatters

│ └── widgets/ # Shared: GlowCard, AppButton, etc.

├── features/

│ ├── auth/ # Login, onboarding

│ ├── briefing/ # Daily Briefing home screen

│ ├── tasks/ # Task manager

│ ├── capture/ # Smart capture library

│ ├── jobs/ # Job tracker

│ ├── goals/ # Goal + resource graph

│ ├── study/ # Study sessions + planner

│ └── settings/ # Profile, preferences

├── data/

│ ├── repositories/ # Data access layer

│ ├── models/ # Dart model classes (freezed)

│ └── services/ # Supabase, Claude API, FCM

└── providers/ # Riverpod providers

### **Navigation: GoRouter**

- Declarative routing with deep link support
- Shell route for persistent bottom nav (Home, Capture, Jobs, Goals, Settings)
- Nested routes for detail views (task detail, job detail, etc.)
- Auth guard: redirect to /onboarding if not authenticated

### **Key Shared Widgets**

| **Widget** | **Description** |
| --- | --- |
| GlowCard | Gradient border glow container. Accepts child, isAI bool, onTap. Uses CustomPainter for gradient border. |
| MeridianButton | Primary / secondary / ghost variants. Handles loading, disabled states. Scale animation on press. |
| TaskChip | Compact course-tagged task display. Color-coded per course. |
| BriefingSection | Expandable briefing section with dismiss. Animated expand/collapse. |
| ShimmerLoader | Skeleton screen for any list/card while loading. Matches exact layout of target. |
| BottomSheet | Custom spring-physics bottom sheet. Drag handle, dismissible. Used for all quick actions. |

# **12\. AI Components & Interaction Design**

### **AI Principles in Meridian**

- Every AI result is presented as a suggestion, never an instruction
- User can always edit or dismiss any AI output
- AI failures degrade gracefully — show cached or template content, never a broken screen
- AI components are visually distinct (gradient glow) — users always know when AI generated something

### **AI Feature Map**

| **Feature** | **Model** | **Prompt Type** | **Avg Tokens** |
| --- | --- | --- | --- |
| Daily Briefing | Claude Haiku (speed) | Context assembly → structured output | ~800 in / ~400 out |
| Email Drafter | Claude Sonnet (quality) | Role + context → email draft | ~600 in / ~300 out |
| Smart Capture Tagger | Claude Haiku | URL/text → tag + summary + goal match | ~400 in / ~150 out |
| Study Planner | Claude Haiku | Deadlines + time → schedule | ~500 in / ~300 out |
| Weekly Review | Claude Sonnet | Week's activity → narrative review | ~1000 in / ~500 out |
| Interview Prep | Claude Sonnet | JD + role → questions + feedback | ~800 in / ~600 out |
| AI Agent (v3) | Claude Sonnet | Full context → conversational response | ~2000 in / ~800 out |

### **AI Cost Estimate at Scale**

| **MAU** | **Daily AI calls/user** | **Monthly AI cost (est.)** | **Per user/mo** |
| --- | --- | --- | --- |
| 1,000 | 3   | ~$18 | $0.018 |
| 10,000 | 3   | ~$180 | $0.018 |
| 50,000 | 4   | ~$1,200 | $0.024 |
| 100,000 | 4   | ~$2,400 | $0.024 |

_Cost stays well below 5% of revenue at all tiers — healthy AI margin._

# **13\. Pricing Strategy (PPP-Adjusted)**

### **What is PPP Pricing?**

Purchasing Power Parity pricing adjusts subscription cost by country so users in lower-income countries pay a fair amount relative to their economy. This dramatically increases global conversion without leaving money on the table in wealthier markets.

### **Plan Structure**

| **Plan** | **Free** | **Pro** | **Team (per seat)** |
| --- | --- | --- | --- |
| Target | Students exploring | Serious students | Study groups / colleges |
| Daily Briefing | ✓ Basic (3 items) | ✓ Full (unlimited) | ✓ Full |
| Tasks & Deadlines | ✓ Up to 30 tasks | ✓ Unlimited | ✓ Unlimited |
| Smart Capture | ✓ 20 saves/mo | ✓ Unlimited | ✓ Unlimited |
| Job Tracker | ✓ Up to 10 apps | ✓ Unlimited | ✓ Unlimited |
| AI Email Drafter | ✗   | ✓ Unlimited | ✓ Unlimited |
| Gmail Integration | ✗   | ✓   | ✓   |
| Study Planner | ✗   | ✓   | ✓   |
| Weekly AI Review | ✗   | ✓   | ✓   |
| Resume Vault | ✗   | ✓ (5 versions) | ✓   |
| AI Course Assistant | ✗   | ✗   | ✓   |
| Shared Task Boards | ✗   | ✗   | ✓   |

### **PPP Pricing Tiers**

| **Region / Country** | **Pro Monthly** | **Pro Annual (2 mo free)** | **PPP Index** |
| --- | --- | --- | --- |
| 🇺🇸 USA / Canada / Australia | $12 / mo | $99 / yr | 1.0x |
| 🇬🇧 UK / Germany / France | £9 / €10 / mo | £75 / €82 / yr | 0.82x |
| 🇧🇷 Brazil / Mexico | R$25 / MX$120 / mo | R$199 / MX$999 / yr | 0.30x |
| 🇮🇳 India (Tier 1 cities) | ₹399 / mo | ₹2,999 / yr | 0.12x |
| 🇮🇳 India (students, verified) | ₹249 / mo | ₹1,999 / yr | 0.08x |
| 🇵🇭 Philippines / Vietnam | $3.5 / mo | $28 / yr | 0.22x |
| 🇳🇬 Nigeria / Kenya | $2.5 / mo | $20 / yr | 0.15x |

### **Team / Institutional Pricing**

| **Tier** | **Price** | **Includes** |
| --- | --- | --- |
| Team (5–20 seats) | ₹199/seat/mo (India) \| $6/seat/mo (Global) | Shared boards, group briefing, admin dashboard |
| College License (100+ seats) | ₹150/seat/mo \| $4/seat/mo | SSO, custom branding, analytics, priority support |
| Enterprise (500+ seats) | Custom contract | SLA, dedicated support, custom integrations, API access |

### **Revenue to ₹10K/mo Path**

| **Milestone** | **Users needed** | **Monthly Revenue** |
| --- | --- | --- |
| MVP Launch (India students only) | 100 Pro @ ₹249 | ~₹25,000/mo |
| Early Traction (India) | 500 Pro @ ₹299 avg | ~₹1,50,000/mo |
| Ramen Profitable | 1,200 Pro (India mix) | ~₹3,50,000/mo (~$4,200) |
| ₹10L/mo | 3,000 Pro India + 500 Global | ~₹10,00,000/mo |

# **14\. Build Cost Analysis — Free / Minimal Cost Stack**

**Goal: Build and launch v1.0.0 for under ₹5,000 ($60) total**

Every tool chosen has a free tier that covers you until ~5,000 MAU.

The only unavoidable cost is Apple Developer Program ($99/yr) if targeting iOS.

| **Service** | **Free Tier** | **When You'll Pay** | **Est. Cost at 1K MAU** |
| --- | --- | --- | --- |
| Supabase | 500MB DB, 5GB storage, 50K MAU auth | Pro at ~$25/mo when DB > 500MB (~10K users) | $0  |
| Claude API | $5 free credit on signup | Pay-as-you-go after credit | ~$18/mo |
| Firebase FCM | Unlimited push notifications | Never (FCM is free) | $0  |
| Resend (email) | 3,000 emails/mo free | Paid at $20/mo for 50K emails | $0  |
| PostHog | 1M events/mo free | Paid beyond 1M events | $0  |
| Sentry | 5K errors/mo free | Paid beyond 5K | $0  |
| GitHub (code + CI) | Free for public, 2K CI mins/mo private | Rarely needed at early stage | $0  |
| Razorpay | No setup fee | 2% per transaction | 2% of revenue |
| Google Play Store | One-time $25 | N/A | $25 one-time |
| Apple App Store | $99/yr developer program | Annual renewal | $99/yr |
| Domain (meridian.app) | ~$12/yr via Namecheap | Annual renewal | $12/yr |

**Total launch cost (Android only): ~₹2,000 ($25 Play Store + $12 domain) + AI usage**

**Total launch cost (Android + iOS): ~₹10,000 ($25 + $99 + $12 domain) + AI usage**

_AI API cost at 1,000 MAU ≈ $18/mo. Covered entirely by ~10 Pro subscribers at Indian pricing._

# **15\. Versioning Roadmap**

| **Version** | **Timeline** | **Key Features** | **Milestone** |
| --- | --- | --- | --- |
| v0.1.0 (Alpha) | Week 1–2 | Auth + Tasks + Manual Briefing | Use it yourself daily |
| v0.5.0 (Beta) | Week 3–5 | AI Briefing + Smart Capture + Job Tracker | 20 friends using it |
| v1.0.0 (Launch) | Week 6–8 | Full MVP: all F-01 to F-06 features, both themes | Public launch, Play Store |
| v1.1.0 | Month 3 | Gmail integration + Study Planner + iOS launch | First paid users |
| v1.2.0 | Month 4 | Weekly Review + Resume Vault + Study Groups | 200 Pro subscribers |
| v1.3.0 | Month 5 | Web App (Flutter Web) + browser extension v2 | 500 Pro subscribers |
| v1.4.0 | Month 6 | Widgets + Offline Mode + Performance pass | 1,000 Pro subscribers |
| v2.0.0 | Month 8 | AI Course Assistant + Interview Prep + Institutional dashboard | First college deal |
| v2.5.0 | Month 10 | Career Roadmap + Integrations (Notion, GitHub) | 5,000 Pro subscribers |
| v3.0.0 | Month 14 | Meridian AI Agent + full Integrations Marketplace | Series A / acquisition ready |

_— End of Document —_

Meridian PRD v1.0 · Confidential