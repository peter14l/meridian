-- Migration: Create missing user records for existing authenticated users
-- Run this to fix users who signed up but don't have a record in the 'users' table

-- Insert users who exist in auth.users but not in public.users
INSERT INTO users (id, email, created_at)
SELECT 
    au.id,
    au.email,
    au.created_at
FROM auth.users au
LEFT JOIN users u ON u.id = au.id
WHERE u.id IS NULL
ON CONFLICT (id) DO NOTHING;

-- Verify the fix
SELECT 
    'Total auth.users' as metric, COUNT(*) as count FROM auth.users
UNION ALL
SELECT 
    'Total public.users', COUNT(*) FROM users
UNION ALL
SELECT 
    'Missing users (fixed)', COUNT(*) 
FROM auth.users au
LEFT JOIN users u ON u.id = au.id 
WHERE u.id IS NULL;
