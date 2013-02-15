

noremap 0 ^
noremap <Space> w

nnoremap x "_x

inoremap <M-n> <C-n>

inoremap <C-v> <C-R>*
cnoremap <C-v> <C-R>*

inoremap <C-o> <End>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-o> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>


noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

noremap <C-Left> <C-W>h
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Right> <C-W>l


noremap <C-w> q:
noremap <C-q> :q<CR>

noremap <Leader>bd :Bclose<CR>
noremap <Leader>ba :1,1000 bd!<CR>
noremap <Leader>bt :tab sball<CR>

noremap <Leader>t :tabnew<CR>
noremap <Leader>m :tabmove
noremap <Leader>e :tabedit <C-r>=expand("%:p:h")<CR>/
noremap <C-Tab> :tabnext<CR>

noremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif


" When you press gv you vimgrep after the selected text
vnoremap <silent> <Leader>g :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
nnoremap <Leader><Space> :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
nnoremap <Leader>g :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <Leader>r :call VisualSelection('replace', '')<CR>

nnoremap <Leader>c :botright cope20<CR>
noremap <Leader>n :cn<CR>
noremap <Leader>p :cp<CR>

noremap <Leader>sb :tabnew ./sandbox.tmp<CR>

cnoremap <Leader><Space> tabedit <C-\>eCurrentFileDir("e")<CR>
cnoremap <Leader>u <C-\>eDeleteTillSlash()<cr>


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

vnoremap <Leader># :s/^/\# /<CR>:nohlsearch<CR>
vnoremap <Leader>/ :s/^/\/\/ /<CR>:nohlsearch<CR>
vnoremap <Leader>; :s/^/; /<CR>:nohlsearch<CR>
vnoremap <Leader>" :s/^/" /<CR>:nohlsearch<CR>
vnoremap <Leader>- :s/^/-- /<CR>:nohlsearch<CR>
vnoremap <Leader>c :s/^\/\/ \\|^-- \\|^["\#;] //<CR>:nohlsearch<CR>

vnoremap <Leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vnoremap <Leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vnoremap <Leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR> 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap () <esc>`>a)<esc>`<i(<esc>
vnoremap [] <esc>`>a]<esc>`<i[<esc>
vnoremap {} <esc>`>a}<esc>`<i{<esc>
vnoremap '' <esc>`>a'<esc>`<i'<esc>
vnoremap "" <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap <> <><esc>i

inoremap ''' '''<esc>o'''<esc>O
inoremap """ """<esc>o"""<esc>O
inoremap ### ###<esc>o###<esc>O




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






