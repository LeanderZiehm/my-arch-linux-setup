sudo apt install postgresql
sudo -u postgres psql
CREATE DATABASE n8n_db;
CREATE USER n8n_user WITH PASSWORD 'SMvITK85$iYwFd3AJ&*@';
GRANT ALL PRIVILEGES ON DATABASE n8n_db TO n8n_user;
\q




sudo apt install postgresql-server-dev-all
git clone https://github.com/pgvector/pgvector.git
cd pgvector
make
sudo make install
sudo -u postgres psql
CREATE EXTENSION vector;





sudo apt update
sudo apt install build-essential





CREATE DATABASE llmano_db;
CREATE USER llmano_user WITH PASSWORD '#SMvxTK85$gYwFd3AJ&3';
GRANT ALL PRIVILEGES ON DATABASE llmano_db TO llmano_user;


psql -d llmano_db













ALTER USER postgres WITH PASSWORD 'V7q8t4!SF19Ls';


sudo -u postgres createdb unitedai


psql -d unitedai

psql -U leander -d unitedai





-- Step 1: Create User
CREATE USER leander WITH PASSWORD 'rT0rbcEscLmbmgbD1s6q';

-- Step 2: Create Schema
CREATE SCHEMA leander_schema AUTHORIZATION leander;

-- Step 3: Grant Schema Access
GRANT USAGE, CREATE ON SCHEMA leander_schema TO leander;

-- Step 4: Grant Permissions on Tables
GRANT SELECT, INSERT, DELETE ON ALL TABLES IN SCHEMA leander_schema TO leander;

-- Step 5: Ensure Future Tables Inherit Permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA leander_schema
GRANT SELECT, INSERT, DELETE ON TABLES TO leander;







