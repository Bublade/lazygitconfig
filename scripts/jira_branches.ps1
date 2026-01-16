#!/usr/bin/env -S pwsh -NoProfile

$JR_CLI_AT=$env:JR_CLI_AT
$JR_CLI_HOST=$env:JR_CLI_HOST

curl.exe -s `
  "$JR_CLI_HOST/rest/api/2/search?jql=assignee+in+(currentUser())+and+resolution+is+empty&fields=summary" `
    -H "Authorization: Bearer $JR_CLI_AT" ` 
  | jq '.issues | map ({key, "summary": .fields.summary})' `
  | jq -r '.[] | [.key, .summary] | join("-") | gsub("\\s[-^&]\\s"; "-") | gsub("[\\/\\s]"; "-") | gsub("[()'']"; "")'

