#!/bin/bash

# Exit immediately on errors
set -e

# Set working directory
cd "$GITHUB_WORKSPACE"

# Load WakaTime API key from environment variables
WAKATIME_API_KEY=$1

# Get the user's coding time in the last week
coding_time=$(curl -s "https://wakatime.com/api/v1/users/current/stats/last_7_days" \
  -H "Authorization: Basic $(echo -n $WAKATIME_API_KEY | base64)" \
  -H "Content-Type: application/json" | jq -r '.data | .[] | select(.name=="Coding") | .text')

# Replace the placeholder text in the readme file with the user's coding time
sed -i 's/<!-- Edit here -->/Coding Time Last Week: '"$coding_time"'/g' README.md

# Commit the changes
git config --global user.email "actions@github.com"
git config --global user.name "GitHub Actions"
git add README.md
git commit -m "Update readme with WakaTime stats [skip ci]"
