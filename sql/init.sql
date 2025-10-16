CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), email TEXT UNIQUE, hashed_password TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS presence (user_id UUID PRIMARY KEY, location GEOMETRY(Point,4326) NOT NULL, last_seen TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS posts (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), user_id UUID, content VARCHAR(280) NOT NULL, location GEOMETRY(Point,4326) NOT NULL, expires_at TIMESTAMPTZ NOT NULL DEFAULT now() + interval '\''24 hours'\'', created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS beacons (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), user_id UUID NOT NULL, message VARCHAR(140), location GEOMETRY(Point,4326) NOT NULL, expires_at TIMESTAMPTZ NOT NULL DEFAULT now() + interval '\''60 minutes'\'', created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS threads (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS messages (id UUID PRIMARY KEY DEFAULT gen_random_uuid(), thread_id UUID NOT NULL, sender_id UUID NOT NULL, content TEXT NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS votes (post_id UUID NOT NULL, user_id UUID NOT NULL, direction SMALLINT NOT NULL CHECK (direction IN (-1,1)), PRIMARY KEY (post_id,user_id));
