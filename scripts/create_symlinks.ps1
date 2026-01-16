function Create-RcLink
{
    param ($config)
    New-Item -Type SymbolicLink -Path "$env:USERPROFILE/.cmds/$config" -Target "$PSScriptRoot/$config"
}

Create-RcLink jira_branches.bat
Create-RcLink jira_branches.ps1
Create-RcLink create_switch_jira_issue.bat

