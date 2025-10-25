

### **System Updates (do this weekly or biweekly)**

Keep your packages and security patches up to date:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean
```

* `update` refreshes package info
* `upgrade` installs newer versions
* `autoremove` deletes old dependencies
* `autoclean` prunes old cached `.deb` files

If you want *only security updates* (for production systems where you’re cautious about version bumps):

```bash
sudo unattended-upgrades
```

Enable automatic security updates:

```bash
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

---

### **System Health and Disk Maintenance**

Check disk usage:

```bash
df -h
```

See which directories eat space:

```bash
sudo du -h --max-depth=1 / | sort -hr | head
```

Clean old journal logs (they can bloat over time):

```bash
sudo journalctl --vacuum-time=7d
```

Check for broken packages:

```bash
sudo apt --fix-broken install
```

---

### **Docker Maintenance**

Docker can quietly consume a lot of disk space with unused images and containers:

```bash
docker system prune -a --volumes
```

*(Add `-f` to skip confirmation — but be careful: this removes all stopped containers, unused networks, images, and volumes.)*

Check space usage:

```bash
docker system df
```

You can also automate pruning via a cron job once a week:

```bash
sudo crontab -e
```

and add:

```
0 3 * * 0 /usr/bin/docker system prune -af --volumes
```

(that runs every Sunday at 3 AM)

---

### **Security Checks**

Basic firewall (UFW) status:

```bash
sudo ufw status verbose
```

Check for open ports:

```bash
sudo ss -tulwn
```

Fail2ban (if installed):

```bash
sudo fail2ban-client status
```

Run a security audit occasionally:

```bash
sudo apt install lynis -y
sudo lynis audit system
```

Lynis gives a nice report of weaknesses and suggestions.

---

### **System Info**

Monitor system resource usage:

```bash
htop
```

or if you like something lighter:

```bash
top
```

---

### **Backups**

Regularly backup:

* your `/etc` config files
* your `.env` files
* database dumps
* docker volumes (or at least export them occasionally)

Even a simple rsync to remote storage works wonders:

```bash
rsync -avz /important/data user@remote-server:/backup/
```

---

### **Optional: Cleaning orphaned Snap packages (if you use Snap)**

```bash
sudo snap list --all | awk '/disabled/{print $1, $3}' | while read pkg rev; do sudo snap remove "$pkg" --revision="$rev"; done
```



