#!/bin/bash

# Workflow Validation Script
echo "🔍 GitHub Actions Workflow Validator"
echo "===================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

validate_yaml() {
    local file=$1
    echo -n "📄 Validating YAML syntax for $(basename "$file")... "
    
    if command -v yq &> /dev/null; then
        if yq eval '.' "$file" > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Valid${NC}"
            return 0
        else
            echo -e "${RED}❌ Invalid YAML${NC}"
            return 1
        fi
    elif python3 -c "import yaml" 2>/dev/null; then
        if python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null; then
            echo -e "${GREEN}✅ Valid${NC}"
            return 0
        else
            echo -e "${RED}❌ Invalid YAML${NC}"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠️ No YAML validator found${NC}"
        return 0
    fi
}

check_workflow_structure() {
    local file=$1
    local filename=$(basename "$file")
    echo ""
    echo -e "${BLUE}🔍 Analyzing $filename...${NC}"
    
    # Check for required fields
    local has_name=$(grep -c "^name:" "$file")
    local has_on=$(grep -c "^on:" "$file")
    local has_jobs=$(grep -c "^jobs:" "$file")
    
    if [ "$has_name" -eq 0 ]; then
        echo -e "  ${RED}❌ Missing 'name' field${NC}"
    else
        echo -e "  ${GREEN}✅ Has name field${NC}"
    fi
    
    if [ "$has_on" -eq 0 ]; then
        echo -e "  ${RED}❌ Missing 'on' trigger field${NC}"
    else
        echo -e "  ${GREEN}✅ Has trigger configuration${NC}"
    fi
    
    if [ "$has_jobs" -eq 0 ]; then
        echo -e "  ${RED}❌ Missing 'jobs' field${NC}"
    else
        echo -e "  ${GREEN}✅ Has jobs configuration${NC}"
    fi
    
    # Check for common best practices
    local has_checkout=$(grep -c "actions/checkout" "$file")
    local has_setup_node=$(grep -c "actions/setup-node" "$file")
    local has_permissions=$(grep -c "permissions:" "$file")
    
    echo ""
    echo -e "${BLUE}📋 Best Practices Check:${NC}"
    
    if [ "$has_checkout" -gt 0 ]; then
        echo -e "  ${GREEN}✅ Uses actions/checkout${NC}"
    else
        echo -e "  ${YELLOW}⚠️ No checkout action found${NC}"
    fi
    
    if [[ "$filename" == *"node"* ]] || grep -q "npm" "$file"; then
        if [ "$has_setup_node" -gt 0 ]; then
            echo -e "  ${GREEN}✅ Uses actions/setup-node${NC}"
        else
            echo -e "  ${YELLOW}⚠️ Node.js workflow should use actions/setup-node${NC}"
        fi
    fi
    
    # Check for pinned action versions
    local unpinned_actions=$(grep -E "uses: [^@]*@(main|master|latest)" "$file" | wc -l)
    if [ "$unpinned_actions" -gt 0 ]; then
        echo -e "  ${YELLOW}⚠️ Found $unpinned_actions unpinned action versions${NC}"
        echo -e "    ${YELLOW}Consider pinning to specific versions for reproducibility${NC}"
    else
        echo -e "  ${GREEN}✅ All actions are properly versioned${NC}"
    fi
    
    # Check for security considerations
    if grep -q "secrets\." "$file"; then
        if [ "$has_permissions" -gt 0 ]; then
            echo -e "  ${GREEN}✅ Uses explicit permissions${NC}"
        else
            echo -e "  ${YELLOW}⚠️ Uses secrets but no explicit permissions${NC}"
        fi
    fi
}

check_triggers() {
    local file=$1
    echo ""
    echo -e "${BLUE}🔄 Trigger Analysis:${NC}"
    
    # Extract trigger events
    if grep -q "push:" "$file"; then
        echo -e "  ${GREEN}📤 Push events${NC}"
        local branches=$(sed -n '/push:/,/pull_request:\|schedule:\|workflow_dispatch:\|^[a-z]/p' "$file" | grep -A10 "branches:" | grep -E "^\s*-" | head -5)
        if [ ! -z "$branches" ]; then
            echo -e "    Branches: $(echo "$branches" | tr '\n' ' ' | sed 's/- //g')"
        fi
    fi
    
    if grep -q "pull_request:" "$file"; then
        echo -e "  ${GREEN}📥 Pull request events${NC}"
    fi
    
    if grep -q "schedule:" "$file"; then
        echo -e "  ${GREEN}⏰ Scheduled events${NC}"
        local cron=$(grep -A1 "schedule:" "$file" | grep "cron:" | sed "s/.*cron: '//; s/'.*//" | head -1)
        if [ ! -z "$cron" ]; then
            echo -e "    Schedule: $cron"
        fi
    fi
    
    if grep -q "workflow_dispatch:" "$file"; then
        echo -e "  ${GREEN}🔧 Manual dispatch${NC}"
    fi
}

generate_report() {
    echo ""
    echo "📊 Validation Summary"
    echo "===================="
    echo ""
    echo "Total workflows: $total_workflows"
    echo "Valid YAML: $valid_yaml"
    echo "Invalid YAML: $invalid_yaml"
    echo ""
    
    if [ "$invalid_yaml" -eq 0 ]; then
        echo -e "${GREEN}🎉 All workflows have valid YAML syntax!${NC}"
    else
        echo -e "${RED}⚠️ $invalid_yaml workflow(s) have YAML syntax errors${NC}"
    fi
    
    echo ""
    echo "💡 Recommendations:"
    echo "  - Pin action versions to specific releases"
    echo "  - Use explicit permissions for security"
    echo "  - Add caching where appropriate"
    echo "  - Include timeout settings for long-running jobs"
    echo ""
}

# Main validation
total_workflows=0
valid_yaml=0
invalid_yaml=0

echo "🔍 Scanning .github/workflows/ directory..."
echo ""

if [ ! -d ".github/workflows" ]; then
    echo -e "${RED}❌ No .github/workflows directory found${NC}"
    exit 1
fi

for workflow in .github/workflows/*.yml .github/workflows/*.yaml; do
    if [ -f "$workflow" ]; then
        ((total_workflows++))
        
        if validate_yaml "$workflow"; then
            ((valid_yaml++))
            check_workflow_structure "$workflow"
            check_triggers "$workflow"
            echo ""
            echo "────────────────────────────────────────────────────────────────"
        else
            ((invalid_yaml++))
        fi
    fi
done

generate_report

# Suggest tools for advanced validation
echo "🛠️ Advanced Validation Tools:"
echo "  - actionlint: https://github.com/rhysd/actionlint"
echo "  - act: Test workflows locally"
echo "  - GitHub CLI: gh workflow list"
echo ""

# Check if actionlint is available
if command -v actionlint &> /dev/null; then
    echo "🚀 Running actionlint for advanced checks..."
    actionlint .github/workflows/*.yml
else
    echo "💡 Install actionlint for more detailed validation:"
    echo "   brew install actionlint"
fi