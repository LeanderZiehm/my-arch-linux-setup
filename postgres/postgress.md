
Alright, since you want to allow connections from **any IP**, here’s exactly what to do with `vim`. I’ll assume Ubuntu + Postgres 14 default paths.

---

### 1. Edit `postgresql.conf` to listen on all addresses

```bash
sudo -i -u postgres
vim /etc/postgresql/14/main/postgresql.conf
```

In `vim`:

1. Press `/` then type `listen_addresses` and hit `Enter` (search).
2. Once on the line, press `i` to enter **insert mode**.
3. Change it to:

```
listen_addresses = '*'
```

4. Press `Esc` to exit insert mode.
5. Type `:wq` and hit `Enter` to save and quit.

---

### 2. Edit `pg_hba.conf` to allow any IP

```bash
vim /etc/postgresql/14/main/pg_hba.conf
```

In `vim`:

1. Scroll to the bottom using `G`.
2. Press `o` to open a new line below.
3. Add this line:

```
host    bookmarkdb    bookmarkapp    0.0.0.0/0    md5
```

* `bookmarkdb` → your database
* `bookmarkapp` → your role
* `0.0.0.0/0` → allows any IPv4
* `md5` → password authentication

4. Press `Esc` and type `:wq` to save and quit.

---

### 3. Restart Postgres to apply

```bash
sudo systemctl restart postgresql
```

---

After this, you can connect from anywhere using:

```bash
psql -h <YOUR_SERVER_IP> -p 5432 -U bookmarkapp -d bookmarkdb
```

It will prompt for the password of `bookmarkapp`.

If you want, I can give a **one-liner vim trick** to do both edits without scrolling manually—super fast for cloud instances. Do you want that?
