echo 'gitacp() { if [ -z "$1" ]; then msg="+"; else msg="$*"; fi; git add .; git commit -m "$msg"; git push; }' >> ~/.bashrc
source ~/.bashrc



