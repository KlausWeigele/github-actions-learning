#!/bin/bash

# Setup act for local GitHub Actions testing
echo "🔧 Setting up 'act' for local workflow testing"
echo "=============================================="
echo ""

# Check if act is installed
if command -v act &> /dev/null; then
    echo "✅ act is already installed (version: $(act --version))"
else
    echo "📦 Installing act..."
    
    # Detect OS and install act
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            echo "Using Homebrew to install act..."
            brew install act
        else
            echo "Using curl to install act..."
            curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "Using curl to install act..."
        curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
    else
        echo "❌ Unsupported OS. Please install act manually:"
        echo "   https://github.com/nektos/act"
        exit 1
    fi
fi

echo ""
echo "📝 Creating act configuration..."

# Create .actrc file for default configuration
cat > .actrc << 'EOF'
# Default image to use for ubuntu-latest
-P ubuntu-latest=catthehacker/ubuntu:act-latest
-P ubuntu-22.04=catthehacker/ubuntu:act-22.04
-P ubuntu-20.04=catthehacker/ubuntu:act-20.04
-P ubuntu-18.04=catthehacker/ubuntu:act-18.04

# Default runner size
--container-architecture linux/amd64
EOF

# Create secrets file template
cat > .secrets << 'EOF'
# GitHub Actions secrets for local testing
# Uncomment and add your secrets here
# GITHUB_TOKEN=your_github_token_here
# NPM_TOKEN=your_npm_token_here
# API_KEY=your_api_key_here
EOF

# Create act event payloads
mkdir -p .github/act-events

# Push event
cat > .github/act-events/push.json << 'EOF'
{
  "push": {
    "ref": "refs/heads/main",
    "repository": {
      "name": "github-actions-learning",
      "full_name": "user/github-actions-learning"
    },
    "head_commit": {
      "message": "Test commit for act",
      "id": "abc123"
    }
  }
}
EOF

# Pull request event
cat > .github/act-events/pull_request.json << 'EOF'
{
  "pull_request": {
    "number": 1,
    "title": "Test PR for act",
    "user": {
      "login": "testuser"
    },
    "head": {
      "ref": "feature/test"
    },
    "base": {
      "ref": "main"
    }
  }
}
EOF

# Manual dispatch event
cat > .github/act-events/workflow_dispatch.json << 'EOF'
{
  "inputs": {
    "environment": "staging",
    "version": "1.0.0",
    "run-tests": true,
    "log-level": "info"
  }
}
EOF

echo "✅ Act configuration created"
echo ""
echo "📚 Act Usage Examples:"
echo ""
echo "# List all workflows"
echo "act -l"
echo ""
echo "# Run CI workflow"
echo "act -W .github/workflows/ci.yml"
echo ""
echo "# Run specific job"
echo "act -j test"
echo ""
echo "# Run with specific event"
echo "act push -e .github/act-events/push.json"
echo ""
echo "# Run with secrets"
echo "act -s GITHUB_TOKEN=\$GITHUB_TOKEN"
echo ""
echo "# Run in verbose mode"
echo "act -v"
echo ""
echo "# Dry run (see what would run)"
echo "act -n"
echo ""
echo "⚠️  Note: Add .secrets and .actrc to .gitignore!"