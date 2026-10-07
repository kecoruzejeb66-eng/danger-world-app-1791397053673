Build me a fullstack WhatsApp Clone called "Alayan SS2 Members Group" - WhatsApp exact style.

APP NAME: Alayan SS2 Members Group
THEME: WhatsApp Exact - #075E54 header, #128C7E buttons, #DCF8C6 my messages, #FFFFFF other messages, background #E5DDD5 with doodle pattern.

TECH STACK:
- Next.js 14 App Router + Tailwind CSS + ShadCN
- Supabase for Auth + Database + Realtime
- Lucide Icons

DATABASE (Supabase SQL - create these tables):

1. profiles table:
id (uuid, primary key, references auth.users)
email (text)
ss2_username (text, unique, not null) - THIS IS LOGIN USERNAME
avatar_url (text)
created_at (timestamp)

2. messages table:
id (uuid, primary key)
sender_id (uuid, references profiles.id)
receiver_id (uuid, references profiles.id) - for 1-1 chat
group_id (uuid, nullable) - for later group
content (text)
created_at (timestamp)
is_read (boolean default false)

Enable RLS and Realtime for messages table.

FEATURES - BUILD ALL:

A) AUTH SYSTEM (SS2 Style):
- Register Page: Fields: Email, SS2 Username (e.g. Alayan_001), Password, Confirm Password. On submit: create auth user with email, then create profile with ss2_username. Show WhatsApp style green button.
- Login Page: Fields: SS2 Username + Password ONLY (not email). Logic: Query profiles table where ss2_username = input, get email, then signInWithPassword(email, password). If success, redirect to /chat
- Check ss2_username unique

B) MAIN CHAT LAYOUT - EXACT WHATSAPP WEB:
- Left Sidebar (30% width): 
    - Header: #075E54, Title "Alayan SS2 Members Group", icons (search, menu)
    - Search bar: Search by SS2 Username
    - Chat List: Show all users from profiles table except me. Each item: Avatar (circle with first letter), SS2 Username, last message preview, time, unread count. Click to open chat.

- Right Chat Area (70% width):
    - Header: #F0F0F0, Show selected user's avatar + SS2 Username + "online"
    - Messages Area: Background #E5DDD5, show messages between me and selected user. My messages: right, #DCF8C6, with time and double tick. Other messages: left, white.
    - Input Area: #F0F0F0, emoji button, attachment, input field "Type a message", mic button #075E54. On Enter, insert into messages table. Realtime subscription should update instantly.

C) REALTIME:
- Use supabase.channel(`chat:${myId}:${selectedUserId}`).on('postgres_changes', {event: 'INSERT', table: 'messages'}, ...) to show new messages live without refresh.

D) LOGIC:
- Use .env: NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY
- NEVER hardcode keys. Read from process.env
- Make it mobile responsive: on mobile, show chat list full screen, when chat opened, hide list.

E) EXTRA POLISH:
- Login/Register pages have WhatsApp logo style but text "Alayan SS2 Members Group"
- Add "SS2 Members" badge on profiles
- Empty state: "Select a chat to start messaging SS2 members"
- Time format like WhatsApp: 10:45 PM

Build complete, deployable, and working. Generate all files: app/page.tsx (login), app/register/page.tsx, app/chat/page.tsx, lib/supabaseClient.ts, components/ChatList.tsx, components/ChatWindow.tsx, components/MessageBubble.tsx