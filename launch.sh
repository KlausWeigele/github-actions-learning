#!/bin/bash

# GitHub Actions Learning Project Launcher
clear

cat << 'EOF'
   ╔═══════════════════════════════════════════════════════════════╗
   ║                                                               ║
   ║    🚀 GitHub Actions Learning Project 🚀                     ║
   ║                                                               ║
   ║    Your complete hands-on learning environment               ║
   ║    for mastering GitHub Actions!                             ║
   ║                                                               ║
   ╚═══════════════════════════════════════════════════════════════╝
EOF

echo ""
echo "🎯 What would you like to do?"
echo ""
echo "🚀 QUICK START"
echo "  1. 📚 Interactive Learning Menu"
echo "  2. 🧪 Test Everything Locally"
echo "  3. 📊 View Project Summary"
echo ""
echo "🔧 SETUP & DEPLOYMENT"
echo "  4. 🌐 Create GitHub Repository"
echo "  5. ⚙️  Setup Local Testing (act)"
echo "  6. 🔍 Validate All Workflows"
echo ""
echo "📈 ANALYSIS & OPTIMIZATION"
echo "  7. ⚡ Performance Analysis"
echo "  8. 🔬 Workflow Deep Dive"
echo "  9. 📖 Documentation Browser"
echo ""
echo "🛠️  DEVELOPMENT"
echo " 10. 🏃 Run API Server"
echo " 11. 🧪 Test API Endpoints"
echo " 12. 📦 Build Project"
echo ""
echo "  0. 🚪 Exit"
echo ""
echo -n "Enter your choice (0-12): "

read choice

case $choice in
    1)
        echo ""
        echo "🎓 Launching Interactive Learning Menu..."
        ./learn.sh
        ;;
    2)
        echo ""
        echo "🧪 Running Local Tests..."
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        
        echo "1. Installing dependencies..."
        npm ci --silent
        
        echo "2. Running linter..."
        if npm run lint --silent; then
            echo "✅ Linting passed"
        else
            echo "❌ Linting issues found"
        fi
        
        echo "3. Running tests..."
        if npm test --silent; then
            echo "✅ All tests passed"
        else
            echo "❌ Test failures detected"
        fi
        
        echo "4. Building project..."
        if npm run build --silent; then
            echo "✅ Build successful"
        else
            echo "❌ Build failed"
        fi
        
        echo ""
        echo "🎉 Local testing complete!"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        ;;
    3)
        echo ""
        echo "📊 Generating Project Summary..."
        ./project-summary.sh
        ;;
    4)
        echo ""
        echo "🌐 GitHub Repository Creation..."
        ./create-github-repo.sh
        ;;
    5)
        echo ""
        echo "⚙️ Setting up Local Testing Environment..."
        ./setup-act.sh
        ;;
    6)
        echo ""
        echo "🔍 Validating All Workflows..."
        ./validate-workflows.sh
        ;;
    7)
        echo ""
        echo "⚡ Analyzing Workflow Performance..."
        ./analyze-performance.sh
        ;;
    8)
        echo ""
        echo "🔬 Workflow Analysis Menu"
        echo "═══════════════════════════"
        echo ""
        select workflow in .github/workflows/*.yml "Back to main menu"; do
            if [[ "$workflow" == "Back to main menu" ]]; then
                break
            elif [[ -f "$workflow" ]]; then
                echo ""
                echo "📄 Analyzing: $(basename "$workflow")"
                echo "─────────────────────────────────────────────────────"
                
                # Show workflow purpose
                echo "🎯 Purpose:"
                grep -A3 "# This workflow" "$workflow" | sed 's/^# //' | sed 's/^#//'
                echo ""
                
                # Show structure
                echo "🏗️  Structure:"
                echo "  Triggers: $(sed -n '/^on:/,/^jobs:/p' "$workflow" | grep -E "(push|pull_request|schedule|workflow_dispatch)" | tr '\n' ' ')"
                echo "  Jobs: $(grep -c "^  [a-zA-Z-]*:" "$workflow")"
                echo "  Steps: $(grep -c "^      - " "$workflow")"
                echo ""
                
                echo "📖 View full file? (y/N)"
                read view_file
                if [[ "$view_file" =~ ^[Yy]$ ]]; then
                    less "$workflow"
                fi
                echo ""
            else
                echo "Invalid selection"
            fi
        done
        ;;
    9)
        echo ""
        echo "📖 Documentation Browser"
        echo "═══════════════════════"
        echo ""
        select doc in "README.md" "PROJECT_GUIDE.md" "ACTIONS_CHEATSHEET.md" "TROUBLESHOOTING.md" "NEXT_STEPS.md" "Back to main menu"; do
            if [[ "$doc" == "Back to main menu" ]]; then
                break
            elif [[ -f "$doc" ]]; then
                less "$doc"
            else
                echo "Invalid selection"
            fi
        done
        ;;
    10)
        echo ""
        echo "🏃 Starting API Server..."
        echo "The server will run on http://localhost:3000"
        echo "Press Ctrl+C to stop the server"
        echo ""
        npm start
        ;;
    11)
        echo ""
        echo "🧪 Testing API Endpoints..."
        ./test-api.sh
        ;;
    12)
        echo ""
        echo "📦 Building Project..."
        if npm run build; then
            echo ""
            echo "✅ Build completed successfully!"
            echo "📁 Output in: ./dist/"
            ls -la dist/
        else
            echo ""
            echo "❌ Build failed!"
        fi
        ;;
    0)
        echo ""
        echo "👋 Thanks for using the GitHub Actions Learning Project!"
        echo ""
        echo "🎯 Remember:"
        echo "  • The best way to learn is by doing"
        echo "  • Push to GitHub to see workflows in action"
        echo "  • Experiment and break things - that's how you learn!"
        echo ""
        echo "📚 Resources:"
        echo "  • ./learn.sh - Interactive learning menu"
        echo "  • PROJECT_GUIDE.md - Complete learning guide"
        echo "  • ACTIONS_CHEATSHEET.md - Quick reference"
        echo ""
        echo "Happy learning! 🚀"
        exit 0
        ;;
    *)
        echo ""
        echo "❌ Invalid choice. Please try again."
        sleep 2
        exec "$0"
        ;;
esac

echo ""
echo "───────────────────────────────────────────────────────────────"
echo "🔄 Return to main menu? (y/N)"
read return_menu
if [[ "$return_menu" =~ ^[Yy]$ ]]; then
    exec "$0"
else
    echo ""
    echo "👋 Happy learning with GitHub Actions!"
fi