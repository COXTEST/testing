#!/bin/bash

# Set GitHub Personal Access Token and GitHub host
# export GH_PAT="your_github_personal_access_token"
export GH_HOST="github.com"

# Authenticate with GitHub
gh auth login --hostname $GH_HOST

# List all open pull requests
gh pr list