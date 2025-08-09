# 🌊 GitFlow Workflow Documentation

## 📋 Overview

This document outlines the GitFlow branching strategy for managing code releases in our Terraform infrastructure project. Our GitFlow ensures safe, controlled deployments to production while maintaining development velocity and code quality.

## 🏗️ Branch Structure

```
main (production-ready)
├── release/v1.2.0 (release preparation)
│   └── merge back to main after deployment
├── develop (integration)
│   ├── feature/JIRA-123-add-vpc-module
│   ├── feature/JIRA-456-update-security-groups
│   ├── bugfix/JIRA-789-fix-documentation
│   └── hotfix/JIRA-999-critical-security-patch
└── hotfix/JIRA-999-critical-security-patch (emergency fixes)
    └── merge to both main and develop
```

## 🔄 Branch Types & Purposes

### Main Branch (`main`)
- **Purpose**: Production-ready code
- **Protection**: Highly protected, no direct commits
- **Deployment**: Automatically deploys to production environment
- **Merges From**: Release branches and hotfix branches only
- **Stability**: Must always be deployable

### Develop Branch (`develop`)
- **Purpose**: Integration branch for ongoing development
- **Protection**: Protected, requires PR reviews
- **Deployment**: Automatically deploys to development environment
- **Merges From**: Feature branches, bugfix branches, hotfix branches
- **Stability**: Should be stable but may contain unreleased features

### Release Branches (`release/vX.Y.Z`)
- **Purpose**: Prepare and stabilize code for production release
- **Created From**: `develop` branch
- **Merged To**: `main` branch (then back to `develop`)
- **Naming**: `release/v1.2.0` (semantic versioning)
- **Deployment**: Deploys to staging environment for final testing

### Feature Branches (`feature/JIRA-XXX-description`)
- **Purpose**: Develop new features or enhancements
- **Created From**: `develop` branch
- **Merged To**: `develop` branch via Pull Request
- **Naming**: `feature/JIRA-123-add-vpc-module`
- **Deployment**: Optional deployment to development environment

### Bugfix Branches (`bugfix/JIRA-XXX-description`)
- **Purpose**: Fix non-critical bugs in development
- **Created From**: `develop` branch
- **Merged To**: `develop` branch via Pull Request
- **Naming**: `bugfix/JIRA-456-fix-documentation`
- **Deployment**: Deploys to development environment

### Hotfix Branches (`hotfix/JIRA-XXX-description`)
- **Purpose**: Emergency fixes for production issues
- **Created From**: `main` branch
- **Merged To**: Both `main` and `develop` branches
- **Naming**: `hotfix/JIRA-999-critical-security-patch`
- **Deployment**: Fast-track to production after testing

## 🚀 Production Release Process

### Phase 1: Release Planning
1. **Feature Freeze**
   - All features for the release are merged to `develop`
   - Development team confirms readiness for release
   - Release notes are prepared

2. **Create Release Branch**
   ```bash
   # Switch to develop and ensure it's up to date
   git checkout develop
   git pull origin develop
   
   # Create release branch from develop
   git checkout -b release/v1.2.0
   git push origin release/v1.2.0
   ```

### Phase 2: Release Preparation
3. **Release Branch Stabilization**
   - Deploy release branch to staging environment
   - Perform comprehensive testing
   - Fix any critical bugs found during testing
   - Update version numbers and documentation
   - No new features allowed, only bug fixes

4. **Pre-Release Validation**
   ```bash
   # On release branch - run validation
   terraform fmt -recursive
   terraform validate
   checkov -d . --framework terraform
   
   # Update version in relevant files
   # Create release notes
   ```

### Phase 3: Production Deployment
5. **Create Release Tag**
   ```bash
   # On release branch, create and push tag
   git tag -a v1.2.0 -m "Release version 1.2.0"
   git push origin v1.2.0
   ```

6. **Deploy to Production**
   - Deploy the tagged release to production environment
   - Monitor deployment and system health
   - Verify all functionality works as expected
   - Complete smoke tests and validation checks

### Phase 4: Post-Deployment
7. **Merge Release to Main**
   ```bash
   # Create PR from release branch to main
   # After successful deployment and validation
   git checkout main
   git pull origin main
   git merge --no-ff release/v1.2.0
   git push origin main
   ```

8. **Merge Release Back to Develop**
   ```bash
   # Ensure develop has latest changes from release
   git checkout develop
   git pull origin develop
   git merge --no-ff release/v1.2.0
   git push origin develop
   ```

9. **Cleanup**
   ```bash
   # Delete release branch (optional, can keep for reference)
   git branch -d release/v1.2.0
   git push origin --delete release/v1.2.0
   ```

## 🚨 Hotfix Process

### Emergency Production Fixes
1. **Create Hotfix Branch**
   ```bash
   # Create hotfix from main (production)
   git checkout main
   git pull origin main
   git checkout -b hotfix/JIRA-999-critical-security-patch
   ```

2. **Implement Fix**
   - Make minimal changes to fix the critical issue
   - Test thoroughly in development environment
   - Ensure fix doesn't break existing functionality

3. **Fast-Track Testing**
   - Deploy hotfix to staging for rapid testing
   - Perform focused testing on the specific issue
   - Get emergency approval from stakeholders

4. **Deploy Hotfix**
   ```bash
   # Create hotfix tag
   git tag -a v1.2.1 -m "Hotfix v1.2.1 - Critical security patch"
   git push origin v1.2.1
   ```

5. **Merge Hotfix**
   ```bash
   # Merge to main (production)
   git checkout main
   git merge --no-ff hotfix/JIRA-999-critical-security-patch
   git push origin main
   
   # Merge to develop
   git checkout develop
   git merge --no-ff hotfix/JIRA-999-critical-security-patch
   git push origin develop
   ```

## 🏷️ Tagging Strategy

### Semantic Versioning
We use [Semantic Versioning](https://semver.org/) for all releases:

- **MAJOR.MINOR.PATCH** (e.g., v1.2.3)
- **MAJOR**: Breaking changes or significant architecture updates
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes, backwards compatible

### Tag Types
- **Release Tags**: `v1.2.0` - Full releases from release branches
- **Hotfix Tags**: `v1.2.1` - Emergency patches from hotfix branches
- **Pre-release Tags**: `v1.2.0-rc1` - Release candidates for testing

### Tag Creation
```bash
# For releases
git tag -a v1.2.0 -m "Release v1.2.0 - Description of changes"

# For hotfixes
git tag -a v1.2.1 -m "Hotfix v1.2.1 - Critical bug fix description"

# For release candidates
git tag -a v1.2.0-rc1 -m "Release candidate v1.2.0-rc1"

# Push tags
git push origin --tags
```

## 🔒 Branch Protection Rules

### Main Branch Protection
- Require pull request reviews (minimum 2 reviewers)
- Require status checks to pass
- Require branches to be up to date before merging
- Restrict pushes that create files larger than 100MB
- Restrict force pushes
- Restrict deletions

### Develop Branch Protection
- Require pull request reviews (minimum 1 reviewer)
- Require status checks to pass
- Allow administrators to bypass protections
- Restrict force pushes

### Release Branch Protection
- Require pull request reviews for merges to main
- Require status checks to pass
- Allow release managers to push directly for bug fixes
- Restrict force pushes

## 📊 Environment Deployments

### Automatic Deployments
- **Development Environment**: Auto-deploy from `develop` branch
- **Staging Environment**: Auto-deploy from `release/*` branches
- **Production Environment**: Manual deployment from tagged releases

### Deployment Pipeline
```
develop branch → Development Environment (auto)
     ↓
release branch → Staging Environment (auto)
     ↓
tagged release → Production Environment (manual approval)
```

## 🔄 Workflow Examples

### Feature Development Workflow
```bash
# 1. Create feature branch
git checkout develop
git pull origin develop
git checkout -b feature/JIRA-123-add-monitoring

# 2. Develop and commit changes
git add .
git commit -m "feat(monitoring): add CloudWatch dashboards

- Add custom dashboards for EC2 monitoring
- Configure alerts for high CPU usage
- Update documentation

JIRA-123"

# 3. Push and create PR
git push origin feature/JIRA-123-add-monitoring
# Create PR to develop branch through GitHub UI

# 4. After review and approval, merge to develop
# Feature is now available in development environment
```

### Release Workflow
```bash
# 1. Create release branch
git checkout develop
git pull origin develop
git checkout -b release/v1.3.0

# 2. Prepare release
# Update version numbers, documentation
git commit -m "chore(release): prepare v1.3.0"
git push origin release/v1.3.0

# 3. Deploy to staging and test
# Fix any bugs found during testing

# 4. Create release tag
git tag -a v1.3.0 -m "Release v1.3.0"
git push origin v1.3.0

# 5. Deploy to production
# After successful deployment, merge to main and develop
```

## 📋 Pre-Release Checklist

### Before Creating Release Branch
- [ ] All planned features merged to develop
- [ ] Development environment is stable
- [ ] All tests are passing
- [ ] Security scans are clean
- [ ] Documentation is updated
- [ ] Release notes are prepared

### Before Production Deployment
- [ ] Staging environment testing completed
- [ ] Security review completed
- [ ] Performance testing passed
- [ ] Rollback plan documented
- [ ] Stakeholders notified
- [ ] Maintenance window scheduled (if required)

### After Production Deployment
- [ ] Smoke tests completed
- [ ] Monitoring confirmed healthy
- [ ] Release tagged and documented
- [ ] Release branch merged to main
- [ ] Release branch merged back to develop
- [ ] Team notified of successful release

## 🛠️ Tools and Automation

### GitHub Actions Integration
- **Continuous Integration**: Run on all PR branches
- **Deployment Automation**: Deploy based on branch patterns
- **Release Automation**: Create releases from tags
- **Notification Integration**: Slack/Teams notifications for releases

### Branch Automation
```yaml
# Example GitHub Actions trigger
on:
  push:
    branches:
      - develop          # Deploy to development
      - 'release/*'      # Deploy to staging
  tags:
    - 'v*'              # Deploy to production
```

## 📞 Support and Escalation

### Release Issues
- **Release Manager**: Primary contact for release coordination
- **Infrastructure Lead**: Technical decisions during releases
- **On-Call Engineer**: Production issues during deployment

### Emergency Procedures
- **SEV1 Issues**: Immediate hotfix process activation
- **SEV2 Issues**: Fast-track through release process
- **Rollback**: Predefined rollback procedures for each environment

---

## 📚 References

- [GitFlow Original Model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Semantic Versioning](https://semver.org/)
- [GitHub Flow vs GitFlow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)

---

*This GitFlow strategy ensures safe, predictable releases while maintaining development velocity. All team members should be familiar with this process.*

**Last Updated**: August 9, 2025  
**Document Owner**: Infrastructure Team  
**Review Cycle**: Quarterly
