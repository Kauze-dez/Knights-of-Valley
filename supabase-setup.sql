-- Выполните один раз: Supabase → SQL Editor → New query → вставить → Run
create table if not exists public.saves (
  user_id uuid primary key references auth.users(id) on delete cascade,
  json text not null check (length(json) < 300000),
  ts bigint not null,
  updated_at timestamptz not null default now()
);

alter table public.saves enable row level security;

create policy "saves: читать только своё" on public.saves
  for select using (auth.uid() = user_id);
create policy "saves: создавать только своё" on public.saves
  for insert with check (auth.uid() = user_id);
create policy "saves: менять только своё" on public.saves
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
