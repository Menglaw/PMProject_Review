@echo off
set GIT_EXE="C:\Program Files\Git\cmd\git.exe"

%GIT_EXE% add .
%GIT_EXE% commit -m "docs: Add review package for Module PM-02 Dashboard"
%GIT_EXE% push origin main
