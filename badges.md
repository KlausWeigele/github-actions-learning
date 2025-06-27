# GitHub Actions Status Badges

Add these badges to your README to show the status of your workflows!

## How to Use

1. Replace `YOUR_USERNAME` with your GitHub username
2. Replace `YOUR_REPO` with your repository name
3. Copy the markdown and paste it into your README

## Workflow Badges

### CI Pipeline
```markdown
![CI Pipeline](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/CI%20Pipeline/badge.svg)
```

### Build and Deploy
```markdown
![Build and Deploy](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Build%20and%20Deploy/badge.svg)
```

### Matrix Testing
```markdown
![Matrix Testing](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Matrix%20Testing/badge.svg)
```

## Combined Badge Section

Add this to the top of your README:

```markdown
## Status

![CI Pipeline](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/CI%20Pipeline/badge.svg)
![Build and Deploy](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Build%20and%20Deploy/badge.svg)
![Matrix Testing](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Matrix%20Testing/badge.svg)
```

## Custom Badge Colors

You can also create custom badges using shields.io:

```markdown
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-Learning-2088FF?logo=github-actions&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-18+-339933?logo=node.js&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)
```

## Advanced: Dynamic Badges

For test coverage:
```markdown
![Coverage](https://img.shields.io/badge/Coverage-97%25-brightgreen)
```

For last commit:
```markdown
![Last Commit](https://img.shields.io/github/last-commit/YOUR_USERNAME/YOUR_REPO)
```

For open issues:
```markdown
![Issues](https://img.shields.io/github/issues/YOUR_USERNAME/YOUR_REPO)
```