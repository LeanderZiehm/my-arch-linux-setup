# Oracle

# add new ngnix endpoint:  change top and port

sudo vim /etc/nginx/sites-available/chatgpt-code-zip.leanderziehm.com

server {
    listen 80;
    server_name chatgpt-code-zip.leanderziehm.com;

    location / {
        proxy_pass http://localhost:5012;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

sudo ln -s /etc/nginx/sites-available/chatgpt-code-zip.leanderziehm.com /etc/nginx/sites-enabled/

sudo nginx -t && sudo systemctl reload nginx

sudo certbot --nginx -d chatgpt-code-zip.leanderziehm.com

tmux new-session -t chatgpt-code-zip

cd projects

git clone https://github.com/LeanderZiehm/convert-chatgpt-code-to-zip

pip install -r requirements.txt

uvicorn main:app --reload --port 5013 


curl -i http://localhost:5000 : LLMANO
curl -i http://localhost:5001 : my-hub
curl -i http://localhost:5002 : Bookmarks
curl -i http://localhost:5004 : timetrack.leanderziehm.com
curl -i http://localhost:5005 : Webhooks
curl -i http://localhost:5006 : TTS-hub
curl -i http://localhost:5007 : notes
curl -i http://localhost:5008 : pdf-web-app
curl -i http://localhost:5009 : mindmap
curl -i http://localhost:5010 : lovelingo 
curl -i http://localhost:5011 : api-web-app 
curl -i http://localhost:5012 : bayern-hackathon PDF Chat & Form Filler
curl -i http://localhost:5013 : chatgpt-code-zip

curl -i http://localhost:9000 : deploy.leanderziehm.com


have this stored / backedup somewhere
