#!/bin/bash
# 克隆/拉取上游仓库并更新到当前仓库

# 删除已有的上游 repo 目录
rm -rf openwrt-passwall2
rm -rf openwrt-passwall-packages
rm -rf luci-app-adguardhome
rm -rf luci-app-alist
rm -rf luci-app-clash

# 克隆上游仓库
git clone https://github.com/xiaorouji/openwrt-passwall2.git
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git
git clone https://github.com/DHDAXCW/dhdaxcw-app.git
git clone https://github.com/someone/luci-app-alist.git
git clone https://github.com/someone/luci-app-clash.git

# 获取 luci-app-adguardhome
cd dhdaxcw-app
git sparse-checkout init --cone
git sparse-checkout set luci-app-adguardhome
mv luci-app-adguardhome ../
cd ..
rm -rf dhdaxcw-app

# 提交更改到当前仓库
git add .
git commit -m "Update from upstream repositories"
git push
