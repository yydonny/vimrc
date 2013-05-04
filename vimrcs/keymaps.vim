
" scrolling and cursor movement
noremap - <S-Down>
noremap = <S-Up>

noremap 0 ^
noremap ; <End>
noremap <Space> w

" don't overwrite the registry when delete with x
nnoremap x "_x

" auto complete
inoremap <M-n> <C-n>

" Windows-style paste
inoremap <C-v> <C-R>*
cnoremap <C-v> <C-R>*


" cursor movement in edit modes
inoremap <M-o> <Esc>o
inoremap <M-b> <Esc>^i
inoremap <M-;> <End>

inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

cnoremap <M-b> <C-b>
cnoremap <M-;> <End>
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>


" tabs and windows control (switching, closing, etc.)
nnoremap <C-q> :q<CR>
nnoremap <C-w> :tabclose<CR>

nnoremap <M-w> :tabprevious<CR>
inoremap <M-w> <Esc>:tabprevious<CR>
nnoremap <C-Tab> :tabnext<CR>

nnoremap <Leader>m :tabmove

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-Left> <C-W>h
nnoremap <C-Down> <C-W>j
nnoremap <C-Up> <C-W>k
nnoremap <C-Right> <C-W>l


" buffer control
nnoremap <Leader>bd :Bclose<CR>
nnoremap <Leader>ba :1,1000 bd!<CR>
nnoremap <Leader>bt :tab sball<CR>

" open new...
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>e :tabedit <C-r>=expand("%:p:h")<CR>/

nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <Leader>sb :tabnew ./sandbox.tmp<CR>

cnoremap <Leader><Space> tabedit <C-\>eCurrentFileDir("e")<CR>
cnoremap <Leader>u <C-\>eDeleteTillSlash()<cr>



" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


" When you press gv you vimgrep after the selected text
vnoremap <silent> <Leader>g :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
nnoremap <Leader><Space> :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
nnoremap <Leader>g :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <Leader>r :call VisualSelection('replace', '')<CR>

nnoremap <Leader>c :botright cope20<CR>
nnoremap <Leader>cn :cn<CR>
nnoremap <Leader>cp :cp<CR>


" change window size
function! s:mysize(mode)
	if a:mode > 0
		winsize 120 32
	else
		winsize 100 24
	endif
endfunction
function! s:myfullscreen()
	simalt ~x
endfunction
command! -nargs=0 FA	call <SID>mysize(-1)
command! -nargs=0 FD	call <SID>mysize(1)
command! -nargs=0 FS	call <SID>myfullscreen()


" toggle line comment
vnoremap <Leader># :s/^/\# /<CR>:nohlsearch<CR>
vnoremap <Leader>/ :s/^/\/\/ /<CR>:nohlsearch<CR>
vnoremap <Leader>; :s/^/; /<CR>:nohlsearch<CR>
vnoremap <Leader>" :s/^/" /<CR>:nohlsearch<CR>
vnoremap <Leader>- :s/^/-- /<CR>:nohlsearch<CR>
vnoremap <Leader>c :s/^\/\/ \\|^-- \\|^["\#;] //<CR>:nohlsearch<CR>

" toggle block comment
vnoremap <Leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vnoremap <Leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vnoremap <Leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR> 


" surround selected with...
vnoremap () <esc>`>a)<esc>`<i(<esc>
vnoremap [] <esc>`>a]<esc>`<i[<esc>
vnoremap {} <esc>`>a}<esc>`<i{<esc>
vnoremap '' <esc>`>a'<esc>`<i'<esc>
vnoremap "" <esc>`>a"<esc>`<i"<esc>

" auto complete of (, ", ', [
inoremap ( ()<esc>i
inoremap () ()
inoremap [ []<esc>i
inoremap [] []
inoremap { {}<esc>i
inoremap {} {}
inoremap ' ''<esc>i
inoremap '' ''
inoremap " ""<esc>i
inoremap "" ""

" delete matched brackets
" (you must put the cursor on one side of the brackets to use this)
nnoremap <Leader>dd mh%r<Space>`hr<Space>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc






