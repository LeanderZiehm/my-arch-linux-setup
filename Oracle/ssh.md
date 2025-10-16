# Oracle



sudo iptables-save > firewallnew
vim firewallnew 
sudo iptables-restore < firewallnew

ssh -i ~/.ssh/id_ed25519 ubuntu@130.61.81.42



sudo vim /etc/nginx/sites-available/fastkoko.leanderziehm.com

server {
    listen 80;
    server_name fastkoko.leanderziehm.com;

    location / {
        proxy_pass http://localhost:8880;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

sudo ln -s /etc/nginx/sites-available/fastkoko.leanderziehm.com /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d fastkoko.leanderziehm.com








----



sudo vim /etc/nginx/sites-available/app.tandemexchange.de

server {
    listen 80;
    server_name app.tandemexchange.de;

    location / {
        proxy_pass http://localhost:5015;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

sudo ln -s /etc/nginx/sites-available/app.tandemexchange.de /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d app.tandemexchange.de




tmux new-session -t chatgpt-code-zip
cd projects
git clone https://github.com/LeanderZiehm/convert-chatgpt-code-to-zip
pip install -r requirements.txt
uvicorn main:app --reload --port 5013 


curl -i http://localhost:5000 : LLMANO
curl -i http://localhost:5001 : my-hub
curl -i http://localhost:5002 : Bookmarks
curl -i http://localhost:5004 : timetrack.leanderziehm.com
curl -i http://localhost:5005 : Webhooks  ??? 
curl -i http://localhost:5006 : TTS-hub
curl -i http://localhost:5007 : notes
curl -i http://localhost:5008 : pdf-web-app ?
curl -i http://localhost:5009 : mindmap ? 
curl -i http://localhost:5010 : lovelingo 
curl -i http://localhost:5011 : api-web-app ??
curl -i http://localhost:5012 : bayern-hackathon PDF Chat & Form Filler
curl -i http://localhost:5013 : chatgpt-code-zip
curl -i http://localhost:5014 : get-dynamic-image-per-request  
curl -i http://localhost:5015 : 


curl -i http://localhost:8001 : notifications.leanderziehm.com

curl -i http://localhost:9000 : portainer.leanderziehm.com
curl -i http://localhost:9001 : deploy.leanderziehm.com git-deploy




sudo iptables-save > ~/current-iptables.rules
vim current-iptables.rules
sudo iptables-restore < current-iptables.rules


