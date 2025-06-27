# GitHub Actions Learning Project 🚀

This project is designed to help you learn GitHub Actions through practical, hands-on examples. It includes a simple Node.js Express API with comprehensive GitHub Actions workflows demonstrating various CI/CD concepts.

## 📚 Table of Contents

- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Workflows Explained](#workflows-explained)
- [Custom Actions](#custom-actions)
- [Testing Locally](#testing-locally)
- [Learning Resources](#learning-resources)

## 🎯 Project Overview

This learning project includes:

- **Simple Express.js API** - A basic REST API with CRUD operations
- **Comprehensive test suite** - Jest tests demonstrating testing best practices
- **Multiple GitHub Actions workflows** - Real-world examples of CI/CD pipelines
- **Custom composite action** - Learn how to create reusable actions

## 🚀 Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- Git
- GitHub account

### Local Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd github-actions-learning
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run tests:
   ```bash
   npm test
   ```

4. Start the development server:
   ```bash
   npm run dev
   ```

### Pushing to GitHub

1. Create a new repository on GitHub
2. Push your code:
   ```bash
   git add .
   git commit -m "Initial commit"
   git remote add origin <your-github-repo-url>
   git push -u origin main
   ```

## 📋 Workflows Explained

### 1. CI Pipeline (`ci.yml`)

**Purpose**: Runs on every push and pull request to ensure code quality.

**Key Features**:
- Automated testing on code changes
- ESLint for code quality
- Test coverage reporting
- PR comment integration

**When it runs**: On push to main/develop branches and on all pull requests

**Learning points**:
- Basic workflow structure
- Using GitHub Actions contexts
- Artifact uploading
- Conditional steps

### 2. Build and Deploy (`deploy.yml`)

**Purpose**: Demonstrates a multi-stage deployment pipeline.

**Key Features**:
- Build artifacts creation
- Multiple deployment environments (staging, production)
- Environment protection rules
- Manual approval gates

**When it runs**: On push to main branch or manual trigger

**Learning points**:
- Environment variables
- Job dependencies
- GitHub environments
- Deployment strategies

### 3. Scheduled Jobs (`scheduled.yml`)

**Purpose**: Shows how to run periodic maintenance tasks.

**Key Features**:
- Cron syntax for scheduling
- Security audits
- Dependency updates checking
- Report generation

**When it runs**: Daily at 2 AM UTC and weekly on Mondays

**Learning points**:
- Cron expressions in GitHub Actions
- Conditional job execution
- Working with git history
- Automated maintenance tasks

### 4. Manual Dispatch (`manual.yml`)

**Purpose**: Demonstrates manually triggered workflows with inputs.

**Key Features**:
- Custom workflow inputs (dropdowns, text, boolean)
- Input validation
- Dynamic job configuration
- Environment-specific deployments

**When it runs**: Only when manually triggered

**Learning points**:
- workflow_dispatch event
- Input types and validation
- Dynamic environment configuration
- Conditional job execution

### 5. Matrix Testing (`matrix.yml`)

**Purpose**: Test across multiple configurations simultaneously.

**Key Features**:
- Multi-OS testing (Ubuntu, Windows, macOS)
- Multiple Node.js versions
- Including/excluding specific combinations
- Parallel job execution

**When it runs**: On push and pull requests

**Learning points**:
- Matrix strategy
- Dynamic job names
- Platform-specific commands
- Handling experimental builds

### 6. Reusable Workflows (`reusable.yml` & `caller.yml`)

**Purpose**: Create modular, reusable workflow components.

**Key Features**:
- Workflow inputs and outputs
- Secret passing
- Workflow composition
- Output handling

**When it runs**: When called by other workflows

**Learning points**:
- workflow_call event
- Workflow reusability
- Input/output contracts
- Workflow composition patterns

## 🔧 Custom Actions

### Setup and Test Action

Located in `.github/actions/setup-and-test/`

**Purpose**: A reusable composite action for Node.js setup and testing.

**Features**:
- Configurable Node.js version
- Custom install and test commands
- Output values
- GitHub Step Summary integration

**Usage example**:
```yaml
- uses: ./.github/actions/setup-and-test
  with:
    node-version: '18'
    test-command: 'npm test -- --coverage'
```

## 🧪 Testing Locally

### Running the API

```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm start
```

### API Endpoints

- `GET /` - Welcome message
- `GET /health` - Health check
- `GET /items` - List all items
- `POST /items` - Create new item
- `GET /items/:id` - Get specific item
- `DELETE /items/:id` - Delete item

### Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm test -- --coverage
```

### Linting

```bash
# Check for linting errors
npm run lint

# Fix linting errors
npm run lint:fix
```

## 📖 Learning Resources

### Workflow Syntax

Each workflow file includes detailed comments explaining:
- Trigger events
- Job configurations
- Step purposes
- Best practices

### Key Concepts to Master

1. **Events**: Understanding different trigger types (push, pull_request, schedule, workflow_dispatch)
2. **Jobs**: Parallel vs sequential execution, dependencies
3. **Steps**: Actions vs run commands
4. **Contexts**: Accessing workflow, job, and step information
5. **Secrets**: Secure credential management
6. **Artifacts**: Sharing data between jobs
7. **Caching**: Speeding up workflows
8. **Matrix builds**: Testing multiple configurations

### Next Steps

1. **Experiment**: Modify workflows and see what happens
2. **Add features**: Try adding new workflows for your specific needs
3. **Integrate services**: Add deployment to real cloud providers
4. **Security**: Implement security scanning and dependency updates
5. **Monitoring**: Add workflow status badges to your README

## 🛠️ Troubleshooting

### Common Issues

1. **Workflows not running**: Check branch names in workflow triggers
2. **Permission errors**: Ensure GITHUB_TOKEN has necessary permissions
3. **Failed tests**: Run tests locally first to debug
4. **Cache issues**: Clear caches in Actions settings if needed

### Debugging Tips

- Use `actions/github-script` for debugging
- Add `echo` statements to understand variable values
- Check the Actions tab in GitHub for detailed logs
- Use `continue-on-error: true` for non-critical steps

## 🤝 Contributing

This is a learning project! Feel free to:
- Add new workflow examples
- Improve documentation
- Fix bugs
- Share your learning experiences

## 📄 License

MIT License - feel free to use this project for learning!

---

Happy Learning! 🎉 If you found this helpful, give it a ⭐️