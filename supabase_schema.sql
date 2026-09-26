create table if not exists phantom_state (
  id text primary key,
  payload text not null,
  updated_at timestamptz not null default now()
);

-- Store media in Supabase Storage bucket: phantom-media.
-- Keep the bucket private and use server-side signed access where appropriate.
