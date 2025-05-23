# 搜狗输入法的 Homebrew Tap

[![Homebrew](https://img.shields.io/badge/Homebrew-Tap-orange)](https://brew.sh)
[![macOS](https://img.shields.io/badge/platform-macOS-blue)](https://www.apple.com/macos)
[![License](https://img.shields.io/github/license/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/releases)
[![Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen)](https://github.com/recronin/homebrew-sogou-input/blob/master/.githooks/pre-commit)
[![Last Commit](https://img.shields.io/github/last-commit/recronin/homebrew-sogou-input)](https://github.com/recronin/homebrew-sogou-input/commits/master)

这是为 macOS 版搜狗输入法提供的 Homebrew Tap。

## 关于此 Tap

此 tap 为 macOS 上流行的中文输入法——搜狗输入法提供了 Homebrew cask。

与直接从搜狗服务器下载且没有版本控制的官方 cask 不同，此 tap：

1. 使用 GitHub releases 托管有版本控制的搜狗输入法安装包
2. 提供正确的版本跟踪和 SHA256 验证
3. 通过 GitHub releases 维护历史版本
4. 通过每日检查新版本的 GitHub Actions 自动更新

## 工作原理

GitHub Action 工作流每天运行以：

1. 从搜狗官方网站下载最新版本
2. 从安装包中提取版本信息
3. 使用版本化的安装包创建 GitHub release
4. 更新 cask formula 以指向 GitHub release

这种方法确保 cask formula 始终具有正确的版本控制和校验和验证。

## 系统要求

- macOS 10.14 (Mojave) 或更高版本
- 支持 Intel 和 Apple Silicon (M1/M2/M3) Mac

## 安装方法

```bash
# 添加此 tap 到你的 Homebrew
brew tap recronin/sogou-input

# 安装搜狗输入法
brew install --cask sogou-input
```

## 验证

你可以运行以下命令来验证 cask：

```bash
# 获取 cask 信息
brew info --cask sogou-input

# 检查 cask 是否有效
brew audit --cask sogou-input

# 检查 cask 样式
brew style --cask sogou-input

# 检查更新
brew livecheck --cask sogou-input
```

## 卸载

如果你需要卸载搜狗输入法或移除此 tap：

```bash
# 卸载搜狗输入法
brew uninstall --cask sogou-input

# 移除此 tap（可选）
brew untap recronin/sogou-input
```

## 开发者相关

### 手动触发工作流更新

如果你需要手动触发更新工作流来发布首个版本或更新到最新版本的搜狗输入法，
你可以使用 GitHub CLI (`gh`) 工具：

#### 前提条件

你需要安装并认证 GitHub CLI：

```bash
brew install gh
```

#### 触发更新工作流

```bash
# 列出可用的工作流
gh workflow list

# 触发更新工作流（使用工作流文件名）
gh workflow run update-sogou-input.yml

# 如果遇到分页器问题，请使用：
export PAGER=cat && gh workflow run update-sogou-input.yml
```

#### 监控工作流进度

```bash
# 列出最近的工作流运行
gh run list

# 查看特定运行的详情（替换 RUN_ID 为实际 ID）
gh run view RUN_ID

# 实时监控工作流进度
gh run watch RUN_ID
```

你也可以在仓库的 GitHub Actions 标签页上监控工作流执行情况。

## 故障排除

### GitHub Actions 常见问题

#### 问题一：`head: |: No such file or directory` 错误

**问题描述：**  
使用 `gh workflow run` 或 `gh run list` 等命令时，可能会遇到
"head: |: No such file or directory" 或 "head: cat: No such file or directory"
错误。

**解决方案：**  
将 GitHub CLI 的分页器设置为 `cat`：

```bash
export PAGER=cat && gh workflow run update-sogou-input.yml
```

**原因：**  
默认情况下，GitHub CLI 使用 `less` 作为分页器，但在某些环境中可能会导致问题。
将分页器设置为 `cat` 可以避免这个问题。

#### 问题二：`Resource not accessible by integration` 错误

**问题描述：**  
GitHub Actions 工作流运行时出现 "Resource not accessible by integration" 错误，
无法创建发布版本或推送更改。

**解决方案：**  
使用 GitHub CLI 修改仓库的工作流权限，允许工作流写入内容：

```bash
gh api -X PUT repos/:owner/:repo/actions/permissions/workflow \
  -f default_workflow_permissions='write'
```

**原因：**  
默认情况下，GitHub Actions 工作流没有足够的权限来创建发布版本或推送更改。
通过修改仓库的工作流权限，可以授予工作流写入内容的权限。

**验证权限设置：**  

```bash
gh api repos/:owner/:repo/actions/permissions/workflow --jq '.'
```

输出应该包含 `"default_workflow_permissions": "write"`。

## 许可证

本项目根据此仓库中包含的 LICENSE 文件的条款获得许可。

## 免责声明

搜狗输入法是搜狗公司的产品。此 tap 与搜狗公司没有官方关联。
