syntax on

" I like relative line numbering and a middling scroll offset
set scrolloff=16
set number
set relativenumber

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nocompatible
set termguicolors     " enable true colors support
set cmdheight=2

call plug#begin('~/.vim/plugged')
Plug 'Mofiqul/dracula.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ray-x/aurora'
Plug 'sheerun/vim-polyglot'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
Plug 'rmagatti/goto-preview'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
call plug#end()

let NERDTreeShowHidden=1
let g:indentLine_char = '│' " for indentLine plugin
let g:sneak#label = 1
colorscheme aurora

" In case you mess up your write quits with a shift or something
command! Q q
command! W w

let mapleader = " "
nnoremap <leader>pv :NERDTreeFind<CR>
nnoremap <C-g> :NERDTreeFind<CR>

" Shortcut to instantly re-source this file after changing it
nnoremap <Leader><CR> :so ~/.vimrc<CR>

" Make navigating quickfix lists easier
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" Comment stuff out
vnoremap <C-c> <Plug>Commentary
nnoremap <C-c> <Plug>CommentaryLine

" Handy shortcut to tweak vim settings
nnoremap <leader>i :e ~/.vimrc<CR>

" No, highlighter. Just, no.
nnoremap <leader>no :noh<CR>

" Window swapping helpers
nnoremap <leader>0 <C-w>o
nnoremap <leader>1 <C-w>h
nnoremap <leader>2 <C-w>l
" Move the current file to the right viewport and put the alternate file on the left
nnoremap <leader>\ <C-w>v <Bar> <C-6> <Bar> <C-w>l

" Fuzzy finder
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Remap f and t to Sneak
map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Tabs to spaces, and indentation
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Move lines vertically 
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Open in Github
nnoremap <leader>og :GBrowse<CR>
vnoremap <leader>og :'<,'>GBrowse<CR>

" ----- Goto Preview -----

" Note: This plugin really isn't used for it's LSP - only used for it's stacking floating windown implementation

lua <<EOF
require'navigator'.setup()
require('goto-preview').setup {
  default_mappings = true;
}
EOF

" --- COC SETUP ---

" Tab completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Intellisesnse
" nmap <silent> gd :PreviewDefinition<CR>
" nmap <silent> gy :PreviewTypeDefinition<CR>
" nmap <silent> gr <Plug>(coc-references)
" nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" Show documentation (\h)
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Rename (\rn)
nmap <leader>rn <Plug>(coc-rename)

nmap <leader>cl <Plug>(coc-codelens-action)

" Inline previews (similar to VSCode)
function! OpenPreviewInline(...)
    let fname = a:1
    let call = ''
    if a:0 == 2
        let fname = a:2
        let call = a:1
    endif
    lua require('goto-preview.lib').open_floating_win(fname, { 1, 0 })
    " goto-preview does not actually open the correct file lol
    execute 'e ' . fname

    "" Execute the cursor movement command
    exe call
endfunction
command! -nargs=+ CocOpenPreviewInline :call OpenPreviewInline(<f-args>)

command! -nargs=0 PreviewDefinition :call CocActionAsync('jumpDefinition', 'CocOpenPreviewInline')
command! -nargs=0 PreviewTypeDefinition :call CocActionAsync('jumpTypeDefinition', 'CocOpenPreviewInline')

" ---- END COC SETUP ---

