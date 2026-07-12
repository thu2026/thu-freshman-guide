@echo off
chcp 65001 >nul
echo ============================================
echo   无锡太湖学院新生攻略 - Gitee 一键部署
echo ============================================
echo.

set /p GITEE_USER="请输入你的 Gitee 用户名: "
set /p REPO_NAME="请输入仓库名 (默认: thu-freshman-guide): "
if "%REPO_NAME%"=="" set REPO_NAME=thu-freshman-guide

echo.
echo 🔑 配置 SSH Key...
ssh-keygen -t ed25519 -C "gitee-freshman-guide" -f %USERPROFILE%\.ssh\gitee_guide -N "" -q

echo.
echo ⚠️  请将此 SSH 公钥添加到你的 Gitee 账号:
echo ─────────────────────────────────────────
type %USERPROFILE%\.ssh\gitee_guide.pub
echo ─────────────────────────────────────────
echo.
echo 📋 打开: https://gitee.com/profile/sshkeys
echo    粘贴上面的公钥 → 点击「添加公钥」
echo.
pause

echo.
echo 🚀 配置 Git 远程仓库...
git init
git checkout -b main 2>nul
git remote remove origin 2>nul
git remote add origin git@gitee.com:%GITEE_USER%/%REPO_NAME%.git

set GIT_SSH_COMMAND=ssh -i %USERPROFILE%\.ssh\gitee_guide -o StrictHostKeyChecking=no

echo.
echo 📦 提交代码...
git add -A
git commit -m "🎓 无锡太湖学院2026届新生全攻略" 2>nul

echo.
echo 📤 推送到 Gitee...
git push -u origin main

echo.
echo ✅ 部署完成！
echo 🔗 你的攻略地址: https://%GITEE_USER%.gitee.io/%REPO_NAME%/
echo.
echo 📋 下一步: 登录 gitee.com → 进入仓库 → 服务 → Gitee Pages → 开启
echo.
pause
