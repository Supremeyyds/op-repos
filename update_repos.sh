#!/bin/bash
# 更新上游仓库

# 拉取或克隆上游仓库
clone_or_pull() {
    local repo_url="$1"
    local repo_dir="$2"
    local branch="${3:-main}"

    if [ -d "$repo_dir" ]; then
        echo "Updating $repo_dir..."
        cd "$repo_dir"
        git pull origin "$branch"
        cd ..
    else
        git clone -b "$branch" "$repo_url" "$repo_dir"
    fi
}

# 拉取或克隆上游仓库
clone_or_pull "https://github.com/xiaorouji/openwrt-passwall2.git" "openwrt-passwall2"
clone_or_pull "https://github.com/xiaorouji/openwrt-passwall-packages.git" "openwrt-passwall-packages"
clone_or_pull "https://github.com/sirpdboy/luci-app-ddns-go.git" "luci-app-ddns-go"
clone_or_pull "https://github.com/tty228/luci-app-wechatpush.git" "luci-app-wechatpush" "openwrt-18.06"
clone_or_pull "https://github.com/jerrykuku/luci-theme-argon.git" "luci-theme-argon" "18.06"
clone_or_pull "https://github.com/jerrykuku/luci-app-argon-config.git" "luci-app-argon-config" "18.06"

# 获取 luci-app-adguardhome
if [ -d "luci-app-adguardhome" ]; then
    echo "Removing existing luci-app-adguardhome..."
    rm -rf luci-app-adguardhome
fi

git clone https://github.com/DHDAXCW/dhdaxcw-app.git
cd dhdaxcw-app
git sparse-checkout init --cone
git sparse-checkout set luci-app-adguardhome
mv luci-app-adguardhome ../
cd ..
rm -rf dhdaxcw-app

# 提交更改到当前仓库
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update from upstream repositories"
    git push
else
    echo "No changes to commit."
fi
