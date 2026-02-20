#!/usr/bin/env -S pwsh -NoProfile

$JR_CLI_AT=$env:JR_CLI_AT
$JR_CLI_HOST=$env:JR_CLI_HOST

$jql="assignee = currentUser() AND resolution = Unresolved order by updated DESC"
$jql_encoded=[System.Web.HttpUtility]::UrlEncode($jql)

curl.exe -s `
  "$JR_CLI_HOST/rest/api/2/search?jql=$jql_encoded&fields=summary,issuetype" `
    -H "Authorization: Bearer $JR_CLI_AT" ` 
  | jq '.issues | map ({key, "summary": .fields.summary, "issuetype": .fields.issuetype})' `
  | jq -r '.[]
          | [
                (if .issuetype.name == "Bug" then "bugfix" else if .issuetype == "New Feature" then "feature" else "feature" end end),
                ([.key, .summary] | join("-") | gsub("\\s[-^&]\\s"; "-") | gsub("[\\/\\s]"; "-") | gsub("[()'']"; "") | gsub("\\.$"; ""))
            ] | join("/")'

