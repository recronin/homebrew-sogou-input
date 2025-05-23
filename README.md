# Homebrew Tap for Sogou Input Method

[![Homebrew](https://img.shields.io/badge/Homebrew-Tap-orange)](https://brew.sh)
[![macOS](https://img.shields.io/badge/platform-macOS-blue)](https://www.apple.com/macos)
[![License](https://img.shields.io/github/license/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/releases)
[![Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen)](https://github.com/recronin/homebrew-sogou-input/blob/master/.githooks/pre-commit)
[![Last Commit](https://img.shields.io/github/last-commit/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/commits/master)

[中文版本](README_zh.md)

This is a Homebrew Tap for the Sogou Input Method (搜狗输入法) for macOS.

## Installation

```bash
# Add this tap to your Homebrew
brew tap recronin/sogou-input

# Install Sogou Input Method
brew install --cask sogou-input
```

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

## License

This project is licensed under the terms of the LICENSE file included in this
repository.

## Disclaimer

Sogou Input Method is a product of Sogou Inc. This tap is not officially
affiliated with Sogou Inc.
