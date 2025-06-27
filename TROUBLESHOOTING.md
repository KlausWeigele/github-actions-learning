# Troubleshooting GitHub Actions

Common issues and solutions for your GitHub Actions workflows.

## Workflow Not Running

### Problem: Workflow doesn't trigger on push
**Solutions:**
- Check branch names in workflow triggers match your actual branch
- Ensure the workflow file is in `.github/workflows/`
- Verify YAML syntax (use a YAML validator)
- Check if Actions are enabled in repository settings

### Problem: "Workflow not found"
**Solutions:**
- Workflow file must be on the default branch first
- Check file extension is `.yml` or `.yaml`
- Ensure no syntax errors in YAML

## Permission Errors

### Problem: "Resource not accessible by integration"
**Solutions:**
```yaml
permissions:
  contents: read
  pull-requests: write
  issues: write
```

### Problem: Cannot push to protected branch
**Solutions:**
- Use a Personal Access Token (PAT) instead of GITHUB_TOKEN
- Configure branch protection rules to allow Actions

## Node.js Issues

### Problem: "Cannot find module"
**Solutions:**
- Ensure `npm ci` runs before any Node.js commands
- Check `package.json` is in the repository
- Verify Node.js version compatibility

### Problem: Tests fail in CI but pass locally
**Solutions:**
- Check for environment-specific issues
- Ensure all test files are committed
- Look for timing/async issues
- Verify database/service connections

## Caching Problems

### Problem: Cache not working
**Solutions:**
```yaml
- uses: actions/setup-node@v3
  with:
    node-version: '18'
    cache: 'npm'
    cache-dependency-path: package-lock.json
```

### Problem: Old cache being used
**Solutions:**
- Change cache key to bust cache
- Clear cache in Actions settings

## Secret Issues

### Problem: Secret not available
**Solutions:**
- Secrets are case-sensitive
- Check secret is set in correct environment
- Repository secrets vs Environment secrets
- Verify secret name matches exactly

## Matrix Build Issues

### Problem: Matrix job failing for specific combination
**Solutions:**
```yaml
strategy:
  fail-fast: false  # Don't cancel all jobs if one fails
  matrix:
    # ... your matrix
```

### Problem: Too many matrix combinations
**Solutions:**
- Use `exclude` to skip combinations
- Limit matrix dimensions
- Consider conditional matrices

## Artifact Issues

### Problem: Cannot download artifacts
**Solutions:**
- Check artifact name matches exactly
- Verify retention period hasn't expired
- Ensure upload completed successfully

### Problem: Artifacts too large
**Solutions:**
- Compress before uploading
- Exclude unnecessary files
- Use `.artifactignore`

## Debugging Workflows

### Enable debug logging:
1. Set secret `ACTIONS_RUNNER_DEBUG` to `true`
2. Set secret `ACTIONS_STEP_DEBUG` to `true`

### Add debug steps:
```yaml
- name: Debug Info
  run: |
    echo "Event: ${{ github.event_name }}"
    echo "Branch: ${{ github.ref }}"
    echo "Commit: ${{ github.sha }}"
    echo "Runner: ${{ runner.os }}"
```

### Check context:
```yaml
- name: Dump contexts
  env:
    GITHUB_CONTEXT: ${{ toJson(github) }}
    ENV_CONTEXT: ${{ toJson(env) }}
    VARS_CONTEXT: ${{ toJson(vars) }}
  run: |
    echo "$GITHUB_CONTEXT"
    echo "$ENV_CONTEXT" 
    echo "$VARS_CONTEXT"
```

## Performance Issues

### Problem: Workflows running slowly
**Solutions:**
- Implement caching for dependencies
- Run jobs in parallel when possible
- Use faster runners (larger runners for paid accounts)
- Optimize test suite

### Problem: Hitting rate limits
**Solutions:**
- Use GITHUB_TOKEN when possible (higher limits)
- Implement retries with exponential backoff
- Cache API responses
- Reduce API calls

## Common Error Messages

### "No jobs were run"
- Check job conditions (`if:` statements)
- Verify trigger conditions match

### "The process '/usr/bin/git' failed with exit code 128"
- Usually authentication issues
- Check token permissions
- Verify repository access

### "Unrecognized named-value: 'secrets'"
- Secrets not available in all contexts
- Pass secrets explicitly to reusable workflows

## Getting Help

1. **Check the logs**: Click on failed job for detailed logs
2. **GitHub Status**: Check https://githubstatus.com
3. **Actions Documentation**: https://docs.github.com/actions
4. **Community Forum**: https://github.community/c/actions
5. **Stack Overflow**: Tag with `github-actions`

## Best Practices to Avoid Issues

1. **Test locally first**: Run lints and tests before pushing
2. **Use act**: Test workflows locally with https://github.com/nektos/act
3. **Version your actions**: Use specific versions, not @master
4. **Monitor usage**: Check Actions billing/usage regularly
5. **Keep workflows simple**: Complex workflows are harder to debug