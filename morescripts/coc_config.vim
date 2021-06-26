autocmd BufAdd * if getfsize(expand('<afile>')) > 1024*1024 |

autocmd FileType python let b:coc_suggest_disable = 0
    \ let b:coc_enabled=0 |
    \ ndif

autocmd FileType python let b:coc_root_patterns =
    \ ['.git', '.env']

