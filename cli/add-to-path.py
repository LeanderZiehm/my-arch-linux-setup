#!/usr/bin/env python3
import os
import shutil
from pathlib import Path

repo = Path.home() / "my-arch-linux-setup/cli"
src = repo / "src"
dst = Path.home() / ".local" / "bin"

dst.mkdir(parents=True, exist_ok=True)

for script in src.glob("*.sh"):
    target = dst / script.stem   # install without ".sh"
    shutil.copy2(script, target)
    target.chmod(0o755)  # make executable
    print(f"✅ Installed {target}")

