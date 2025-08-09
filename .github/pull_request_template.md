# Infrastructure Change Request

## 📋 Change Summary
<!-- Provide a brief description of what this PR changes -->

## 🎯 Change Type
<!-- Check all that apply -->
- [ ] 🆕 New infrastructure/resources
- [ ] 🔄 Resource modification
- [ ] 🗑️ Resource deletion
- [ ] 🔧 Configuration update
- [ ] 📝 Documentation update
- [ ] 🐛 Bug fix
- [ ] 🔒 Security improvement
- [ ] 💰 Cost optimization

## 🌍 Environment Impact
<!-- Check all environments this change affects -->
- [ ] Development
- [ ] Staging
- [ ] Production
- [ ] All environments

## 📊 Terraform Plan Output
<!-- 
Paste the output of `terraform plan` for the affected environment(s)
Use code blocks with proper formatting
-->

### Development
```
# Paste terraform plan output for dev environment
```

### Staging
```
# Paste terraform plan output for staging environment
```

### Production
```
# Paste terraform plan output for production environment
```

## 💰 Cost Impact
<!-- Describe any cost implications -->
- [ ] No cost impact
- [ ] Cost increase (estimated: $X/month)
- [ ] Cost decrease (estimated: $X/month)
- [ ] Cost neutral (resource replacement)

**Cost Analysis:**
<!-- Provide details about cost changes if applicable -->

## 🔒 Security Considerations
<!-- Check all that apply -->
- [ ] No security impact
- [ ] Creates new security groups/rules
- [ ] Modifies existing security groups/rules
- [ ] Changes IAM policies/roles
- [ ] Affects data encryption
- [ ] Affects network access
- [ ] Creates/modifies secrets

**Security Details:**
<!-- Provide details about security changes if applicable -->

## 🧪 Testing Checklist
<!-- Check all completed items -->
- [ ] `terraform fmt` applied
- [ ] `terraform validate` passed
- [ ] `terraform plan` reviewed
- [ ] No sensitive data in code
- [ ] Documentation updated
- [ ] Tested in development environment
- [ ] Tested in staging environment
- [ ] Rollback plan documented

## 🔄 Deployment Plan
<!-- Describe how this change will be deployed -->

**Deployment Order:**
1. [ ] Development
2. [ ] Staging
3. [ ] Production

**Rollback Plan:**
<!-- Describe how to rollback if issues occur -->

## 📝 Additional Notes
<!-- Any additional context, dependencies, or considerations -->

## 🔗 Related Issues/PRs
<!-- Link any related issues or PRs -->
- Closes #XXX
- Related to #XXX

## 📸 Screenshots/Diagrams
<!-- If applicable, add screenshots or architecture diagrams -->

---

## ✅ Pre-merge Checklist
<!-- Reviewer checklist -->
- [ ] Code follows Terraform best practices
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Security review completed (if applicable)
- [ ] Cost impact approved (if applicable)
- [ ] Deployment plan approved
- [ ] All environments tested
- [ ] Breaking changes communicated to team

## 🚀 Post-merge Actions
<!-- Actions to take after merge -->
- [ ] Deploy to development
- [ ] Deploy to staging
- [ ] Deploy to production
- [ ] Update monitoring/alerts (if needed)
- [ ] Update runbooks (if needed)
- [ ] Notify stakeholders (if needed)
