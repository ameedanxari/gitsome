#!/bin/bash

REPO_DIR="."
GIT_USER="ameedanxari"
GIT_EMAIL="ameedanxari@gmail.com"
REMOTE_URL="git@github.com:ameedanxari/gitsome.git"

cd $REPO_DIR
git config user.name "$GIT_USER"
git config user.email "$GIT_EMAIL"

touch activity.log
git add activity.log
git commit -m "Initial commit"

generate_commits() {
  local start_date=$1
  local end_date=$2
  local current_date=$start_date

  while [ "$current_date" != "$end_date" ]; do
    if [ $((RANDOM % 4)) -eq 0 ]; then
      num_commits=$((RANDOM % 3 + 1))
      for ((i=1; i<=num_commits; i++)); do
        echo "Commit on $current_date at $i" >> activity.log
        git add activity.log
        export GIT_AUTHOR_DATE="$current_date 12:$((RANDOM % 60)):00"
        export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
        git commit -m "Commit $i on $current_date"
      done
    fi
    current_date=$(date -I -d "$current_date + 1 day")
  done
}

START_DATE=$(date -I -d "2 years ago")
END_DATE=$(date -I -d "yesterday")

generate_commits "$START_DATE" "$END_DATE"
