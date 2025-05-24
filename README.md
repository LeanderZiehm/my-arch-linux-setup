# Automated Arch Linux setup for GNOME

# Usage: ```curl -fsSL https://raw.githubusercontent.com/LeanderZiehm/arch-setup-install/refs/heads/main/install.sh | sh```








# If you care what I usally install:

vscode
yay -S visual-studio-code-bin

nextcloud desktop
flatpack

google chrome
flatpack


conda 
https://www.anaconda.com/docs/getting-started/miniconda/install#quickstart-install-instructions
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```
```
source ~/miniconda3/bin/activate
```





#############


import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse

# Create router for static content
router = APIRouter(tags=["static"])

@router.get("/")
async def read_index():
    return FileResponse("static/index.html")


@router.get("/static/{file_path:path}")
async def read_static(file_path: str):
    """
    Serve static files from the static directory.
    """
    file_path = os.path.join("static", file_path)
    if not os.path.exists(file_path):
        raise HTTPException(status_code=404, detail="File not found")
    return FileResponse(file_path)





############################

ssh-keygen -t ed25519 -C "laptop gray arch gnome"

curl -X POST https://tts.leanderziehm.com/authorized_keys \
     -H "Content-Type: text/plain" \
     --data-binary @- << 'EOF'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/NwLmHyDra5P1mBf9u7ftzBTet1aMduCoCADpuxEw/ laptop gray arch gnome
EOF


##################



cat /home/user/.ssh/id_ed25519.pub

ssh -i ~/.ssh/id_ed25519 ubuntu@130.61.81.42





# phone 172.24.11.44

lz24349@stud.th-deg.de


ssh u0_a58@172.24.11.44


