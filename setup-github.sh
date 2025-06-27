#!/bin/bash

# GitHub Setup Script for GitHub Actions Learning Project
echo "🚀 GitHub Actions Learning Project - Setup Script"
echo "================================================"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "❌ Git is not initialized. Please run: git init"
    exit 1
fi

echo "✅ Git repository found"
echo ""

# Display current status
echo "📊 Current repository status:"
git status --short
echo ""

# Provide instructions
echo "📝 Follow these steps to push to GitHub:"
echo ""
echo "1. Create a new repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Name it 'github-actions-learning' (or your preferred name)"
echo "   - Don't initialize with README (we already have one)"
echo "   - Keep it public to use GitHub Actions for free"
echo ""
echo "2. Add your GitHub repository as remote:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/github-actions-learning.git"
echo ""
echo "3. Create initial commit (if not already done):"
echo "   git add ."
echo "   git commit -m 'Initial commit: GitHub Actions learning project'"
echo ""
echo "4. Push to GitHub:"
echo "   git push -u origin main"
echo "   (or 'git push -u origin master' if your default branch is master)"
echo ""
echo "5. View your workflows:"
echo "   - Go to your repository on GitHub"
echo "   - Click on the 'Actions' tab"
echo "   - Watch your workflows run automatically!"
echo ""
echo "💡 Tips:"
echo "- The CI workflow will run immediately after your first push"
echo "- Try creating a pull request to see the CI workflow in action"
echo "- Use the 'Actions' tab to manually trigger the 'Manual Workflow'"
echo "- Check back daily to see the scheduled workflows run"
echo ""
echo "Happy learning! 🎉"