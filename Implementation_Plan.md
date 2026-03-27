# Goal Description
This is an implementation plan to build out the Meridian App (AI-Powered Student Command Center) phase by phase based on the provided Product Requirements Document (PRD).

## User Review Required
Please review the phase breakdown and the detailed checklist. This plan translates the PRD phases (Alpha through v3.0) into actionable development tasks.
Is the structure and sequencing aligned with your expectations? Let me know if you want to modify any phases before we begin execution.

## Proposed Changes
We will create multiple components following a structured phased approach.

---

### Phase 1: MVP Foundation (v0.1.0)
- [x] Initialize Flutter 3.x project with core/features/data/providers folder structure.
- [x] Set up GoRouter for app routing and basic ThemeData (Dark/Light).
- [x] Initialize Supabase project (Auth, Postgres).
- [x] Create core DB schema: `users`, `courses`, `goals`, `tasks`.
- [x] Implement Supabase Auth (Google OAuth, Email/Password).
- [x] Build basic Onboarding wizard (Select college, year, goals).
- [x] Build Task management frontend (Add/Edit task, Kanban-lite view).

---

### Phase 2: AI & Primary Workflows (v0.5.0)
- [x] Create `daily_briefings`, `job_applications`, `saved_items` tables.
- [x] Integrate Claude API in Supabase Edge Functions.
- [x] Develop `generate-briefing` Edge Function.
- [x] Build Daily Context/Briefing Home Screen with Gradient Glow UI.
- [x] Develop `tag-saved-item` Edge Function for Smart Capture.
- [x] Build minimalist Browser Extension (Vanilla JS + Manifest V3).
- [x] Build Job Tracker frontend (Pipeline view, Add/Edit).
- [x] Develop AI Email Drafter Edge Function (`draft-email`).

---

### Phase 3: MVP Polish & Launch (v1.0.0)
- [x] Integrate Google Calendar (Auth & event sync).
- [x] Refine micro-motion UI (Shared element transitions, spring bottom sheets).
- [x] Build Core Settings & Preferences (Dark/Light toggle, Notification prefs).
- [x] Set up Error Monitoring (Sentry) and Analytics (PostHog).
- [x] Configure GitHub Actions for CI/CD.
- [ ] Finalize Android App Bundle and deploy to Play Store.

---

### Phase 4: Secondary Core Features (v1.1.0)
- [x] Implement AI Study Session Planner algorithm and UI.
- [x] Add Pomodoro Timer with dynamic session tracking.
- [x] Build Smart Inbox (Read-only Gmail extraction for recruitment).
- [ ] Finalize iOS bundle and deploy to App Store.

---

### Phase 5: Deepening Product Experience (v1.2.0 & v1.3.0)
- [x] Setup `resume_versions`, `study_groups`, `study_group_members` tables.
- [x] Build Weekly Review & AI Reflection cards.
- [x] Implement Resume Vault & AI matching logic.
- [x] Build Study Groups frontend & in-app messaging (Supabase Realtime).
- [ ] Optimize and deploy Web App (Flutter Web).

---

### Phase 6: Advance Polish & Offline Mode (v1.4.0)
- [x] Develop Home/Lock Screen Widgets for next deadlines.
- [x] Implement robust Offline Mode with local-first sync.
- [x] Optimize performance and conduct application profiling.

---

### Phase 7: Advanced B2B & Knowledge AI (v2.0.0 & v2.5.0)
- [ ] Build B2B Institutional Dashboard (React/Web).
- [ ] Implement AI Course Assistant (PDF syllabus RAG).
- [ ] Build Interview Prep Mode with mock answer flows.
- [ ] Implement Career Roadmap generator.
- [ ] Build GitHub & Notion sync integrations.

---

### Phase 8: The Complete Vision (v3.0.0)
- [ ] Unify workflows into Meridian AI Agent interface.
- [ ] Launch full Integrations Marketplace.

## Verification Plan

### Automated Tests
- Build out unit tests for Edge Functions locally using Deno testing tools.
- Set up Flutter widget tests (`flutter test`) for core visual components like `GlowCard` and `TaskChip`.

### Manual Verification
- Manually run the Android application emulator.
- Verify OAuth login flow using test credentials.
- Test task creation, dragging in Kanban, and verifying Supabase RLS policies via web console.
