# GitHub Actions Learning Project - Complete Guide 🎓

## 🏁 Quick Start Checklist

- [ ] Run `npm install` to install dependencies
- [ ] Run `npm test` to verify everything works
- [ ] Run `./setup-github.sh` for GitHub setup instructions
- [ ] Create a GitHub repository
- [ ] Push code to GitHub
- [ ] Watch workflows run in the Actions tab
- [ ] Create a pull request to see PR workflows

## 📚 Learning Path

### Week 1: Basics
1. **Read**: `README.md` - Understand the project structure
2. **Explore**: `.github/workflows/ci.yml` - Your first workflow
3. **Try**: Push a commit and watch the CI run
4. **Experiment**: Break a test and see what happens

### Week 2: Intermediate
1. **Study**: `.github/workflows/matrix.yml` - Parallel testing
2. **Try**: `.github/workflows/manual.yml` - Trigger manually
3. **Learn**: `.github/workflows/reusable.yml` - DRY principles
4. **Practice**: Create a PR and observe PR-specific workflows

### Week 3: Advanced
1. **Master**: Custom actions in `.github/actions/`
2. **Schedule**: Understand cron in `.github/workflows/scheduled.yml`
3. **Deploy**: Study `.github/workflows/deploy.yml` patterns
4. **Optimize**: Add caching and performance improvements

## 📖 Documentation Map

| Document | Purpose | When to Read |
|----------|---------|--------------|
| `README.md` | Project overview and workflow explanations | First - understand the project |
| `ACTIONS_CHEATSHEET.md` | Quick reference for syntax | Keep open while writing workflows |
| `TROUBLESHOOTING.md` | Common issues and solutions | When something goes wrong |
| `NEXT_STEPS.md` | Learning exercises and experiments | After basics are working |
| `.github/environments.md` | Setting up deployment environments | Before using deploy workflow |
| `badges.md` | Adding status badges | To enhance your README |

## 🛠️ Available Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `./setup-github.sh` | GitHub setup instructions | Run once at start |
| `./test-api.sh` | Test API endpoints locally | Verify API works |
| `npm start` | Run production server | Port 3000 |
| `npm run dev` | Run development server | Auto-reload enabled |
| `npm test` | Run all tests | With coverage |
| `npm run lint` | Check code style | ESLint |

## 🔍 Key Files to Study

### Workflows (`.github/workflows/`)
1. **ci.yml** - Basic CI/CD pipeline
2. **deploy.yml** - Multi-environment deployment
3. **matrix.yml** - Cross-platform testing
4. **manual.yml** - Manual triggers with inputs
5. **scheduled.yml** - Cron-based automation
6. **reusable.yml** - Workflow composition
7. **pr-checks.yml** - Pull request automation

### Application Code
- `src/app.js` - Express API implementation
- `tests/app.test.js` - Jest test examples
- `package.json` - Scripts and dependencies

### Custom Action
- `.github/actions/setup-and-test/action.yml` - Reusable action definition

## 💡 Learning Tips

### Do's ✅
- Start simple, build complexity gradually
- Read workflow logs carefully
- Experiment in a separate branch
- Use the GitHub Actions tab extensively
- Check the "Summary" section for insights

### Don'ts ❌
- Don't commit secrets to the repository
- Don't skip reading error messages
- Don't use `@master` - pin action versions
- Don't ignore failing workflows
- Don't make workflows too complex initially

## 🚀 Progressive Challenges

### Beginner
1. Make the CI workflow fail, then fix it
2. Add a new API endpoint and tests
3. Trigger the manual workflow with different inputs

### Intermediate
1. Add a new job to the CI workflow
2. Create a new matrix combination
3. Use workflow outputs in another job

### Advanced
1. Create your own reusable workflow
2. Build a custom JavaScript action
3. Implement a complete CD pipeline

## 🔗 Useful Links

### Official Documentation
- [GitHub Actions Docs](https://docs.github.com/actions)
- [Workflow Syntax](https://docs.github.com/actions/reference/workflow-syntax-for-github-actions)
- [Contexts](https://docs.github.com/actions/reference/context-and-expression-syntax-for-github-actions)
- [Events](https://docs.github.com/actions/reference/events-that-trigger-workflows)

### Community Resources
- [Awesome Actions](https://github.com/sdras/awesome-actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [act - Run workflows locally](https://github.com/nektos/act)

## 🎯 Success Metrics

You'll know you've mastered GitHub Actions when you can:
- [ ] Write a workflow from scratch without reference
- [ ] Debug failing workflows efficiently
- [ ] Create reusable workflows and actions
- [ ] Implement complex CI/CD pipelines
- [ ] Optimize workflow performance
- [ ] Handle secrets and environments securely

## 🤝 Getting Help

1. **Logs**: Always check workflow logs first
2. **Docs**: Reference the cheatsheet and troubleshooting guide
3. **Community**: GitHub Community Forum
4. **Issues**: Create issues in your repo to track problems

Remember: The best way to learn is by doing. Break things, fix them, and understand why they work! 🔧

Happy Learning! 🎉