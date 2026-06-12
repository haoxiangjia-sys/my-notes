@echo off
chcp 65001 >nul
title Docker 环境一键安装

echo ========================================
echo    Docker 练习环境 一键安装
echo    WSL2 + Docker Desktop + MySQL + Linux
echo ========================================
echo.

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 请右键此文件 → "以管理员身份运行"！
    echo.
    pause
    exit /b 1
)

echo [第1步] 启用 WSL 功能...
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
echo.

echo [第2步] 启用虚拟机平台...
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo.

echo [第3步] 设置 WSL2 为默认版本...
wsl --set-default-version 2
echo.

echo [第4步] 安装 Ubuntu（这个需要下载，可能需要几分钟）...
wsl --install -d Ubuntu --no-launch
echo.

echo [第5步] 安装 Docker Desktop...
winget install Docker.DockerDesktop --accept-source-agreements --accept-package-agreements
echo.

echo ========================================
echo   安装完成！
echo ========================================
echo.
echo 接下来请：
echo   1. 重启电脑
echo   2. 启动 Docker Desktop（开始菜单中找）
echo   3. 回到此目录运行：
echo      docker compose up -d
echo.
echo 然后就可以开始练习了！
echo.
pause
