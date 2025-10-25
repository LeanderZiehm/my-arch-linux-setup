
# Quick safety checklist (do these immediately)

1. **Rotate / revoke the compromised key** (API provider console) — *do this first*.
2. Add the secret source (e.g. `.env`) to `.gitignore`. Never commit secrets again.
3. Add a pre-commit detector (e.g., `git-secrets`, `pre-commit` hooks) to stop future leaks.
4. After rewriting history and pushing, **inform teammates** and coordinate (they’ll need to re-clone or reset).

---

# A — Local-only (committed but not pushed)

## If the secret is in the **most recent commit (HEAD)**

1. Remove or replace the secret in the file(s) in your working tree (edit file, remove key, replace with placeholder).
2. Stage the change:

```bash
git add path/to/file
```

3. Amend the last commit:

```bash
git commit --amend --no-edit
```

`--no-edit` keeps the old commit message; omit it if you want to change the message.

4. (Optional) Clean reflog & garbage to reduce local exposure:

```bash
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

This deletes dangling objects locally. Because it’s local-only, no remote coordination needed.

## If the secret is in a commit 1–2 commits back (not HEAD)

Use interactive rebase:

1. Start an interactive rebase including the commit(s) that contain the secret. For 2 commits back:

```bash
git rebase -i HEAD~3
```

Adjust `HEAD~N` so the list shows the commit(s) you want to edit.

2. In the editor that opens, change `pick` to `edit` (or `e`) on the offending commit(s). Save & exit.

3. For each commit you stop at, update the file to remove the secret, stage it, and amend:

```bash
# edit file to remove secret
git add path/to/file
git commit --amend --no-edit
git rebase --continue
```

4. When rebase finishes, cleanup reflog & GC (optional but recommended):

```bash
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

Now your local history no longer contains the secret. Because it was never pushed, you’re done — but **still rotate** the key if it might be leaked.

---

# B — Already pushed to origin (or another remote)

**Important:** rewriting pushed history changes commit IDs. You will need to force-push, and everyone else who has the repo must rebase or re-clone. Also rotate the leaked secret immediately — rewriting history does not prevent someone who already pulled the repo from using the secret.

Below are approaches depending on scope.

## B1 — Secret in last commit only (simple)

1. Remove secret in working tree and stage:

```bash
git add path/to/file
```

2. Amend last commit:

```bash
git commit --amend --no-edit
```

3. Force push using safer `--force-with-lease`:

```bash
git push origin branch-name --force-with-lease
```

`--force-with-lease` is safer than `--force` because it prevents you from accidentally overwriting remote updates you don't have.

4. Cleanup local objects:

```bash
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

5. Ask all collaborators to re-clone or run:

```bash
# safer: rebase local work onto new branch
git fetch origin
git reset --hard origin/branch-name
# or if they have local commits they want to keep:
git fetch origin
git rebase origin/branch-name
```

## B2 — Secret in one or a few earlier commits (use interactive rebase)

1. Run interactive rebase up to the commit that contains the secret:

```bash
git rebase -i <base-commit>   # e.g., git rebase -i HEAD~5
```

2. Mark offending commits with `edit`, remove secret, `git add`, `git commit --amend`, `git rebase --continue` (same as local case).
3. Force-push:

```bash
git push origin branch-name --force-with-lease
```

4. Run cleanup locally (reflog/gc) and coordinate with team to rebase/re-clone.

## B3 — Secret appears in many commits or you need to purge it from entire repo history

Use a history-rewriting tool — prefer `git filter-repo` (modern, fast) or the BFG Repo‑Cleaner for simpler use. **Do not use** `git filter-branch` for big purges; it’s old and slow.

### Using `git filter-repo` (recommended)

> Install: `pip install git-filter-repo` (or use distro package if available).

Example: remove an entire file `secret.env` from all commits:

```bash
# in a fresh clone (recommended)
git clone --mirror git@github.com:you/your-repo.git
cd your-repo.git   # note: bare mirror clone
git filter-repo --invert-paths --paths secret.env
# push cleaned history back
git push --force --tags origin 'refs/heads/*'
```

Or to remove a string (like an API key) from all files, you'd write a small replace script. `git filter-repo` has `--replace-text` option:

Create `replacements.txt`:

```
# lines starting with # are comments
OLD_API_KEY==>REDACTED_KEY
```

Then run:

```bash
git filter-repo --replace-text replacements.txt
git push --force --tags origin 'refs/heads/*'
```

**Notes:** run this from a mirror clone and read `git-filter-repo` docs before running.

### Using BFG Repo-Cleaner (easier for a single secret/file)

> Requires Java. BFG is simpler for common cases (remove file or replace passwords).

1. Create a bare mirror:

```bash
git clone --mirror git@github.com:you/your-repo.git
cd your-repo.git
```

2. Remove file(s):

```bash
# delete a file from history
bfg --delete-files secret.env
# OR replace a password string:
bfg --replace-text passwords.txt
```

3. Apply and push:

```bash
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force
```

See BFG docs for specifics.

**After a full-history purge**:

* **All collaborators** must re-clone the repo (recommended) or run complex forced resets.
* Some hosting providers (GitHub/GitLab) keep reflogs/backups and caches—contact support if absolutely necessary, but usually rotating the secret is the practical step.

---

# Additional cleanup steps (local and remote)

* Remove secrets from other branches and tags: ensure you rewrite them too (filter-repo/BFG can handle all refs).
* Delete any tags that included the secret (and re-create them if needed). Example to delete tag locally & remotely:

```bash
git tag -d bad-tag
git push origin :refs/tags/bad-tag
```

* Clear remote caches: hosting platforms may keep caches; secrets may live in CI logs or package registries — hunt for them and remove/rotate there too.
* If the secret was included in a Pull Request, the PR discussion or CI logs might show it — check and remove if possible.

---

# Practical examples (copy/paste)

### Example 1 — secret in last commit (local-only)

```bash
# edit file to remove secret
git add .env
git commit --amend --no-edit
git reflog expire --expire=now --all
git gc --prune=now --aggressive
# done (not pushed)
```

### Example 2 — secret 2 commits back (local-only)

```bash
git rebase -i HEAD~3
# change 'pick' to 'edit' on the offending commit, save
# when stopped:
# edit the file to remove secret, then:
git add .env
git commit --amend --no-edit
git rebase --continue
# finish and clean:
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

### Example 3 — secret pushed and in multiple commits (recommended workflow)

```bash
# 1) Immediately rotate/revoke key at provider
# 2) In a separate safe workspace:
git clone --mirror git@github.com:you/your-repo.git
cd your-repo.git
# Either:
# A) remove file
git filter-repo --invert-paths --paths .env
# OR B) replace exact string occurrences
echo 'OLD_API_KEY==>REDACTED' > replacements.txt
git filter-repo --replace-text replacements.txt

# 3) push cleaned repo
git push --force --tags origin 'refs/heads/*'

# 4) encourage everyone to re-clone
```

---

# Other practical mitigations & future prevention

* Use environment variables in `.env` and **never** commit `.env`. (You already do — good!)
* Add `.env` to `.gitignore` and commit that `.gitignore`.
* Add a `setup.py` or `setup.sh` that reads from `.env.example` (no secrets) and documents how to create real `.env`.
* Use a secrets manager (Vault, AWS Secrets Manager) for production secrets.
* Add `pre-commit` hooks: `pre-commit`, `git-secrets`, or `detect-secrets` to block commits containing private keys or API tokens. Example: add `detect-secrets` to your repo and CI.

---

# When in doubt

* **Always rotate** the key immediately. History surgery is about containment and preventing future exposures, but rotation is the only way to guarantee the leaked key is useless.
* If the repo is on GitHub/GitLab/Bitbucket and you need help forcing garbage collection or dealing with forks, check their docs or open a support ticket — but rotation + rewrite is the normal path.





