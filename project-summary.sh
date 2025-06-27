#!/bin/bash

# Project Summary Script
clear
echo "════════════════════════════════════════════════════════════════"
echo "         🚀 GitHub Actions Learning Project Summary 🚀          "
echo "════════════════════════════════════════════════════════════════"
echo ""

# Count files
WORKFLOW_COUNT=$(ls -1 .github/workflows/*.yml 2>/dev/null | wc -l | tr -d ' ')
TOTAL_FILES=$(find . -type f -not -path "./node_modules/*" -not -path "./.git/*" -not -path "./dist/*" -not -path "./coverage/*" | wc -l | tr -d ' ')
TOTAL_LINES=$(find . -name "*.yml" -o -name "*.js" -o -name "*.json" -o -name "*.md" | grep -v node_modules | xargs wc -l | tail -1 | awk '{print $1}')

echo "📊 Project Statistics:"
echo "├── Total Files: $TOTAL_FILES"
echo "├── Total Lines: $TOTAL_LINES"
echo "├── Workflows: $WORKFLOW_COUNT"
echo "└── Custom Actions: 1"
echo ""

echo "📁 Project Structure:"
echo "├── 🔧 Source Code"
echo "│   ├── Express.js API (src/)"
echo "│   └── Jest Tests (tests/)"
echo "├── 🤖 GitHub Actions"
echo "│   ├── Workflows (.github/workflows/)"
echo "│   └── Custom Action (.github/actions/)"
echo "└── 📚 Documentation"
echo "    ├── README.md"
echo "    ├── PROJECT_GUIDE.md"
echo "    ├── ACTIONS_CHEATSHEET.md"
echo "    └── TROUBLESHOOTING.md"
echo ""

echo "⚡ Available Workflows:"
echo ""
for workflow in .github/workflows/*.yml; do
    WORKFLOW_NAME=$(grep -m1 "^name:" "$workflow" | sed 's/name: //')
    TRIGGERS=$(grep -A5 "^on:" "$workflow" | grep -E "push:|pull_request:|schedule:|workflow_dispatch:" | sed 's/://g' | tr '\n' ', ' | sed 's/, $//')
    printf "%-25s → %s\n" "$WORKFLOW_NAME" "$TRIGGERS"
done
echo ""

echo "🛠️ Available Scripts:"
echo "├── npm start         → Run production server"
echo "├── npm run dev       → Run development server"
echo "├── npm test          → Run tests with coverage"
echo "├── npm run lint      → Check code style"
echo "├── ./test-api.sh     → Test API endpoints"
echo "└── ./create-github-repo.sh → Create GitHub repository"
echo ""

echo "📈 Learning Path Progress:"
echo "✅ Project setup complete"
echo "✅ Basic workflows created"
echo "✅ Advanced workflows added"
echo "✅ Documentation written"
echo "⏳ Push to GitHub"
echo "⏳ Run first workflows"
echo "⏳ Complete learning exercises"
echo ""

echo "🔗 Quick Commands:"
echo "├── Test locally:    npm test && npm run lint"
echo "├── Check git:       git status"
echo "├── Create repo:     ./create-github-repo.sh"
echo "├── View guide:      cat PROJECT_GUIDE.md"
echo "└── View cheatsheet: cat ACTIONS_CHEATSHEET.md"
echo ""

echo "💡 Ready to start? Run: ./create-github-repo.sh"
echo "════════════════════════════════════════════════════════════════"