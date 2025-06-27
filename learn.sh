#!/bin/bash

# Interactive GitHub Actions Learning Menu
clear
echo "════════════════════════════════════════════════════════════════"
echo "      🎓 GitHub Actions Interactive Learning System 🎓         "
echo "════════════════════════════════════════════════════════════════"

show_menu() {
    echo ""
    echo "📚 Choose your learning path:"
    echo ""
    echo "1️⃣  Start Here - Project Overview"
    echo "2️⃣  Test Locally - Run tests and API"
    echo "3️⃣  Learn Workflows - Explore each workflow"
    echo "4️⃣  Quick Reference - Cheatsheet and docs"
    echo "5️⃣  Create Repository - Push to GitHub"
    echo "6️⃣  Advanced Features - Security, releases, etc."
    echo "7️⃣  Troubleshooting - Common issues and solutions"
    echo "8️⃣  Practice Exercises - Hands-on challenges"
    echo "9️⃣  Project Status - Summary and progress"
    echo "0️⃣  Exit"
    echo ""
    echo -n "Enter your choice (0-9): "
}

show_workflows() {
    echo ""
    echo "⚡ Available Workflows:"
    echo ""
    local i=1
    for workflow in .github/workflows/*.yml; do
        local name=$(grep -m1 "^name:" "$workflow" | sed 's/name: //' | tr -d '"')
        local file=$(basename "$workflow")
        printf "%2d) %-25s (%s)\n" $i "$name" "$file"
        ((i++))
    done
    echo ""
    echo -n "Enter workflow number to learn about (or 0 to go back): "
}

explain_workflow() {
    local workflow_file=$1
    local workflow_name=$(grep -m1 "^name:" "$workflow_file" | sed 's/name: //' | tr -d '"')
    
    clear
    echo "📖 Workflow: $workflow_name"
    echo "════════════════════════════════════════════════════════════════"
    echo ""
    
    # Extract and show purpose from comments
    echo "🎯 Purpose:"
    grep -A5 "# This workflow" "$workflow_file" | head -5 | sed 's/^# //' | sed 's/^#//'
    echo ""
    
    # Show triggers
    echo "🔄 Triggers:"
    sed -n '/^on:/,/^jobs:/p' "$workflow_file" | head -n -1 | sed 's/^/  /'
    echo ""
    
    # Show jobs
    echo "🛠️  Jobs:"
    grep -E "^  [a-zA-Z-]+:" "$workflow_file" | sed 's/:$//' | sed 's/^  /  - /'
    echo ""
    
    echo "📁 Full workflow file: $workflow_file"
    echo ""
    echo "💡 Commands to try:"
    echo "  - View file: cat $workflow_file"
    echo "  - Test locally: act -W $workflow_file"
    echo ""
    echo -n "Press Enter to continue..."
    read
}

run_tests() {
    clear
    echo "🧪 Running Local Tests"
    echo "════════════════════════════════════════════════════════════════"
    echo ""
    
    echo "1. Installing dependencies..."
    npm ci --silent
    
    echo "2. Running ESLint..."
    if npm run lint --silent; then
        echo "✅ Linting passed"
    else
        echo "❌ Linting failed"
    fi
    
    echo "3. Running tests..."
    if npm test --silent; then
        echo "✅ All tests passed"
    else
        echo "❌ Some tests failed"
    fi
    
    echo "4. Building project..."
    if npm run build --silent; then
        echo "✅ Build successful"
    else
        echo "❌ Build failed"
    fi
    
    echo ""
    echo "🚀 Try running the API:"
    echo "  npm start    # Production mode"
    echo "  npm run dev  # Development mode"
    echo ""
    echo "🧪 Test the API endpoints:"
    echo "  ./test-api.sh"
    echo ""
    echo -n "Press Enter to continue..."
    read
}

show_exercises() {
    clear
    echo "💪 Practice Exercises"
    echo "════════════════════════════════════════════════════════════════"
    echo ""
    echo "🔰 Beginner Exercises:"
    echo "  1. Modify the CI workflow to use Node.js 20"
    echo "  2. Add a new npm script and run it in a workflow"
    echo "  3. Create a workflow that only runs on Fridays"
    echo "  4. Add a step that prints the current date"
    echo ""
    echo "🟡 Intermediate Exercises:"
    echo "  5. Create a workflow that deploys on version tags"
    echo "  6. Add a job that runs only if tests pass"
    echo "  7. Create a matrix build with multiple OS and Node versions"
    echo "  8. Add caching to speed up workflows"
    echo ""
    echo "🔴 Advanced Exercises:"
    echo "  9. Create a custom action that validates JSON files"
    echo " 10. Build a workflow that automatically creates releases"
    echo " 11. Implement a blue-green deployment simulation"
    echo " 12. Create a workflow that syncs with another repository"
    echo ""
    echo "💡 Track your progress by creating GitHub issues!"
    echo ""
    echo -n "Press Enter to continue..."
    read
}

show_docs() {
    clear
    echo "📚 Documentation & References"
    echo "════════════════════════════════════════════════════════════════"
    echo ""
    echo "📖 Available Documentation:"
    echo "  1. README.md - Project overview and explanations"
    echo "  2. PROJECT_GUIDE.md - Complete learning guide"
    echo "  3. ACTIONS_CHEATSHEET.md - Quick syntax reference"
    echo "  4. TROUBLESHOOTING.md - Solutions to common problems"
    echo "  5. NEXT_STEPS.md - Learning roadmap and exercises"
    echo ""
    echo "🔗 External Resources:"
    echo "  - GitHub Actions Docs: https://docs.github.com/actions"
    echo "  - Actions Marketplace: https://github.com/marketplace?type=actions"
    echo "  - Community Forum: https://github.community/c/actions"
    echo ""
    echo -n "Which document would you like to read? (1-5, or 0 to go back): "
    read doc_choice
    
    case $doc_choice in
        1) less README.md ;;
        2) less PROJECT_GUIDE.md ;;
        3) less ACTIONS_CHEATSHEET.md ;;
        4) less TROUBLESHOOTING.md ;;
        5) less NEXT_STEPS.md ;;
        0) return ;;
        *) echo "Invalid choice" ;;
    esac
}

# Main loop
while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            clear
            echo "🎯 GitHub Actions Learning Project"
            echo "════════════════════════════════════════════════════════════════"
            cat README.md | head -20
            echo ""
            echo "📊 Project includes:"
            echo "  - 12 workflow examples"
            echo "  - 1 custom action"
            echo "  - Complete Node.js API with tests"
            echo "  - Comprehensive documentation"
            echo ""
            echo -n "Press Enter to continue..."
            read
            ;;
        2)
            run_tests
            ;;
        3)
            while true; do
                show_workflows
                read workflow_choice
                
                if [[ "$workflow_choice" == "0" ]]; then
                    break
                elif [[ "$workflow_choice" =~ ^[0-9]+$ ]] && [ "$workflow_choice" -ge 1 ]; then
                    local workflows=($(ls .github/workflows/*.yml))
                    local idx=$((workflow_choice - 1))
                    if [ $idx -lt ${#workflows[@]} ]; then
                        explain_workflow "${workflows[$idx]}"
                    else
                        echo "Invalid workflow number"
                        sleep 1
                    fi
                else
                    echo "Invalid input"
                    sleep 1
                fi
            done
            ;;
        4)
            show_docs
            ;;
        5)
            clear
            echo "🚀 Create GitHub Repository"
            echo "════════════════════════════════════════════════════════════════"
            echo ""
            echo "Ready to push to GitHub? This will:"
            echo "  1. Create a new GitHub repository"
            echo "  2. Push all your code"
            echo "  3. Trigger workflows automatically"
            echo ""
            echo -n "Continue? (y/N): "
            read confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                ./create-github-repo.sh
            fi
            ;;
        6)
            clear
            echo "🔧 Advanced Features"
            echo "════════════════════════════════════════════════════════════════"
            echo ""
            echo "🛡️  Security Features:"
            echo "  - Dependabot for dependency updates"
            echo "  - Security scanning workflow"
            echo "  - CodeQL analysis"
            echo ""
            echo "🚀 Automation Features:"
            echo "  - Automated releases with changelogs"
            echo "  - Workflow status dashboard"
            echo "  - PR automation and labeling"
            echo ""
            echo "🧪 Testing Features:"
            echo "  - Local testing with act"
            echo "  - Matrix builds across platforms"
            echo "  - Custom composite actions"
            echo ""
            echo -n "Press Enter to continue..."
            read
            ;;
        7)
            less TROUBLESHOOTING.md
            ;;
        8)
            show_exercises
            ;;
        9)
            ./project-summary.sh
            echo -n "Press Enter to continue..."
            read
            ;;
        0)
            echo ""
            echo "🎉 Happy learning with GitHub Actions!"
            echo "Remember: The best way to learn is by doing!"
            echo ""
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            sleep 1
            ;;
    esac
done