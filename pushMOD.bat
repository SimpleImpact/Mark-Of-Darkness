@echo off
REM ===========================================
REM  GitHub Push Automation Script
REM  Usage: push_to_github.bat "commit message"
REM ===========================================

REM Check if a commit message was provided

REM Display current directory
ECHO.
ECHO -------------------------------------------
ECHO Pushing repository from:
ECHO %CD%
ECHO -------------------------------------------

REM Add all changes
git add .

REM Commit changes with message
git commit -m "Update"

REM Pull latest changes (to avoid conflicts)
git pull origin master

REM Push changes to GitHub
git push origin master

ECHO.
ECHO ✅ Push completed successfully!
PAUSE
