@echo off
curl.exe -s -H ^
  "Authorization: Bearer %JR_CLI_AT%" ^
  "%JR_CLI_HOST%/rest/api/2/search?jql=assignee+in+(currentUser())+and+resolution+is+empty&fields=customfield_10008,summary" ^
  | jq ".issues | map ({key, \"summary\": .fields.summary, \"pmr\": .fields.customfield_10008.[0]})" ^
  | jq -r ".[] | [.pmr, .key, \"AtH\", .summary] | map(if . == null then \"00.000.000\" else . end) | join(\"_\") | gsub(\"[\\s()']\"; \"_\")"

