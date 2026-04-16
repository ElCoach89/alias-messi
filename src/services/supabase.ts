// ============================================================
// El Coach — Supabase Client
// ============================================================

import 'react-native-url-polyfill/auto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.EXPO_PUBLIC_SUPABASE_URL || 'https://iizgrpcelhajrpqfxxde.supabase.co';
const SUPABASE_ANON_KEY = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlpemdycGNlbGhhanJwcWZ4eGRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYzNDcwNzUsImV4cCI6MjA5MTkyMzA3NX0.JfztDchond-lUZt3bMVwDo-hPIDnaUKblQ070cRIIYA';

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    storage: AsyncStorage,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
  },
});
