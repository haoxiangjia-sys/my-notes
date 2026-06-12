# ============================================
# Docker 练习环境一键安装脚本
# 右键 → "使用 PowerShell 运行"（需要管理员权限）
# 或者：管理员 PowerShell 中运行此脚本
# ============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Docker 练习环境安装脚本" -ForegroundColor Cyan
Write-Host "  包括: WSL2 + Docker Desktop" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查管理员权限
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[错误] 请以管理员身份运行此脚本！" -ForegroundColor Red
    Write-Host "右键此文件 → '使用 PowerShell 运行' 并确保有管理员权限" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "按任意键退出..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "[第1步] 启用 WSL 功能..." -ForegroundColor Green
try {
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart -ErrorAction Stop
    Write-Host "  ✓ WSL 功能已启用" -ForegroundColor Green
} catch {
    Write-Host "  WSL 功能可能已启用，跳过..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[第2步] 启用虚拟机平台..." -ForegroundColor Green
try {
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart -ErrorAction Stop
    Write-Host "  ✓ 虚拟机平台已启用" -ForegroundColor Green
} catch {
    Write-Host "  虚拟机平台可能已启用，跳过..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[第3步] 设置 WSL2 为默认版本..." -ForegroundColor Green
wsl --set-default-version 2 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ WSL2 已设为默认" -ForegroundColor Green
} else {
    Write-Host "  提示: 可能需要先安装 WSL2 内核更新包" -ForegroundColor Yellow
    Write-Host "  下载地址: https://aka.ms/wsl2kernel" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[第4步] 安装 Ubuntu..." -ForegroundColor Green
$ubuntuInstalled = wsl --list --quiet 2>$null | Select-String "Ubuntu"
if (-not $ubuntuInstalled) {
    Write-Host "  正在安装 Ubuntu（可能需要几分钟）..." -ForegroundColor Yellow
    wsl --install -d Ubuntu --no-launch
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Ubuntu 安装成功" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Ubuntu 安装可能失败，请手动运行: wsl --install -d Ubuntu" -ForegroundColor Red
    }
} else {
    Write-Host "  ✓ Ubuntu 已安装，跳过" -ForegroundColor Green
}

Write-Host ""
Write-Host "[第5步] 安装 Docker Desktop..." -ForegroundColor Green
$dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue
if (-not $dockerInstalled) {
    Write-Host "  正在通过 winget 安装 Docker Desktop..." -ForegroundColor Yellow
    winget install Docker.DockerDesktop --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Docker Desktop 安装成功" -ForegroundColor Green
        Write-Host "  ⚠ 安装完成后请手动启动 Docker Desktop（开始菜单搜索 Docker）" -ForegroundColor Yellow
    } else {
        Write-Host "  ⚠ winget 安装失败，请手动下载: https://www.docker.com/products/docker-desktop/" -ForegroundColor Red
    }
} else {
    Write-Host "  ✓ Docker 已安装，跳过" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  安装完成！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "后续步骤:" -ForegroundColor Yellow
Write-Host "  1. 重启电脑（如果提示需要重启）" -ForegroundColor White
Write-Host "  2. 启动 Docker Desktop（开始菜单→Docker Desktop）" -ForegroundColor White
Write-Host "  3. 等待 Docker Desktop 状态变为 'Engine running'" -ForegroundColor White
Write-Host "  4. 打开 PowerShell，进入 vault 的 scripts 目录" -ForegroundColor White
Write-Host "  5. 运行: docker compose up -d" -ForegroundColor White
Write-Host "  6. 然后: docker exec -it linux-practice bash" -ForegroundColor White
Write-Host ""
Write-Host "你的 docker-compose.yml 在:" -ForegroundColor Yellow
Write-Host "  $PSScriptRoot\docker-compose.yml" -ForegroundColor White
Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
