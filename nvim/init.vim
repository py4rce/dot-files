" INFORMACION:
" PACKAGE MANAGER: VIM-PLUG
" CANTIDAD DE PLUGINS :
" TECLA LEADER : "\"
let mapleader = "\\"


" vim: foldmethod=marker

" ============================= Load vim-plugins ============================= 
" Load vim-plug {{{
" Install vim plug if not installed
let data_dir = has('nvim') ? stdpath('config') : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" }}}

" ============================= VIM standard configuration ============================= 
" VIM standard configuration {{{
syntax on
" We want everything to be utf-8
set encoding=utf-8
" - a: Automatically format paragraphs when typing. This option is off by default.
" - c: Automatically break comments using the textwidth value. This option is on by default.
" - l: Do not break lines that are already long when formatting. This option is off by default.
" - m: Automatically break the current line before inserting a new comment line when typing text
"   beyond textwidth. This option is off by default.
" - n: Recognize numbered lists. When hitting <Enter> in insert mode, the next line will have the
"   same or incremented number. This option is on by default.
" - o: Automatically insert the comment leader when hitting 'o' or 'O' in normal mode. This option
"   is on by default.
" - p: Preserve the existing formatting when using the gq command. This option is off by default.
" - q: Allow the use of gq to format comments. This option is on by default.
" - r: Automatically insert the comment leader when hitting <Enter> in insert mode. This option is
"   on by default.
" - t: Automatically wrap text using textwidth when typing. This option is off by default.
" - v: In visual mode, when using the gq command, break lines at a blank character instead of a
"   blank space. This option is off by default.
" - w: Recognize only whitespace when breaking lines with gq. This option is off by default.
set formatoptions=cronm
" This sets the width of a tab character to 4 spaces.
set tabstop=4
" This sets the number of spaces used when the <Tab> key is pressed in insert mode to 4.
set softtabstop=4
" This sets the number of spaces used for each indentation level when using
" the '>' and '<' commands, as well as the autoindent feature.
set shiftwidth=4
" This setting enables automatic indentation, which will copy the indentation
" of the current line when starting a new line.
set autoindent
" This disables the automatic conversion of tabs to spaces when you press the
" <Tab> key.
set noexpandtab
" This enables the use of the mouse in all modes (normal, visual, insert,
" command-line, etc.).
set mouse=a
" This displays line numbers in the left margin.
set number
" This disables the creation of backup files.
set nobackup
" This disables the creation of swap files.
set noswapfile
" Automatically reload files when they change
set autoread
" Enable spell checking
set spell
set spelllang=en
" Highlight the current line
set cursorline
" Show white space characters and tab characters
set list
" Configure how nonprintable characters should be displayed
set listchars=tab:>-,trail:•
" Highlight the 100th column
set colorcolumn=80
" Set text width
set textwidth=80
" Set signcolumn to be expandable
set signcolumn=auto:2
" Use system clipboard
set clipboard=unnamedplus

" This maps the '<' and '>' keys in visual mode to shift the selected text one
" shift width to the left or right and reselect the shifted text.
vnoremap < <gv
vnoremap > >gv

" The next four lines define key mappings for switching between windows using
" Ctrl + hjkl keys
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" The next four lines define key mappings for resizing windows using Alt +
" hjkl keys:
map <a-l> :vertical res -5<CR>
map <a-h> :vertical res +5<CR>
map <a-j> :res -5<CR>
map <a-k> :res +5<CR>

" These lines define key mappings for moving the cursor vertically more quickly
nnoremap <S-h> 5h
vnoremap <S-h> 5h
nnoremap <S-l> 5l
vnoremap <S-l> 5l
nnoremap <S-j> 5j
vnoremap <S-j> 5j
nnoremap <S-k> 5k
vnoremap <S-k> 5k

" Map r to redo
nmap r :redo<CR>

" Enable folding
set foldenable
" Configure fold method
" - indent (bigger the indent is - larger the fold level; works quite well for many programming
"   languages)
" - syntax (folding is defined in the syntax files)
" - marker (looks for markers in the text; everything within comments foldable block {{{ and }}} is
"   a fold)
" - expr (fold level is calculated for each line by providing a special function)
set foldmethod=marker
" Set the fold level to start with all folds open
set foldlevelstart=99
" Set the fold nesting level (default is 20)
set foldnestmax=10
" Automatically close folds when the cursor leaves them
set foldclose=
" Open folds upon all motion events
set foldopen=
" Do not automatically adjust width of vertical splits
set noequalalways
" Our default format for compiler errors is gcc
compiler gcc
" }}}
" ============================= Vim script settings ============================= 
" Vim script settings {{{
augroup VimScriptExtras
	au!
	au FileType vim vnoremap <buffer> <C-r> "*y \| <Esc>:@*<CR>
augroup END
" }}}

 
" Settings: quickfix {{{
nnoremap <C-q> :copen<CR>
augroup QuickFixGroup
	au!
	au FileType qf nnoremap <buffer> n :cnext<CR>
	au FileType qf nnoremap <buffer> p :cprev<CR>
	au FileType qf nnoremap <buffer> <C-i> :cclose<CR>
augroup END
" }}}

au CursorMovedI *.md call ModifyTextWidth() " Use only within *.md files

function! ModifyTextWidth()
    if getline(".")=~'^.*\[.*\](.*)$' " If the line ends with Markdown link - set big value for textwidth
        setlocal textwidth=500
    else
        setlocal textwidth=80 " Otherwise use normal textwidth
    endif
endfunction

" Settings: wildmenu {{{
" This remaps the keys so up and down works in completion menus
"cnoremap <Up> <C-p>
"cnoremap <Down> <C-n>
" }}}

" Settings: highlight unwanted spaces {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup TrailingWhitespace
	autocmd!
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
	autocmd FileType floaterm highlight clear ExtraWhitespace
augroup end
let c_space_errors = 1
" }}}

" ============================= Load vim plugins ============================= 
" Load vim plugins {{{
call plug#begin()
	" Plug 'airblade/vim-gitgutter'
	" Plug '~/.config/nvim/mrtee'
	" Plug 'dhruvasagar/vim-dotoo' " managing to-do lists.
	" Plug 'hrsh7th/nvim-compe' " versatile auto-completion. (DEPRECATED)
	Plug 'github/copilot.vim' " AI-assisted coding.
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'akinsho/bufferline.nvim', { 'tag': 'v4.9.0' } " plugin for tab line at the top
	Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " a beautiful color scheme
	Plug 'dense-analysis/ale' " linting and fixing code.
	Plug 'habamax/vim-asciidoctor' " editing AsciiDoc files.
	Plug 'inkarkat/vim-AdvancedSorters' " advanced sorting of text.
	Plug 'inkarkat/vim-ingo-library' " a library of useful functions for Vim.
	Plug 'jeetsukumaran/vim-buffergator' " easy switching between buffers.
	Plug 'junegunn/goyo.vim' " Clean interface when you need it
	Plug 'kkvh/vim-docker-tools' " Docker integration
	Plug 'ledger/vim-ledger' " ledger accounting system.
	Plug 'lervag/vimtex' " LaTeX editing.
	Plug 'lewis6991/gitsigns.nvim' " text buffer Git integration.
	Plug 'majutsushi/tagbar' " displaying tags in a sidebar.
	Plug 'mbbill/undotree' " Undo/Redo History Visualizer
	Plug 'morhetz/gruvbox' " Gruvbox: Color Scheme
	Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'} " text completion endine
	Plug 'neovim/nvim-lspconfig' " Language Server Protocol Config
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax and code analysis
	Plug 'p00f/nvim-ts-rainbow' " Colorful parenthesis
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " File explorer
	Plug 'puremourning/vimspector' " Debugger integration
	Plug 'ryanoasis/vim-devicons' " Developer font icons
	Plug 'stsewd/sphinx.nvim' " Sphinx integration
	Plug 'tpope/vim-commentary' " Commenting tool
	Plug 'tpope/vim-dispatch' " Asynchronous execution
	Plug 'tpope/vim-fugitive' " Git integration
	Plug 'tpope/vim-speeddating' " Quick date navigation
	Plug 'vim-airline/vim-airline' " Visual status line indicators
	Plug 'vim-airline/vim-airline-themes' " Themes for airline
	Plug 'vim-scripts/DoxygenToolkit.vim' " Doxygen support
	Plug 'vim-scripts/SpellCheck' " Spell checking
	Plug 'vim-scripts/c.vim' " Syntax highlighting and indentation
	Plug 'vimwiki/vimwiki' " Note taking and task management
	Plug 'voldikss/vim-floaterm' " Floating terminal support
	Plug 'pangloss/vim-javascript'    " JavaScript support
	Plug 'leafgarland/typescript-vim' " TypeScript syntax
	Plug 'MaxMEllon/vim-jsx-pretty'   " JS and JSX syntax
	Plug 'jparise/vim-graphql'        " GraphQL syntax
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
 	Plug 'hrsh7th/vim-vsnip'
	Plug 'hrsh7th/vim-vsnip-integ'	
	" follow latest release and install jsregexp.
	Plug 'L3MON4D3/LuaSnip' 
	Plug 'rafamadriz/friendly-snippets'
 	Plug 'folke/which-key.nvim'
	Plug 'itchyny/calendar.vim'
	Plug 'nvimdev/dashboard-nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
call plug#end()
" }}}

" Update all plugins
"
"
"
"
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| :PlugInstall --sync
\| endif

" ============================= catppuccin/nvim (THEME) ============================= 
" https://github.com/catppuccin/nvim
" Plugin: catppuccin/nvim {{{
colorscheme catppuccin-latte
set background=dark " Optional: change to 'light' for the light version
" }}}


" ============================= lewis6991/gitsigns.nvim ============================= 

" Plugin: lewis6991/gitsigns.nvim {{{
if has_key(plugs, 'gitsigns.nvim')
	lua << EOF
		require("gitsigns").setup{
			signs = {
				add          = { text = '│' },
				change       = { text = '│' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
		}
EOF
	" Popup what's changed in a hunk under cursor
	nnoremap <Leader>gp :Gitsigns preview_hunk<CR>
	" Stage/reset individual hunks under cursor in a file
	nnoremap <Leader>gs	:Gitsigns stage_hunk<CR>
	nnoremap <Leader>gr :Gitsigns reset_hunk<CR>
	nnoremap <Leader>gu :Gitsigns undo_stage_hunk<CR>

	" Stage/reset all hunks in a file
	nnoremap <Leader>gS :Gitsigns stage_buffer<CR>
	nnoremap <Leader>gU :Gitsigns reset_buffer_index<CR>
	nnoremap <Leader>gR :Gitsigns reset_buffer<CR>

	" Git blame
	nnoremap <Leader>gB :Gitsigns toggle_current_line_blame<CR>
endif
" }}}
 
 
" ============================= airblade/vim-gitgutter ============================= 
" Plugin: airblade/vim-gitgutter {{{
if has_key(plugs, 'vim-gitgutter')
	let g:gitgutter_enabled = 1
	let g:gitgutter_sign_added = '+'
	let g:gitgutter_sign_modified = '>'
	let g:gitgutter_sign_removed = '-'
	let g:gitgutter_sign_removed_first_line = '^'
	let g:gitgutter_sign_modified_removed = '<'
	nmap <Leader>gs <Plug>(GitGutterStageHunk)
	nmap <Leader>gu <Plug>(GitGutterUndoHunk)
	nmap <Leader>gn <Plug>(GitGutterNextHunk)
	nmap <Leader>gp <Plug>(GitGutterPrevHunk)
	nmap <Leader>gh <Plug>(GitGutterPreviewHunk)
	function! GitStatus()
		let [a,m,r] = GitGutterGetHunkSummary()
		return printf('+%d ~%d -%d', a, m, r)
	endfunction
	set statusline+=%{GitStatus()}
endif
" }}}

" ============================= VIMTEX ============================= 
" Plugin: lervag/vimtex {{{
let g:tex_flavor = 'latex'
" }}}

" ============================= TAGBAR ============================= 
" Plugin: majutsushi/tagbar {{{
nmap <F8> :TagbarToggle<CR>

" Add support for reStructuredText files in tagbar.
let g:tagbar_type_rst = {
	\ 'ctagstype': 'rst',
	\ 'ctagsbin' : '/home/martin/.local/bin/rst2ctags',
	\ 'ctagsargs' : '-f - --sort=yes --sro=»',
	\ 'kinds' : [
		\ 's:sections',
		\ 'i:images'
	\ ],
	\ 'sro' : '»',
	\ 'kind2scope' : {
		\ 's' : 'section',
	\ },
	\ 'sort': 0,
\ }
" }}}

" ============================= mbbill/undotree ============================= 
" Plugin: mbbill/undotree {{{
nmap <F5> :UndotreeToggle<CR>
" }}}

" ============================= tpope/vim-speeddating ============================= 
" Plugin: tpope/vim-speeddating {{{
" Remap these because C-A is a tmux escape sequence
let g:speeddating_no_mappings = 1
nmap <C-u> <Plug>SpeedDatingUp
nmap <C-d> <Plug>SpeedDatingDown
xmap <C-u> <Plug>SpeedDatingUp
xmap <C-d> <Plug>SpeedDatingDown
nmap <leader>sdu <Plug>SpeedDatingNowUTC
nmap <leader>sdi <Plug>SpeedDatingNowLocal
" }}}

" ============================= vimwiki/vimwiki ============================= 
" Plugin: vimwiki/vimwiki {{{
" Set Vimwiki settings
let g:vimwiki_list = [{'path': '/home/jose4rce/Vaults/HACKING NOTES/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" }}}

" ============================= dense-analysis/ale ============================= 
" Plugin: dense-analysis/ale {{{
if has_key(plugs, 'ale')
	" Ignore git commit when linting (highly annoying)
	let g:ale_pattern_options = {
	\		'COMMIT_EDITMSG$': {'ale_linters': [], 'ale_fixers': []}
	\	}
	let g:ale_linters = {
	\	'yaml': ['yamllint'],
	\	'cpp': ['clangtidy'],
	\	'c': ['clangtidy'],
	\	'asciidoc': ['cspell'],
	\	'markdown': ['cspell']
	\	}
	let g:ale_linter_aliases = {
	\	'asciidoctor': 'asciidoc'
	\}
	let g:ale_fixers = {
	\	'cpp': ['clang-format'],
	\	'c': ['clang-format']}
	let g:ale_linters_explicit = 0
	let g:ale_completion_enabled = 1
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	let g:ale_set_balloons=1
	let g:ale_hover_to_floating_preview=1
	let g:ale_use_global_executables = 1
	let g:ale_sign_column_always = 1
	let g:ale_disable_lsp = 1

	" Cspell options
	let g:ale_cspell_use_global = 1
	let g:ale_cspell_options = '-c cspell.json'

	" Clang Tidy configuration
	let g:ale_cpp_clangtidy_options = '-checks=-*,cppcoreguidelines-*'
	let g:ale_cpp_clangtidy_checks = ['readability-*,performance-*,bugprone-*,misc-*']
	let g:ale_cpp_clangtidy_checks += ['clang-analyzer-cplusplus-doc-comments']

	let g:ale_c_clangtidy_options = '-checks=-*,cppcoreguidelines-*'
	let g:ale_c_clangtidy_checks = ['readability-*,performance-*,bugprone-*,misc-*']
	let g:ale_c_clangtidy_checks += ['-readability-function-cognitive-complexity']
	let g:ale_c_clangtidy_checks += ['-readability-identifier-length']
	let g:ale_c_clangtidy_checks += ['-misc-redundant-expression']
	let g:ale_c_build_dir_names = ['build', 'release', 'debug']
	let g:ale_set_balloons=1
	let g:ale_hover_to_floating_preview=1

	" Automatic fixing
	autocmd FileType c nnoremap <leader>f <Plug>(ale_fix)

	" This function searches for the first clang-tidy config in parent directories and sets it
	function! SetClangTidyConfig()
		let l:config_file = findfile('.clang-tidy', expand('%:p:h').';')
		if !empty(l:config_file)
			let g:ale_c_clangtidy_options = '--config=' . l:config_file
			let g:ale_cpp_clangtidy_options = '--config=' . l:config_file
		endif
	endfunction

	" Run this for c and c++ files
	autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp call SetClangTidyConfig()

	" Diagnostics
	let g:ale_use_neovim_diagnostics_api = 1
	let g:airline#extensions#ale#enabled = 1
	" let g:ale_sign_error = '>>'
	" let g:ale_sign_warning = '!!'
endif
" }}}

" ============================= dhruvasagar/vim-dotoo ============================= 
" Plugin: dhruvasagar/vim-dotoo {{{
if has_key(plugs, 'vim-dotoo')
	let g:dotoo#agenda#files = ['~/vimwiki/*.dotoo']
	au BufRead,BufNewFile *.dotoo set filetype=dotoo
endif
" }}}
" ============================= habamax/vim-asciidoctor ============================= 
" sudo apt install ruby ruby-dev
" gem install asciidoctor-pdf
" gem install asciidoctor-diagram

" Plugin: habamax/vim-asciidoctor {{{

if has_key(plugs, 'vim-asciidoctor')

    " Configuración de ejecutables
    let g:asciidoctor_executable = 'asciidoctor'
    let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
    let g:asciidoctor_css_path = '~/docs/AsciiDocThemes'
    let g:asciidoctor_css = 'haba-asciidoctor.css'

    let g:asciidoctor_pdf_executable = 'asciidoctor-pdf'
    let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']
    let g:asciidoctor_pdf_themes_path = '~/docs/AsciiDocThemes'
    let g:asciidoctor_pdf_fonts_path = '~/docs/AsciiDocThemes/fonts'

    let g:asciidoctor_pandoc_executable = 'pandoc'
    let g:asciidoctor_pandoc_data_dir = '~/docs/.pandoc'
    let g:asciidoctor_pandoc_other_params = '--toc'
    let g:asciidoctor_pandoc_reference_doc = 'custom-reference.docx'

    " Plegado de secciones
    let g:asciidoctor_folding = 1
    let g:asciidoctor_fold_options = 1

    " Resaltado de sintaxis y ocultamiento de caracteres especiales
    let g:asciidoctor_syntax_conceal = 1
    let g:asciidoctor_syntax_indented = 0
    let g:asciidoctor_fenced_languages = ['python', 'c', 'javascript']

    " Mapas de teclas para conversión y exportación
    fun! AsciidoctorMappings()
        nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
        nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
        nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
        nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
        nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
        nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
        nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
        nnoremap <buffer> <leader>p :AsciidoctorPasteImage<CR>
        compiler asciidoctor2pdf
    endfun

    " Aplicar mappings a archivos .adoc y .asciidoc
    augroup asciidoctor
        au!
        au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
    augroup END

endif
 

" ============================= jeetsukumaran/vim-buffergator ============================= 
" Plugin: jeetsukumaran/vim-buffergator {{{
nmap <silent> <leader>bb :BuffergatorOpen<CR>
nmap <silent> <leader>bB :BuffergatorOpenInTab<CR>
nnoremap <leader>bn :BuffergatorMruCycleNext<CR>
nnoremap <leader>bp :BuffergatorMruCyclePrev<CR>
nnoremap <leader>bd :bdelete<CR>

" }}}
" ============================= ervag/vimtex ============================= 
" Plugin: lervag/vimtex: Latex editing {{{
let g:tex_flavor = 'latex'
" }}}
" ============================= majutsushi/tagbar ============================= 
" Plugin: majutsushi/tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" ============================= mbbill/undotree ============================= 
" Plugin: mbbill/undotree {{{
nmap <F5> :UndotreeToggle<CR>
" }}}
" ============================= ledger/vim-ledger ============================= 
" Plugin: ledger/vim-ledger: accounting {{{
autocmd BufRead,BufNewFile *.ledger,*.ldg set filetype=ledger
autocmd FileType ledger setlocal includeexpr=substitute(v:fname,'^.*[\\/]\zs','','')
" }}}
" ============================= tpope/vim-fugitive ============================= 
" Plugin: tpope/vim-fugitive {{{
" Open git status in interative window (similar to lazygit)
nnoremap <Leader>gg :Git<CR>

" Show `git status output`
nnoremap <Leader>gi :Git status<CR>

" Open commit window (creates commit after writing and saving commit msg)
nnoremap <Leader>gc :Git commit<CR>

" See who committed a particular line of code
nnoremap <Leader>gb :Git blame<CR>

" Other tools from fugitive
nnoremap <Leader>gd :Git difftool<CR>
nnoremap <Leader>gm :Git mergetool<CR>
nnoremap <Leader>gdv :Gvdiffsplit<CR>
nnoremap <Leader>gdh :Gdiffsplit<CR>
" }}}

 
" ============================= nvim-treesitter/nvim-treesitter ============================= 
" Plugin: nvim-treesitter/nvim-treesitter {{{
if has_key(plugs, 'nvim-treesitter')
	lua << EOF
		-- Treesitter configuration
		require('nvim-treesitter.configs').setup {
			-- If TS highlights are not enabled at all, or disabled via `disable` prop,
			-- highlighting will fallback to default Vim syntax highlighting
			highlight = {
				enable = false, -- false will disable the whole extension
				extended_mode = false,
			use_languagetree = true,
			disable = {}, -- list of language that will be disabled
				-- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
				-- Required for spellcheck, some LaTex highlights and
				-- code block highlights that do not have ts grammar
				additional_vim_regex_highlighting = {'org'},
			},
			rainbow = {
				enable = true,
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				colors = {}, -- table of hex strings
				termcolors = {} -- table of colour name strings
			},
			ensure_installed = { 'c'},
		}
EOF
endif
" }}}
" ============================= preservim/nerdtree ============================= 
" Plugin: preservim/nerdtree {{{
autocmd FileType nerdtree setlocal nolist
let g:NERDTreeWinSize = 40
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$', '\.obj$', '\.a$', '\.so$', '\.out$', '\.git$']
let NERDTreeShowHidden = 1
let g:NERDTreeGitStatusIndicatorMapCustom = {
\ 'Modified'  :'✹',
\ 'Staged'    :'✚',
\ 'Untracked' :'✭',
\ 'Renamed'   :'➜',
\ 'Unmerged'  :'═',
\ 'Deleted'   :'✖',
\ 'Dirty'     :'✗',
\ 'Ignored'   :'☒',
\ 'Clean'     :'✔︎',
\ 'Unknown'   :'?',
\ }
" }}}


" ============================= puremourning/vimspector ============================= 
" Plugin: puremourning/vimspector {{{
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>dx :call vimspector#Reset()<CR>
nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>
nnoremap <Leader>ds :call vimspector#StepInto()<CR>
nnoremap <Leader>dn :call vimspector#StepOver()<CR>
nnoremap <Leader>df :call vimspector#StepOut()<CR>
" }}}
" ============================= voldikss/vim ============================= 
" Plugin: voldikss/vim {{{
nnoremap <C-t> :FloatermToggle!<CR>
augroup FloattermMapping
	autocmd!
	autocmd FileType floaterm nnoremap <buffer> <Esc> <C-\><C-n>:FloatermToggle<CR>
	autocmd FileType floaterm inoremap <buffer> <Esc> <C-\><C-n>:FloatermToggle<CR>
augroup end
tnoremap <Esc> <C-\><C-n>:FloatermToggle<CR>
" }}}
" ============================= vim-airline/vim-airline : THEME BAR ============================= 
" Plugin: vim-airline/vim-airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'
" Enable wordcount
let g:airline#extensions#wordcount#enabled = 1
" Add notes to filetypes
let g:airline#extensions#wordcount#filetypes = 'notes|help|markdown|rst|org|text|asciidoctor|tex|mail|plaintext|context'
" }}}

" Settings: spelling {{{
command! SpellIgnore :call execute('spell! ' . expand('<cword>'))
nnoremap <Leader>s :call execute('spell! ' . expand('<cword>'))<CR>
" }}}
 
" ============================= neovim/nvim-lspconfig ============================= 
" Plugin: neovim/nvim-lspconfig: language server configs {{{
lua << EOF
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{}
lspconfig.vimls.setup {}
lspconfig.dockerls.setup {}
lspconfig.tailwindcss.setup{}
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
	client.config.flags = {
      debounce_text_changes = 150,  -- Adjust this value as needed
    }
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}
lspconfig.robotframework_ls.setup({})
lspconfig.clangd.setup{
	cmd = { "clangd", "--background-index" },
	filetypes = { "c", "cpp" },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, opts)
		vim.keymap.set('i', '<leader>K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- Diagnostics for LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = false,
		underline = false,
		update_in_insert = false,
	}
)
EOF
" }}}

" ============================= NVIM-CMP ============================= 
" nvim-cmp → Sistema de autocompletado configurable.
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
EOF


" ============================= neoclide/coc.nvim: autocompletion =============================
" es un complemento de autocompletado y asistencia para código en Neovim basado en el protocolo LSP (Language Server Protocol).
" :CocInstall coc-snippets   Permite instalar snippets 
" :CocConfig 	Agrega lo siguiente: friendly-snippets → Paquete de snippets listos para usar.

" {
"   "snippets.extends": {
"     "javascript": ["javascriptreact"],
"     "typescript": ["typescriptreact"],
"     "python": ["python"],
"     "lua": ["lua"],
"     "cpp": ["cpp"],
"     "c": ["c"]
"   }
" }

  
 " Plugin: neoclide/coc.nvim: autocompletion {{{
if has_key(plugs, 'coc.nvim')
	let g:coc_global_extensions = ['coc-clangd', 'coc-tsserver']
	let g:clangd_install_prefix = '/usr/'
	let g:clangd_command = ['clangd',
	\	'--clang-tidy',
	\	'--background-index',
	\	'--header-insertion-decorators=0',
	\	'--completion-style=detailed']

	nnoremap <silent> ? :call <sid>show_documentation()<cr>
	function! s:show_documentation()
		if index(['vim', 'help'], &filetype) >= 0
			execute 'help ' . expand('<cword>')
		elseif &filetype ==# 'tex'
			VimtexDocPackage
		else
			call CocAction('doHover')
		endif
	endfunction
	" Use <c-space> to trigger completion
	if has('nvim')
		inoremap <silent><expr> <c-space> coc#refresh()
	else
		inoremap <silent><expr> <c-@> coc#refresh()
	endif
	" Use tab for trigger completion with characters ahead and navigate
	" NOTE: There's always complete item selected by default, you may want to enable
	" no select by `"suggest.noselect": true` in your configuration file
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config
	inoremap <silent><expr> <TAB>
		\ coc#pum#visible() ? coc#pum#confirm() :
		\ CheckBackspace() ? "\<Tab>" :
		\ coc#refresh()
	" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
	function! CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	" Applying code actions to the selected code block
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying code actions at the cursor position
	nmap <leader>ac  <Plug>(coc-codeaction-cursor)
	" Remap keys for apply code actions affect whole buffer
	nmap <leader>as  <Plug>(coc-codeaction-source)
	" Apply the most preferred quickfix action to fix diagnostic on the current line
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Remap keys for applying refactor code actions
	nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
	xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
	nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

	" Run the Code Lens action on the current line
	nmap <leader>cl  <Plug>(coc-codelens-action)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Map function and class text objects
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server
	xmap if <Plug>(coc-funcobj-i)
	omap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap af <Plug>(coc-funcobj-a)
	xmap ic <Plug>(coc-classobj-i)
	omap ic <Plug>(coc-classobj-i)
	xmap ac <Plug>(coc-classobj-a)
	omap ac <Plug>(coc-classobj-a)

	" Remap <C-f> and <C-b> to scroll float windows/popups
	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	endif

	" Use CTRL-S for selections ranges
	" Requires 'textDocument/selectionRange' support of language server
	nmap <silent> <C-s> <Plug>(coc-range-select)
	xmap <silent> <C-s> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer
	command! -nargs=0 Format :call CocActionAsync('format')

	" Add `:Fold` command to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer
	command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

	" Mappings for CoCList
	" Show all diagnostics
	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions
	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
	" Show commands
	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document
	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols
	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item
	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item
	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list
	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif
" }}}
 
" ============================= folke/which-key.nvim =============================
lua << EOF
require("which-key").setup {}
EOF
nnoremap <leader>w :WhichKey<CR>
nnoremap <leader>p :Dashboard<CR>



lua << EOF
require('dashboard').setup {
  theme = 'hyper',
  config = {
    header = {
"██╗  ██╗██████╗  ██████╗███████╗",
"██║  ██║██╔══██╗██╔════╝██╔════╝",
"███████║██████╔╝██║     █████╗  ",
"╚════██║██╔══██╗██║     ██╔══╝  ",
"     ██║██║  ██║╚██████╗███████╗",
"     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝",
    \'   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ',
    \'    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
    \'          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ',
    \'           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
    \'          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
    \'   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
    \'  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
    \' ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
    \' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ',
    \'      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
    \'       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
    },
    shortcut = {
      { desc = "🔎Find File", group = "@property", action = "Telescope find_files", key = "f" },
      { desc = "🌐Recent", group = "@property", action = "Telescope oldfiles", key = "r" },
      { desc = "👀Find Word", group = "@property", action = "Telescope live_grep", key = "w" },
      { desc = "⚙️ Config", group = "@property", action = "e ~/.config/nvim/init.vim", key = "c" },
      { desc = "👋Quit", group = "@property", action = "qa", key = "q" },
    },
  }
}
EOF

lua << EOF
local telescope = require('telescope')
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false, -- Deshabilita el scroll hacia arriba
        ["<C-d>"] = false, -- Deshabilita el scroll hacia abajo
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "ivy",
    },
  },
}
EOF




