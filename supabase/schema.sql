-- CDC MRP Starter: execute no SQL Editor do Supabase.
create extension if not exists pgcrypto;
create table if not exists public.products (
 id uuid primary key default gen_random_uuid(), sku text unique not null, name text not null,
 unit text not null default 'UN', lead_time_days integer not null default 0,
 bom jsonb not null default '[]'::jsonb, active boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.inventory (
 id uuid primary key default gen_random_uuid(), sku text not null, description text not null,
 location text not null default 'Almoxarifado', on_hand numeric(14,3) not null default 0,
 reserved numeric(14,3) not null default 0, min_level numeric(14,3) not null default 0,
 unit text not null default 'UN', updated_at timestamptz not null default now(), unique(sku, location)
);
create table if not exists public.records (
 id uuid primary key default gen_random_uuid(), module text not null,
 code text not null, title text not null, status text not null default 'Aberto',
 due_date date, quantity numeric(14,3) not null default 1,
 payload jsonb not null default '{}'::jsonb, created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists records_module_idx on public.records(module);
create index if not exists records_due_idx on public.records(due_date);
-- Starter de demonstração: acesso público para facilitar o primeiro teste.
-- ANTES DE USAR DADOS REAIS, habilite RLS, crie autenticação e políticas por perfil.
alter table public.products enable row level security;
alter table public.inventory enable row level security;
alter table public.records enable row level security;
drop policy if exists "starter products access" on public.products;
drop policy if exists "starter inventory access" on public.inventory;
drop policy if exists "starter records access" on public.records;
create policy "starter products access" on public.products for all using (true) with check (true);
create policy "starter inventory access" on public.inventory for all using (true) with check (true);
create policy "starter records access" on public.records for all using (true) with check (true);
