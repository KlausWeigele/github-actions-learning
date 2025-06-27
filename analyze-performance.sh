#!/bin/bash

# GitHub Actions Performance Analyzer
echo "⚡ GitHub Actions Performance Analyzer"
echo "====================================="
echo ""

analyze_workflow_performance() {
    local file=$1
    local filename=$(basename "$file")
    echo "📊 Analyzing $filename"
    echo "─────────────────────────────────────────"
    
    # Count jobs
    local job_count=$(grep -c "^  [a-zA-Z-]*:" "$file")
    echo "Jobs: $job_count"
    
    # Check for parallelization opportunities
    local needs_count=$(grep -c "needs:" "$file")
    if [ "$needs_count" -eq 0 ] && [ "$job_count" -gt 1 ]; then
        echo "💡 Optimization: Jobs can run in parallel (no dependencies)"
    elif [ "$needs_count" -gt 0 ]; then
        echo "🔗 Sequential: $needs_count job dependencies found"
    fi
    
    # Check for caching
    local cache_count=$(grep -c "cache:" "$file")
    local cache_action_count=$(grep -c "actions/cache" "$file")
    local total_cache=$((cache_count + cache_action_count))
    
    if [ "$total_cache" -gt 0 ]; then
        echo "⚡ Caching: $total_cache cache configurations found"
    else
        echo "🐌 Performance: No caching detected - consider adding"
    fi
    
    # Check for matrix builds
    if grep -q "strategy:" "$file"; then
        echo "🔀 Matrix: Strategy found - parallel execution"
    fi
    
    # Check runner types
    local runner_types=$(grep "runs-on:" "$file" | sort | uniq -c)
    echo "🖥️  Runners:"
    echo "$runner_types" | sed 's/^/    /'
    
    # Estimate runtime factors
    echo ""
    echo "⏱️  Runtime Factors:"
    
    # Node.js setup time
    if grep -q "actions/setup-node" "$file"; then
        echo "  • Node.js setup: ~30 seconds"
    fi
    
    # Dependency installation
    if grep -q "npm ci\|npm install" "$file"; then
        if [ "$total_cache" -gt 0 ]; then
            echo "  • Dependencies (cached): ~30 seconds"
        else
            echo "  • Dependencies (no cache): ~2-5 minutes"
        fi
    fi
    
    # Testing
    if grep -q "npm test\|jest\|test" "$file"; then
        echo "  • Tests: Depends on test suite size"
    fi
    
    # Building
    if grep -q "npm run build\|build" "$file"; then
        echo "  • Build: ~1-3 minutes"
    fi
    
    echo ""
}

suggest_optimizations() {
    echo "🚀 Performance Optimization Suggestions"
    echo "======================================"
    echo ""
    
    echo "1. 💾 Enable Caching:"
    echo "   - Use 'cache: npm' in setup-node"
    echo "   - Cache node_modules and build outputs"
    echo "   - Cache test coverage reports"
    echo ""
    
    echo "2. ⚡ Parallel Execution:"
    echo "   - Run independent jobs in parallel"
    echo "   - Use matrix builds for multi-environment testing"
    echo "   - Split large test suites across multiple jobs"
    echo ""
    
    echo "3. 🔧 Runner Optimization:"
    echo "   - Use larger runners for CPU-intensive tasks"
    echo "   - Keep runners close to your user base"
    echo "   - Consider self-hosted runners for consistency"
    echo ""
    
    echo "4. 📦 Dependencies:"
    echo "   - Use 'npm ci' instead of 'npm install'"
    echo "   - Consider npm workspaces for monorepos"
    echo "   - Audit and remove unused dependencies"
    echo ""
    
    echo "5. 🎯 Conditional Execution:"
    echo "   - Skip unnecessary jobs with 'if' conditions"
    echo "   - Use path filters to run only relevant workflows"
    echo "   - Implement early exit strategies"
    echo ""
}

benchmark_example() {
    echo "📈 Example Performance Improvements"
    echo "=================================="
    echo ""
    
    echo "Before optimization:"
    echo "┌─────────────────────┬──────────┐"
    echo "│ Step                │ Duration │"
    echo "├─────────────────────┼──────────┤"
    echo "│ Checkout            │ 10s      │"
    echo "│ Setup Node          │ 30s      │"
    echo "│ Install deps (cold) │ 3m       │"
    echo "│ Run tests           │ 2m       │"
    echo "│ Build               │ 1m       │"
    echo "├─────────────────────┼──────────┤"
    echo "│ Total               │ 6m 40s   │"
    echo "└─────────────────────┴──────────┘"
    echo ""
    
    echo "After optimization:"
    echo "┌─────────────────────┬──────────┐"
    echo "│ Step                │ Duration │"
    echo "├─────────────────────┼──────────┤"
    echo "│ Checkout            │ 10s      │"
    echo "│ Setup Node (cached) │ 15s      │"
    echo "│ Install deps (cache)│ 30s      │"
    echo "│ Run tests (parallel)│ 1m       │"
    echo "│ Build (cached)      │ 30s      │"
    echo "├─────────────────────┼──────────┤"
    echo "│ Total               │ 2m 25s   │"
    echo "└─────────────────────┴──────────┘"
    echo ""
    echo "💡 60% improvement with caching and parallelization!"
}

generate_performance_report() {
    echo "📋 Performance Report Summary"
    echo "============================="
    echo ""
    
    local total_workflows=$(ls .github/workflows/*.yml | wc -l)
    local cached_workflows=$(grep -l "cache:" .github/workflows/*.yml | wc -l)
    local matrix_workflows=$(grep -l "strategy:" .github/workflows/*.yml | wc -l)
    local parallel_workflows=$(grep -L "needs:" .github/workflows/*.yml | wc -l)
    
    echo "📊 Statistics:"
    echo "  Total workflows: $total_workflows"
    echo "  With caching: $cached_workflows"
    echo "  With matrix builds: $matrix_workflows"
    echo "  Parallel-capable: $parallel_workflows"
    echo ""
    
    local cache_percentage=$((cached_workflows * 100 / total_workflows))
    local matrix_percentage=$((matrix_workflows * 100 / total_workflows))
    
    echo "🎯 Performance Score:"
    echo "  Caching adoption: $cache_percentage%"
    echo "  Matrix usage: $matrix_percentage%"
    
    if [ "$cache_percentage" -lt 50 ]; then
        echo "  🔴 Low caching - significant improvement possible"
    elif [ "$cache_percentage" -lt 80 ]; then
        echo "  🟡 Moderate caching - room for improvement"
    else
        echo "  🟢 Good caching implementation"
    fi
    
    echo ""
    echo "💰 Cost Implications:"
    echo "  - Each minute saved = ~\$0.008 on GitHub Actions"
    echo "  - Caching can reduce costs by 40-60%"
    echo "  - Matrix builds distribute load efficiently"
}

# Main analysis
echo "🔍 Scanning workflows for performance characteristics..."
echo ""

for workflow in .github/workflows/*.yml; do
    if [ -f "$workflow" ]; then
        analyze_workflow_performance "$workflow"
        echo ""
    fi
done

suggest_optimizations
benchmark_example
generate_performance_report

echo ""
echo "🔧 Tools for Performance Monitoring:"
echo "  - GitHub Actions usage page (repository settings)"
echo "  - Workflow run timing in Actions tab"
echo "  - GitHub CLI: gh run list --limit 10"
echo "  - Actions timeline view for bottleneck identification"