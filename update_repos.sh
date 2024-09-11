#!/bin/bash
# 克隆/拉取上游仓库并更新到当前仓库

# 删除已有的上游 repo 目录
rm -rf openwrt-passwall2
rm -rf openwrt-passwall-packages
rm -rf luci-app-ddns-go
rm -rf luci-app-wechatpush
rm -rf luci-theme-argon
rm -rf luci-app-argon-config
rm -rf luci-app-adguardhome


# 克隆上游仓库
git clone https://github.com/xiaorouji/openwrt-passwall2.git
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git
git clone https://github.com/sirpdboy/luci-app-ddns-go.git
git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush.git
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git
git clone https://github.com/DHDAXCW/dhdaxcw-app.git

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
