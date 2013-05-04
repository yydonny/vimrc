"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important: 
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => Load pathogen paths
""""""""""""""""""""""""""""""
call pathogen#infect('~/yydonny_vimrc/sources_forked')
call pathogen#infect('~/yydonny_vimrc/sources_non_forked')
call pathogen#helptags()

" """""""""""""""""""""""""""""""
" key maps for plugins "
" """""""""""""""""""""""""""""""

nnoremap <leader>f :MRU<CR>
nnoremap <leader>o :BufExplorer<cr>

let g:ctrlp_map = '<c-f>'
nnoremap <c-b> :CtrlPBuffer<cr>

nnoremap <leader>n :NERDTreeToggle<cr>


"""""""""""""""""""""""""""""""""""
" better syntax highlights "
"""""""""""""""""""""""""""""""""""
if has("gui_running")
  set background=dark
  colorscheme solarized
else
  colorscheme ir_black
endif


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400

""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
