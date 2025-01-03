complete -c hl -l config -d 'Configuration file path' -r
complete -c hl -l tail -d 'Number of last messages to preload from each file in --follow mode' -r
complete -c hl -l sync-interval-ms -d 'Synchronization interval for live streaming mode enabled by --follow option' -r
complete -c hl -l paging -d 'Control pager usage (HL_PAGER or PAGER)' -r -f -a "{auto\t'',always\t'',never\t''}"
complete -c hl -s l -l level -d 'Filter messages by level' -r
complete -c hl -l since -d 'Filter messages by timestamp >= <TIME> (--time-zone and --local options are honored)' -r
complete -c hl -l until -d 'Filter messages by timestamp <= <TIME> (--time-zone and --local options are honored)' -r
complete -c hl -s f -l filter -d 'Filter messages by field values [k=v, k~=v, k~~=v, \'k!=v\', \'k!~=v\', \'k!~~=v\'] where ~ does substring match and ~~ does regular expression match' -r
complete -c hl -s q -l query -d 'Filter using query, accepts expressions from --filter and supports \'(\', \')\', \'and\', \'or\', \'not\', \'in\', \'contain\', \'like\', \'<\', \'>\', \'<=\', \'>=\', etc' -r
complete -c hl -l color -d 'Color output control' -r -f -a "{auto\t'',always\t'',never\t''}"
complete -c hl -l theme -d 'Color theme' -r
complete -c hl -s h -l hide -d 'Hide or reveal fields with the specified keys, prefix with ! to reveal, specify \'!*\' to reveal all' -r
complete -c hl -l flatten -d 'Whether to flatten objects' -r -f -a "{never\t'',always\t''}"
complete -c hl -s t -l time-format -d 'Time format, see https://man7.org/linux/man-pages/man1/date.1.html' -r
complete -c hl -s Z -l time-zone -d 'Time zone name, see column "TZ identifier" at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones' -r
complete -c hl -l input-info -d 'Show input number and/or input filename before each message' -r -f -a "{auto\t'',none\t'',full\t'',compact\t'',minimal\t''}"
complete -c hl -s o -l output -d 'Output file' -r
complete -c hl -l input-format -d 'Input format' -r -f -a "{auto\t'',json\t'',logfmt\t''}"
complete -c hl -l unix-timestamp-unit -d 'Unix timestamp unit' -r -f -a "{auto\t'',s\t'',ms\t'',us\t'',ns\t''}"
complete -c hl -l delimiter -d 'Log message delimiter, [NUL, CR, LF, CRLF] or any custom string' -r
complete -c hl -l interrupt-ignore-count -d 'Number of interrupts to ignore, i.e. Ctrl-C (SIGINT)' -r
complete -c hl -l buffer-size -d 'Buffer size' -r
complete -c hl -l max-message-size -d 'Maximum message size' -r
complete -c hl -s C -l concurrency -d 'Number of processing threads' -r
complete -c hl -l shell-completions -d 'Print shell auto-completion script and exit' -r -f -a "{bash\t'',elvish\t'',fish\t'',powershell\t'',zsh\t''}"
complete -c hl -s s -l sort -d 'Sort messages chronologically'
complete -c hl -s F -l follow -d 'Follow input streams and sort messages chronologically during time frame set by --sync-interval-ms option'
complete -c hl -s P -d 'Handful alias for --paging=never, overrides --paging option'
complete -c hl -s c -d 'Handful alias for --color=always, overrides --color option'
complete -c hl -s r -l raw -d 'Output raw source messages instead of formatted messages, which can be useful for applying filters and saving results in their original format'
complete -c hl -l no-raw -d 'Disable raw source messages output, overrides --raw option'
complete -c hl -l raw-fields -d 'Output field values as is, without unescaping or prettifying'
complete -c hl -s L -l local -d 'Use local time zone, overrides --time-zone option'
complete -c hl -l no-local -d 'Disable local time zone, overrides --local option'
complete -c hl -s e -l hide-empty-fields -d 'Hide empty fields, applies for null, string, object and array fields only'
complete -c hl -s E -l show-empty-fields -d 'Show empty fields, overrides --hide-empty-fields option'
complete -c hl -l allow-prefix -d 'Allow non-JSON prefixes before JSON messages'
complete -c hl -l man-page -d 'Print man page and exit'
complete -c hl -l list-themes -d 'Print available themes and exit'
complete -c hl -l dump-index -d 'Print debug index metadata (in --sort mode) and exit'
complete -c hl -l help -d 'Print help'
complete -c hl -s V -l version -d 'Print version'
