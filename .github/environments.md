# GitHub Environments Configuration

This document explains how to set up GitHub Environments for the deployment workflows.

## Setting Up Environments

1. Go to your repository on GitHub
2. Navigate to Settings → Environments
3. Create the following environments:

### Staging Environment
- Click "New environment"
- Name: `staging`
- No special protection rules needed for learning

### Production Environment
- Click "New environment"  
- Name: `production`
- Recommended protection rules:
  - ✅ Required reviewers (add yourself)
  - ✅ Restrict deployments to specific branches (main/master only)

## Adding Secrets

For real deployments, you might need secrets. Here's how to add them:

1. In each environment, click "Add secret"
2. Common secrets you might add:
   - `API_KEY` - For external service authentication
   - `DEPLOY_TOKEN` - For deployment authentication
   - `SLACK_WEBHOOK` - For notifications

## Environment URLs

You can also set environment URLs:
- Staging: `https://staging.yourapp.com`
- Production: `https://yourapp.com`

These will appear in the GitHub UI when deployments complete.