# GitHub Actions Cheatsheet 📋

## Workflow Triggers

```yaml
# Push events
on:
  push:
    branches: [ main, develop ]
    tags: [ 'v*' ]
    paths:
      - 'src/**'
      - '!src/docs/**'

# Pull request events  
on:
  pull_request:
    types: [ opened, synchronize, reopened, closed ]

# Schedule (cron)
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight

# Manual trigger
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Deployment environment'
        required: true
        type: choice
        options: [ dev, staging, prod ]

# Multiple triggers
on: [push, pull_request, workflow_dispatch]
```

## Contexts

```yaml
# Commonly used contexts
${{ github.repository }}      # owner/repo
${{ github.event_name }}      # push, pull_request, etc.
${{ github.sha }}             # Commit SHA
${{ github.ref }}             # refs/heads/branch-name
${{ github.ref_name }}        # branch-name
${{ github.actor }}           # User who triggered
${{ github.workspace }}       # Checkout directory
${{ github.event.head_commit.message }}  # Commit message

# Job contexts
${{ job.status }}             # success, failure, cancelled
${{ job.container.id }}       # Container ID

# Runner contexts  
${{ runner.os }}              # Linux, Windows, macOS
${{ runner.temp }}            # Temp directory
${{ runner.tool_cache }}      # Tool cache directory

# Secret and variable contexts
${{ secrets.MY_SECRET }}      # Secret value
${{ vars.MY_VARIABLE }}       # Variable value
${{ env.MY_ENV }}            # Environment variable
```

## Conditional Execution

```yaml
# Basic conditions
if: github.event_name == 'push'
if: github.ref == 'refs/heads/main'
if: contains(github.event.head_commit.message, '[skip ci]') == false

# Status checks
if: success()    # Default, previous steps succeeded
if: always()     # Run regardless of previous steps
if: failure()    # Run only if previous steps failed
if: cancelled()  # Run only if workflow was cancelled

# Complex conditions
if: |
  github.event_name == 'push' &&
  github.ref == 'refs/heads/main' &&
  contains(github.event.head_commit.message, 'deploy')
```

## Job Dependencies

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.version.outputs.version }}
    steps:
      - id: version
        run: echo "version=1.0.0" >> $GITHUB_OUTPUT

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Testing version ${{ needs.build.outputs.version }}"

  deploy:
    needs: [build, test]
    if: success()  # Only if all dependencies succeeded
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

## Matrix Strategy

```yaml
strategy:
  fail-fast: false
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    node: [14, 16, 18]
    include:
      - os: ubuntu-latest
        node: 18
        coverage: true
    exclude:
      - os: windows-latest
        node: 14
```

## Environment Variables

```yaml
env:
  GLOBAL_VAR: 'available to all jobs'

jobs:
  test:
    env:
      JOB_VAR: 'available to all steps in job'
    steps:
      - name: Step with env
        env:
          STEP_VAR: 'available to this step only'
        run: |
          echo "$GLOBAL_VAR"
          echo "$JOB_VAR"
          echo "$STEP_VAR"
```

## Outputs

```yaml
# Step outputs
- name: Set output
  id: vars
  run: |
    echo "sha_short=$(git rev-parse --short HEAD)" >> $GITHUB_OUTPUT
    echo "date=$(date +'%Y%m%d')" >> $GITHUB_OUTPUT

- name: Use output
  run: echo "Short SHA is ${{ steps.vars.outputs.sha_short }}"

# Job outputs
jobs:
  job1:
    outputs:
      result: ${{ steps.calc.outputs.result }}
    steps:
      - id: calc
        run: echo "result=42" >> $GITHUB_OUTPUT
  
  job2:
    needs: job1
    steps:
      - run: echo "Result from job1: ${{ needs.job1.outputs.result }}"
```

## Caching

```yaml
# NPM cache
- uses: actions/setup-node@v3
  with:
    node-version: '18'
    cache: 'npm'

# Custom cache
- uses: actions/cache@v3
  with:
    path: |
      ~/.npm
      ~/.cache
    key: ${{ runner.os }}-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-
```

## Artifacts

```yaml
# Upload artifacts
- uses: actions/upload-artifact@v3
  with:
    name: my-artifact
    path: |
      dist/
      !dist/**/*.map
    retention-days: 30

# Download artifacts
- uses: actions/download-artifact@v3
  with:
    name: my-artifact
    path: ./downloaded-artifacts
```

## Permissions

```yaml
# Repository permissions
permissions:
  contents: read        # Read repository
  contents: write       # Write to repository
  issues: write         # Create/update issues
  pull-requests: write  # Create/update PRs
  actions: read         # Read actions
  checks: write         # Create/update checks
  deployments: write    # Create deployments
  packages: write       # Publish packages
  pages: write          # Deploy to Pages
  security-events: write # Upload security events

# Minimal permissions
permissions: {}  # No permissions

# Job-level permissions
jobs:
  deploy:
    permissions:
      contents: read
      deployments: write
```

## Common Actions

```yaml
# Checkout
- uses: actions/checkout@v3
  with:
    fetch-depth: 0  # Full history
    submodules: recursive
    token: ${{ secrets.PAT }}  # If needed for private submodules

# Setup languages
- uses: actions/setup-node@v3
- uses: actions/setup-python@v4
- uses: actions/setup-java@v3
- uses: actions/setup-go@v4

# GitHub Script
- uses: actions/github-script@v6
  with:
    script: |
      github.rest.issues.createComment({
        issue_number: context.issue.number,
        owner: context.repo.owner,
        repo: context.repo.repo,
        body: 'Hello from Actions!'
      })
```

## Useful Snippets

```yaml
# Skip CI
if: "!contains(github.event.head_commit.message, '[skip ci]')"

# Only on PR from fork
if: github.event.pull_request.head.repo.fork == true

# Create GitHub deployment
- uses: chrnorm/deployment-action@v2
  with:
    token: ${{ secrets.GITHUB_TOKEN }}
    environment: production

# Wait for other checks
- uses: lewagon/wait-on-check-action@v1.3.1
  with:
    ref: ${{ github.ref }}
    check-name: 'build'
    repo-token: ${{ secrets.GITHUB_TOKEN }}
    wait-interval: 10

# Retry on failure
- uses: nick-fields/retry@v2
  with:
    timeout_minutes: 10
    max_attempts: 3
    command: npm test
```

## Security Best Practices

```yaml
# Never echo secrets
- run: echo "Secret is ${{ secrets.MY_SECRET }}"  # ❌ Bad

# Mask values
- run: echo "::add-mask::$VALUE"

# Use environments for deployment protection
deploy:
  environment: production
  steps:
    - run: deploy.sh

# Limit token permissions
- uses: actions/checkout@v3
  with:
    persist-credentials: false
```