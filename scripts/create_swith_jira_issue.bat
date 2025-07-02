@echo off
git switch -q "feature/%1" || git switch -c "feature/%1"

