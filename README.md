# Meridian
**Your AI-Powered Student Command Center**

Meridian is the calm, intelligent layer that sits between a student's chaos and their goals — aggregating deadlines, learning resources, job hunts, and daily priorities into one proactive, beautiful command center.

## 🌟 Vision
Replace the anxiety of fragmented tools with a single AI-native surface that tells students what matters today, not what was saved last week. 
- **Proactive over reactive:** The app surfaces things, you don't hunt for them.
- **Calm over noisy:** No badge overload, no notification spam.
- **Action over storage:** Every screen leads to something you can do right now.

## ✨ Key Features
- **Daily AI Briefing:** A personalized morning briefing summarizing your agenda, upcoming deadlines, and job actions using Claude AI.
- **Unified Task Manager:** A Kanban-lite and list view for assignments and goals, synced with Google Calendar.
- **Job Hunt Tracker:** Manage your internship/placement pipeline from Saved to Offer, complete with AI-drafted follow-up emails.
- **Smart Capture:** Auto-tag and categorize useful resources using our Browser Extension and share-sheet integration.
- **Study Planner & Pomodoro Timer:** Generate personalized study sessions based on upcoming deadlines and available time slots.
- **Social Study Groups:** Collaborate with peers, track shared tasks, and communicate via in-app messaging.

## 🛠️ Tech Stack
- **Frontend:** Flutter 3.x (Dart) targeting Android, iOS, and Web.
- **State Management:** Riverpod 3.x.
- **Backend & Database:** Supabase (PostgreSQL, Auth, Storage, Edge Functions).
- **AI Integration:** Anthropic Claude API via Supabase Edge Functions.
- **Local Storage:** Drift (SQLite) with local-first offline support.
- **Monitoring:** Sentry & PostHog.

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.41+)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (for local backend development)

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/peter14l/meridian.git
   cd meridian
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables:**
   Create a `.env` file or configure your environment to include your Supabase project URL and Anon Key, as well as your Sentry DSN. (Update `lib/main.dart` and `lib/data/services/supabase_service.dart` with your actual keys for local testing).

4. **Run the App:**
   ```bash
   flutter run
   ```

### Database Schema setup (Supabase)
Ensure your Supabase project has the required tables. You can apply the migrations located in the `supabase/migrations/` directory:
```bash
supabase link --project-ref <your-project-id>
supabase db push
```

## 🤝 Contributing
This is an active project following a phased implementation plan (see `Implementation_Plan.md`). Please review the PRD (`Meridian_PRD.md`) before submitting significant pull requests.

## 📄 License
Confidential — Founder Copy.
