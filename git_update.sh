# Define your Git username and personal access token
BRANCH_NAME="master" # Default branch
REPO_URL="github.com/mafshari64/automated_workflow.git"


pip install git-filter-repo
git filter-repo --path update_git.sh --invert-paths --replace-text <(echo 'GITHUB_TOKEN==REDACTED')

GIT_USERNAME="mafshari64"
GIT_TOKEN="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" #https://github.com/settings/tokens 


# Validate branch name
if [ -z "$BRANCH_NAME" ]; then
    echo "Error: Branch name cannot be empty."
    exit 1
fi

# Set Git credentials for the session
git config --global user.name "$GIT_USERNAME"
git config --global user.password "$GIT_TOKEN"

module load git

# which repository
echo="is repository correct?"
git remote -v


# Check status
echo "Checking repository status..."
git status

echo "Do you want to proceed to add all changes? (y/no)"
read PROCEED_ADD
if [ "$PROCEED_ADD" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Prompt for files to add
echo "Enter files to add (or '.' to add all changes):"
git add .

# Verify changes to be committed
echo "Reviewing changes to be committed..."
git status


# Display diff and ask for user input
echo "Changes to be committed are extensive. Do you want to review them? (y/no)"
read REVIEW_DIFF
if [ "$REVIEW_DIFF" == "y" ]; then
    git diff --cached | head -n 100 #| less
    # git diff --cached | less
    echo "Press 'q' to exit the pager."
fi


echo "Do you want to proceed to commit changes? (y/no)"
read PROCEED_COMMIT
if [ "$PROCEED_COMMIT" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Commit changes
echo "Enter commit message:"
read COMMIT_MESSAGE
git commit -m "$COMMIT_MESSAGE"

# Verify the commit
echo "Commit made. Reviewing commit log..."
git log -1

echo "Do you want to proceed to push changes? (y/no)"
read PROCEED_PUSH
if [ "$PROCEED_PUSH" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Push changes
echo " push changes :"

git push https://$GIT_USERNAME:$GIT_TOKEN@$REPO_URL "$BRANCH_NAME"

echo "Changes pushed to branch $BRANCH_NAME."
