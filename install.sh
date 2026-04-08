#!/bin/bash

echo "== 开始安装 Arch 环境 =="

# 1. 更新系统
sudo pacman -Syu --noconfirm

# 2. 安装 paru（如果没有）
if ! command -v paru &> /dev/null; then
    echo "安装 paru..."
    sudo pacman -Syu --needed base-devel git --noconfirm
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ..
fi

# 3. 安装软件
echo "安装软件..."
paru -Syu --needed - < pkglist.txt

# 4. 复制配置文件
echo "恢复配置文件..."
cp -r dotfiles/* ~/.config/

echo "== 安装完成！建议重启 =="
