@echo off
set GIT_EXE="C:\Program Files\Git\cmd\git.exe"

%GIT_EXE% init
%GIT_EXE% config user.name "AI Assistant"
%GIT_EXE% config user.email "ai@example.com"
%GIT_EXE% add .
%GIT_EXE% commit -m "docs: Initial review package for Module PM-01"
%GIT_EXE% branch -M main
%GIT_EXE% remote add origin https://github.com/Menglaw/PMProject_Review.git
%GIT_EXE% push -u origin main
