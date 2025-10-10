# 🛠️ My Arch Linux CLI Tools

A collection of handy little shell scripts I use on Arch Linux.
With the `create-command` helper, you can turn any script into a global command instantly.

---

## 🚀 Quick Setup

Clone the repo and run this one-liner:

```bash
mkdir -p ~/bin && ln -sf "$(realpath create-command.sh)" ~/bin/create-command && echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

This will:

* Create a `~/bin` directory (if it doesn’t exist).
* Make `create-command` available globally.
* Add `~/bin` to your shell `PATH`.

---

## 📦 Usage

To make any script a global command:

```bash
create-command myscript.sh
```

Now you can run it anywhere as:

```bash
myscript
```

### Example:

```bash
create-command treecp.sh
treecp
```

```bash
create-command setup-ngix.sh
setup-ngix
```

---

## ✨ Features

* Works with scripts in your current directory or any path.
* Updates automatically — editing the script changes the global command instantly.
* Simple, minimal, Arch-friendly.

---

## 📝 How it works

Linux doesn’t treat “commands” as a special category. A command is just an executable file located in a directory listed in your `$PATH` environment variable.

Here’s what’s happening step by step:

1. **Executables in Linux**
   Any file with the executable permission (`chmod +x file.sh`) can be run directly. For example:

   ```bash
   ./myscript.sh
   ```

   But this only works if you’re in the same directory as the script.

2. **The role of `$PATH`**
   Your shell looks for commands by scanning directories listed in the `$PATH` variable.
   If you place a script in one of those directories, you can call it without specifying the path.
   Example:

   ```bash
   echo $PATH
   /usr/local/bin:/usr/bin:/bin:/home/you/bin
   ```

3. **Why `~/bin`**
   Creating `~/bin` is a convention for user-specific executables. It keeps your personal commands separate from system-wide binaries, and it’s safe from package manager overwrites.

4. **Why symlinks instead of copies**
   Instead of copying scripts into `~/bin`, `create-command` makes symbolic links.
   A symlink is like a shortcut: it points to the real file.
   This means:

   * If you update the original script, the command updates automatically.
   * You don’t clutter `~/bin` with duplicate copies.

5. **Putting it all together**

   * You mark your script as executable.
   * `create-command` creates a symlink in `~/bin`.
   * Your shell sees the symlink in `$PATH` and treats it like a global command.

---

## 🔍 Why this approach

There are other ways you could achieve global commands:

* **Copy scripts to `/usr/local/bin/`** – Works, but needs root permissions and mixes your personal tools with system tools.
* **Add your scripts folder to `$PATH`** – Also works, but then every script in that folder becomes globally available, which might not be what you want.
* **Aliases in your shell config** – Great for quick one-liners, but harder to manage or share.

This repo takes the symlink approach because it’s **simple, non-destructive, user-level, and flexible**. You can drop in scripts anywhere, turn them into commands instantly, and update them without extra steps.

---

This kind of setup reflects the Unix philosophy: *“Write programs that do one thing well, and work together.”* Here, `create-command` does only one thing—link a script into your personal bin—but it enables you to build your own little ecosystem of tools, seamlessly integrated into your shell.

