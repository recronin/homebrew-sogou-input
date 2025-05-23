# Homebrew Tap for Sogou Input Method

[![Homebrew](https://img.shields.io/badge/Homebrew-Tap-orange)](https://brew.sh)
[![macOS](https://img.shields.io/badge/platform-macOS-blue)](https://www.apple.com/macos)
[![License](https://img.shields.io/github/license/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/releases)
[![Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen)](https://github.com/recronin/homebrew-sogou-input/blob/master/.githooks/pre-commit)
[![Last Commit](https://img.shields.io/github/last-commit/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/commits/master)

[中文版本](README_zh.md)

This is a Homebrew Tap for the Sogou Input Method (搜狗输入法) for macOS.

## About this Tap

This tap provides a Homebrew cask for Sogou Input Method, a popular Chinese input
method for macOS.

Unlike the official cask which downloads directly from Sogou's server with an
unversioned URL, this tap:

1. Uses GitHub releases to host versioned packages of Sogou Input Method
2. Provides proper version tracking and SHA256 verification
3. Maintains historical versions through GitHub releases
4. Updates automatically through GitHub Actions that check for new versions daily

## How it works

A GitHub Action workflow runs daily to:

1. Download the latest version from the official Sogou website
2. Extract version information from the package
3. Create a GitHub release with the versioned package
4. Update the cask formula to point to the GitHub release

This approach ensures that the cask formula always has proper versioning and
checksum verification.

## System Requirements

- macOS 10.14 (Mojave) or later
- Intel and Apple Silicon (M1/M2/M3) Mac supported

## Installation

```bash
# Add this tap to your Homebrew
brew tap recronin/sogou-input

# Install Sogou Input Method
brew install --cask sogou-input
```

## Verification

You can run the following commands to verify the cask:

```bash
# Get cask info
brew info --cask sogou-input

# Check if the cask is valid
brew audit --cask sogou-input

# Check cask style
brew style --cask sogou-input

# Check for updates
brew livecheck --cask sogou-input
```

## Uninstallation

If you need to uninstall Sogou Input Method or remove this tap:

```bash
# Uninstall Sogou Input Method
brew uninstall --cask sogou-input

# Remove this tap (optional)
brew untap recronin/sogou-input
```

## For Developers

### Manually Triggering Workflow Updates

If you need to manually trigger the update workflow to release the first version
or update to the latest version of Sogou Input Method, you can use the GitHub CLI
(`gh`) tool:

#### Prerequisites

You need GitHub CLI installed and authenticated:

```bash
brew install gh
```

#### Trigger the Update Workflow

```bash
# List available workflows
gh workflow list

# Trigger the update workflow (using the workflow file name)
gh workflow run update-sogou-input.yml

# If you encounter pager issues, use:
export PAGER=cat && gh workflow run update-sogou-input.yml
```

#### Monitor Workflow Progress

```bash
# List recent workflow runs
gh run list

# View details of a specific run (replace RUN_ID with the actual ID)
gh run view RUN_ID

# Watch workflow progress in real-time
gh run watch RUN_ID
```

You can also monitor the workflow execution on the GitHub Actions tab of the repository.

## Troubleshooting

### GitHub Actions Common Issues

#### Issue 1: `head: |: No such file or directory` Error

**Problem:**  
When using `gh workflow run` or `gh run list` commands, you may encounter
"head: |: No such file or directory" or "head: cat: No such file or directory"
errors.

**Solution:**  
Set the GitHub CLI pager to `cat`:

```bash
export PAGER=cat && gh workflow run update-sogou-input.yml
```

**Reason:**  
By default, GitHub CLI uses `less` as the pager, which can cause issues in
certain environments. Setting the pager to `cat` avoids this problem.

#### Issue 2: `Resource not accessible by integration` Error

**Problem:**  
GitHub Actions workflow fails with "Resource not accessible by integration"
error when trying to create releases or push changes.

**Solution:**  
Modify the repository's workflow permissions to allow write access:

```bash
gh api -X PUT repos/:owner/:repo/actions/permissions/workflow \
  -f default_workflow_permissions='write'
```

**Reason:**  
By default, GitHub Actions workflows don't have sufficient permissions to
create releases or push changes. Modifying the repository's workflow
permissions grants write access to workflows.

**Verify Permissions:**  

```bash
gh api repos/:owner/:repo/actions/permissions/workflow --jq '.'
```

The output should include `"default_workflow_permissions": "write"`.

## License

This project is licensed under the terms of the LICENSE file included in this
repository.

## Disclaimer

Sogou Input Method is a product of Sogou Inc. This tap is not officially
affiliated with Sogou Inc.
