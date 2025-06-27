#!/bin/bash

# GitHub Repository Creation Script
echo "🚀 GitHub Repository Creation Helper"
echo "===================================="
echo ""

# Check if gh is authenticated
if ! gh auth status >/dev/null 2>&1; then
    echo "❌ GitHub CLI is not authenticated"
    echo "Please run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is authenticated"
echo ""

# Get repository name
read -p "Enter repository name (default: github-actions-learning): " REPO_NAME
REPO_NAME=${REPO_NAME:-github-actions-learning}

# Get repository description
read -p "Enter repository description: " REPO_DESC
REPO_DESC=${REPO_DESC:-"A comprehensive project to learn GitHub Actions with practical examples"}

# Get visibility
echo "Repository visibility:"
echo "1) Public (recommended for GitHub Actions learning)"
echo "2) Private"
read -p "Choose visibility (1 or 2, default: 1): " VISIBILITY
VISIBILITY=${VISIBILITY:-1}

if [ "$VISIBILITY" == "2" ]; then
    VISIBILITY_FLAG="--private"
else
    VISIBILITY_FLAG="--public"
fi

# Create repository
echo ""
echo "📝 Creating repository with:"
echo "- Name: $REPO_NAME"
echo "- Description: $REPO_DESC"
echo "- Visibility: $([ "$VISIBILITY" == "2" ] && echo "Private" || echo "Public")"
echo ""

read -p "Continue? (y/N): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Cancelled"
    exit 0
fi

# Create the repository
echo ""
echo "🔧 Creating repository..."
if gh repo create "$REPO_NAME" --description "$REPO_DESC" $VISIBILITY_FLAG --source=. --remote=origin --push; then
    echo ""
    echo "✅ Repository created successfully!"
    echo ""
    
    # Get repository URL
    REPO_URL=$(gh repo view --json url -q .url)
    echo "📌 Repository URL: $REPO_URL"
    echo ""
    
    # Open in browser
    read -p "Open repository in browser? (y/N): " OPEN_BROWSER
    if [[ "$OPEN_BROWSER" =~ ^[Yy]$ ]]; then
        gh repo view --web
    fi
    
    echo ""
    echo "🎯 Next Steps:"
    echo "1. Go to the Actions tab in your repository"
    echo "2. Watch the CI workflow run automatically"
    echo "3. Try manually triggering the 'Manual Workflow'"
    echo "4. Create a pull request to see PR workflows"
    echo "5. Check tomorrow for scheduled workflows"
    echo ""
    echo "📚 Documentation:"
    echo "- README.md - Project overview"
    echo "- PROJECT_GUIDE.md - Complete learning guide"
    echo "- ACTIONS_CHEATSHEET.md - Quick reference"
    echo ""
else
    echo ""
    echo "❌ Failed to create repository"
    echo ""
    echo "Alternative: Create manually and push"
    echo "1. Create repository at: https://github.com/new"
    echo "2. Run: git remote add origin https://github.com/YOUR_USERNAME/$REPO_NAME.git"
    echo "3. Run: git push -u origin master"
fi