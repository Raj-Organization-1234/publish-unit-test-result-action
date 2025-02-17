#!/bin/bash

# Ensure we are on the main branch
git checkout main
git pull origin main

# Create a new branch for cherry-pick
BRANCH_NAME="auto-cherry-pick-$(date +'%Y-%m-%d-%H-%M-%S')"
echo "Creating a new branch: $BRANCH_NAME..."
git checkout -b "$BRANCH_NAME"

git cherry-pick --abort || true

# Initialize variables
SKIPPED_COMMITS=""
CHANGES_FOUND=false

# List of commits to cherry-pick (replace with actual commit hashes)
NEW_COMMITS=("11089dfba4fe1676341e7528615f0fb22caec29b")

git push --set-upstream origin "$BRANCH_NAME"
# Process each commit
for COMMIT_HASH in "${NEW_COMMITS[@]}"; do
  echo "Processing commit: $COMMIT_HASH"

  # Ensure previous cherry-pick is clean before attempting a new one
  git cherry-pick --abort || true

  # Try cherry-picking the commit
  git cherry-pick "$COMMIT_HASH"
  git push


done

# If changes were successfully cherry-picked, commit and push the new branch
# if [ "$CHANGES_FOUND" = true ]; then
#   git add .
#   git commit -m "Cherry-picked commits from upstream"
#   git push origin "$BRANCH_NAME"
#   echo "✅ Pushed changes to branch: $BRANCH_NAME"
# else
#   echo "⚠️ No changes after cherry-pick. Skipping further steps."
# fi

# # Display skipped commits, if any
# if [ -n "$SKIPPED_COMMITS" ]; then
#   echo -e "Skipped commits:\n$SKIPPED_COMMITS"
# fi
