@echo off
git add .
set /p commit_message="Enter commit message (default: magic): "
if "%commit_message%"=="" set commit_message=magic
git commit -m "%commit_message%"
git pull origin main
git push origin main
pause