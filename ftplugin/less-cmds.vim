if !executable('lessc')
    finish
endif

if !exists("g:less_command")
    let g:less_command = "lessc"
endif

if !exists("g:less_compress")
    let g:less_compress = 1
endif

if !exists("g:less_compress_to")
    let g:less_compress_to = 'styles.css'
endif

if !exists("g:less_autocompile_all")
    let g:less_autocompile_all = 0
endif

function! s:Less_Compile()
    if g:less_compress
        let g:less_command = "lessc --yui-compress"
    endif
    silent execute "!" . g:less_command . " " . expand("%") . " " . substitute(expand("%"), ".less", ".css", "")
endfunction

function! s:Less_Compile_All()
    if g:less_compress
        let g:less_command = "lessc --yui-compress"
    endif
    silent execute "!" . g:less_command . " " . expand("%:h") . "/*"  . " " . expand("%:h") . "/" . g:less_compress_to
endfunction

command! -nargs=0 -bar LessCompileAll call s:Less_Compile_All()
command! -nargs=0 -bar LessCompile call s:Less_Compile()

if g:less_autocompile_all
    :autocmd BufWritePost *.less LessCompileAll
else
    :autocmd BufWritePost *.less LessCompile
endif
