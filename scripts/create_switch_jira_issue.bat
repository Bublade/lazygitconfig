@echo off
git switch -q "%1" || git switch -c "%1"
