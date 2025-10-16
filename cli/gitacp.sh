git add .
files=$(git diff --cached --name-only)
if [ -z "$files" ]; then
  echo "No changes to commit."
  return
fi
msg="update: changed $(echo $files | tr '\n' ' ' | sed 's/ $//')"
git commit -m "$msg"
git push
