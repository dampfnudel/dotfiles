" vim: set ft=vim ts=4 sw=4 expandtab :

"        ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄      ▄████████  ▄████████
"       ███    ███ ███  ▄██▀▀▀███▀▀▀██▄   ███    ███ ███    ███
"       ███    ███ ███▌ ███   ███   ███   ███    ███ ███    █▀
"       ███    ███ ███▌ ███   ███   ███  ▄███▄▄▄▄██▀ ███
"       ███    ███ ███▌ ███   ███   ███ ▀▀███▀▀▀▀▀   ███
"       ███    ███ ███  ███   ███   ███ ▀███████████ ███    █▄
" ████  ███    ███ ███  ███   ███   ███   ███    ███ ███    ███
" ████   ▀██████▀  █▀    ▀█   ███   █▀    ███    ███ ████████▀
"                                                ███    ███

" ASCII-Art credits: http://patorjk.com/software/taag/#p=display&f=Delta%20Corps%20Priest%201&t=.vimrc

" Dependencies
" pip install flake8
" brew install ctags
" cd ~/.vim/bundle/vimproc.vim && make
" hack font

" TODO
" servername
" vim tabs
" virtual lines?
" param autocomplete!
" append new tabs at the end
" sublime like tmpfiles
" braces behavior
" map split functionality
" carry comments to next line for js
" { -> }
" searchlist
" You can also use g; and g, to move backward and forward in your edit locations.
" show line numbers of *# occurrences
" easy motion keybindings
" markdown preview
" boilerplate
" g
" rezepte
" emacs
" - org mode
" - smart search replace
" autocomplete md... with dicts

" unite dropbox
" unite unite gists
" unite spotlight
" unite locate?
" unite open in vsplit

" git

" jedi

" UNITE!

" plugins {{{
    " vundle
    " {
        " :PluginInstall to install
        set nocompatible              " be iMproved, required
        filetype off                  " required
        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        " let Vundle manage Vundle, required
        Plugin 'gmarik/Vundle.vim'
    " }

    Plugin 'scrooloose/nerdtree'
    Plugin 'bling/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
    " Plugin 'kien/ctrlp.vim'
    Plugin 'vim-scripts/tComment'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'sjl/gundo.vim'
    Plugin 'embayer/vim_colorschemes'
    " Plugin 'gregsexton/MatchTag'
    Plugin 'nvie/vim-flake8'                            " pip install flake8
    Plugin 'tpope/vim-fugitive'
    " Plugin 'Keithbsmiley/swift.vim'
    Plugin 'majutsushi/tagbar'                          " brew install ctags
    Plugin 'mhinz/vim-startify'
    Plugin 'vim-scripts/YankRing.vim'
    Plugin 'itchyny/screensaver.vim'
    Plugin 'itchyny/thumbnail.vim'
    Plugin 'itchyny/calendar.vim'
    Plugin 'vim-scripts/matrix.vim--Yang'
    Plugin 'terryma/vim-expand-region'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'luochen1990/rainbow'
    Plugin 'Shougo/neocomplete.vim'
    " Plugin 'ervandew/supertab'
    Plugin 'scrooloose/syntastic'
    Plugin 'Valloric/YouCompleteMe'
    " Plugin 'vim-scripts/mru.vim'
    Plugin 'jistr/vim-nerdtree-tabs'
    " Plugin 'vim-scripts/noerrmsg.vim'
    " Plugin 'manuel-colmenero/vim-simple-session'
    " Plugin 'xolox/vim-misc'
    " Plugin 'xolox/vim-session'
    " Plugin 'szw/vim-ctrlspace'
    Plugin 'gorodinskiy/vim-coloresque'
    " Plugin 'kien/tabman.vim'
    Plugin 'valloric/MatchTagAlways'
    Plugin 'Shougo/unite.vim'
        Plugin 'Shougo/vimproc.vim'                     " make
        " Plugin 't9md/vim-unite-ack'
        Plugin 'h1mesuke/unite-outline'
        Plugin 'Shougo/neomru.vim'
        Plugin 'kmnk/vim-unite-giti'
        Plugin 'Shougo/neoyank.vim'
        " Plugin 'Shougo/unite-session'
    " Plugin 'mileszs/ack.vim'
    Plugin 'kballard/vim-swift'
    Plugin 'danro/rename.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'junegunn/vim-journal'
    Plugin 'godlygeek/csapprox'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'jceb/vim-orgmode'

    " plugin examples
    " {
        " gitbub
        " {
            "Plugin 'rstacruz/sparkup'
            " subdirectory
            " {
                " The sparkup vim script is in a subdirectory of this repo called vim.
                " Pass the path to set the runtimepath properly.
                " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
            " }
        " }
        " http://vim-scripts.org/vim/scripts.html
        " {
            "Plugin 'L9'
        " }
        " local file
        " {
            "Plugin 'file:///home/markus/path/to/plugin'
        " }
    " }
    call vundle#end()             " required
    filetype plugin indent on     " required
    " }

" }}}

" functions and commands {{{

    " visually select text then press ~ to convert the text to
    " UPPER CASE, then to lower case, then to Title Case. Keep pressing ~ until you get the case you want
    function! TwiddleCase(str)
      if a:str ==# toupper(a:str)
        let result = tolower(a:str)
      elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
      else
        let result = toupper(a:str)
      endif
      return result
    endfunction
    vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

    " move current tab into the specified direction.
    " @param direction -1 for left, 1 for right.
    silent function! TabMove(direction)
        " get number of tab pages
        let ntp = tabpagenr("$")
        if ntp > 1
            " get number of current tab page
            let tpnr = tabpagenr()

            " move left
            if a:direction < 1
                if tpnr == 1
                    let index = ntp
                else
                    let index=((tpnr-1+ntp-1)%ntp)
                endif
            " move right
            else
                if ntp == tpnr
                    let index = 0
                else
                    let index=(tpnr%ntp)+1
                endif
            endif

            " move tab page.
            execute "tabmove ".index
        endif
    endfunction

    " toggle wasd movement
    let wasd_on = 0
    function! ToggleWasd()
        if g:wasd_on
            nunmap w
            nunmap a
            nunmap s
            nunmap d
            nunmap e
            let g:wasd_on = 0
        else
            noremap e d
            noremap w k
            noremap a h
            noremap s j
            noremap d l
            let g:wasd_on = 1
        endif
    endfunction

    let s:fontsize = 0              " medium (-3 = xx-small, 3 = xx-large)
    silent function! SetFontsize()
        if s:fontsize == -3
            set guifont=Hack:h9
        elseif s:fontsize == -2
            set guifont=Hack:h11
        elseif s:fontsize == -1
            set guifont=Hack:h13
        elseif s:fontsize == 0
            set guifont=Hack:h15
        elseif s:fontsize == 1
            set guifont=Hack:h17
        elseif s:fontsize == 2
            set guifont=Hack:h19
        elseif s:fontsize == 3
            set guifont=Hack:h21
        elseif s:fontsize == 4
            set guifont=Hack:h23
        elseif s:fontsize == 5
            set guifont=Hack:h25
        endif
    endfunction

    silent function! IncreaseFontsize()
        if s:fontsize < 6
            let s:fontsize+=1
            call SetFontsize()
        endif
    endfunction

    silent function! DecreaseFontsize()
        if s:fontsize > -4
            let s:fontsize-=1
            call SetFontsize()
        endif
    endfunction

    silent function! NormalizeFontsize()
        let s:fontsize = 0
        call SetFontsize()
    endfunction

    " print the answer to anything
    function! Answer()
        " TODO fix bug #42
        execute "normal! G"
        r~/.vim/templates/json
        execute "normal! G"
        r~/.vim/templates/json
        execute "normal! G"
        r~/.vim/templates/json
        execute "normal! G"
    endfunction

    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return  (has('win16') || has('win32') || has('win64'))
    endfunction

    silent function! ExportMapping()
        :redir! > ~/Settings/dotfiles/vim_mappings.txt
        :silent verbose map
        :redir END
    endfunction

    " open rc-files
    :command Vimrc :tabedit ~/.vimrc<CR>
    :command Zshrc :tabedit ~/.zshrc<CR>

    " source vimrc
    :command S source $MYVIMRC

    " close all location lists
    :command CLl windo if &buftype == "quickfix" || &buftype == "locationlist" | lclose | endif

    " remove // comment lines
    :command NoComment g/^\s*\/\//d
    " pretty print json
    :command PrettyJson %!python -m json.tool

    " search and replace german html entities
    :command Umlaute %s/ü/\&uuml;/eg | :%s/ä/\&auml;/eg | :%s/ö/\&ouml;/eg | :%s/ß/\&szlig;/eg | :%s/Ü/\&Uuml;/eg | :%s/Ä/\&Auml;/eg | :%s/Ö/\&Ouml;/egI

    " search for the highlighted word with a quickfix list
    :command GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

    " abbrevations
    " {
        autocmd FileType python abbr pdb import pdb; pdb.set_trace()<esc>
        autocmd FileType python abbr ipdb from ipdb import set_trace; set_trace()<esc>
        autocmd FileType python abbr emb from IPython import embed; embed()<esc>
        autocmd FileType python abbr p_utf8 # -*- coding: utf-8 -*-<esc>o<del><esc>
        autocmd FileType python abbr p_author __author__ = "Markus Bayer"<CR><del><esc>o<del>
        abbr vimline # vim: set ft=python ts=4 sw=4 expandtab :<del><esc>
    " }
" }}}

" keymappings / keybindings {{{

    " move in text {
        " last/previous insert
        nnoremap <M-Down> g;
        nnoremap <M-Up> g,
        " move to beginning/end of line
        nnoremap B ^
        nnoremap E $

        " step in wrapped lines
        nnoremap <silent>j gj
        nnoremap <silent>k gk

        " navigate between splits
        nnoremap <Up> <C-W><C-K>
        nnoremap <Down> <C-W><C-J>
        nnoremap <Right> <C-W><C-L>
        nnoremap <Left> <C-W><C-H>
    "}

    " edit text {
        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
        " highlight last inserted text
        nnoremap gV `[v`]

        " move lines with Ctrl-J/K
        nnoremap <silent><D-j> :m .+1<CR>==
        inoremap <silent><D-j> <Esc>:m .+1<CR>==gi
        nnoremap <silent><D-k> :m .-2<CR>==
        inoremap <silent><D-k> <Esc>:m .-2<CR>==gi
        vnoremap <silent><D-k> :m '<-2<CR>gv=gv
        vnoremap <silent><D-j> :m '>+1<CR>gv=gv

        " Ctrl-j/k deletes blank line below/above
        " nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
        " nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
        " Ctrl-j/k inserts blank line below/above
        " nnoremap <silent>º :set paste<CR>m`o<Esc>``:set nopaste<CR>
        " nnoremap <silent>∆ :set paste<CR>m`O<Esc>``:set nopaste<CR>

        " delete word under cursor
        map ä viwdi
    "}

    " tab navigation {
        if has("gui_macvim")
            " in insert mode
            imap <silent><M-D-Right> <Esc><Esc><Esc> :tabnext<CR>
            imap <silent><M-D-Left> <Esc><Esc><Esc> :tabprev<CR>
            " in normal mode
            nnoremap <silent><M-D-Right> :tabnext<CR>
            nnoremap <silent><M-D-Left> :tabprev<CR>
            " press Ctrl-Tab to switch between open tabs (like browser tabs) to the right side. Ctrl-Shift-Tab goes the other way.
            imap <C-Tabt> <Esc><Esc><Esc>:tabnext<CR>
            imap <C-S-Tab> <Esc><Esc><Esc>:tabprev<CR>
            noremap <C-Tab> :tabnext<CR>
            noremap <C-S-Tab> :tabprev<CR>

            " jump to the first/last tab
            noremap <S-M-D-Right> :tabfirst<CR>
            noremap <S-M-D-Left> :tablast<CR>

            " Switch to specific tab numbers with Command-number
            noremap <D-1> :tabn 1<CR>
            noremap <D-2> :tabn 2<CR>
            noremap <D-3> :tabn 3<CR>
            noremap <D-4> :tabn 4<CR>
            noremap <D-5> :tabn 5<CR>
            noremap <D-6> :tabn 6<CR>
            noremap <D-7> :tabn 7<CR>
            noremap <D-8> :tabn 8<CR>
            noremap <D-9> :tabn 9<CR>
            " command-0 goes to the last tab
            " noremap <D-0> :tablast<CR>

            " move the focused tab
            map <C-S-Right> :call TabMove(1)<CR>
            map <C-S-Left> :call TabMove(-1)<CR>

        endif
    " }

    " increase / decrease fontsize
    map <D-+> :call IncreaseFontsize()<CR>
    map <D--> :call DecreaseFontsize()<CR>
    map <D-0> :call NormalizeFontsize()<CR>

    " leader-key
    let mapleader = "\<Space>"

    " yank filepath
    noremap <Leader>yp :let @*=expand('%:p')<CR>

    " re-call last cmd
    noremap <Leader>pc @:<CR>

    " visually select line under cursor (without $)
    map ü ^v$<Left>

    " clear highlights
    map <silent> ö :nohl<Enter>

    " splits {
        " max out the height of the current split
        "ctrl + w _

        " max out the width of the current split
        "ctrl + w |

        " normalize all split sizes, which is very handy when resizing terminal
        "ctrl + w =

        " swap top/bottom or left/right split
        "Ctrl+W R

        " break out current window into a new tabview
        "Ctrl+W T

        " close every window in the current tabview but the current one
        "Ctrl+W o
    " }

" }}}

" general {{{

    " search {
        " highlight search terms
        set hlsearch
        " find while typing
        set incsearch
        " case insensitive search
        set ignorecase
        " If the search pattern contains upper case characters, override ignorecase option.
        set smartcase
        " remove dot from keywords to asterisk search for eg app in app.config
        setlocal isk-=.
    " }

    " formatting {
        scriptencoding utf-8
        " use indents of 4 spaces
        set shiftwidth=4
        " tabs length is 4 spaces
        set tabstop=4
        " tabs are spaces, not tabs
        set expandtab
        " delete indents
        set softtabstop=4

        " enable copy-paste from system clipboard
        if has('clipboard')
            if LINUX()   " On Linux use + register for copy-paste
                set clipboard=unnamedplus
            else         " On mac and Windows, use * register for copy-paste
                set clipboard=unnamed
            endif
        endif
    " }

    set nocompatible
    if !WINDOWS()
        set shell=/bin/sh
    endif

    " visual border
    set colorcolumn=80

    " encryption-algorithm for files
    set cm=blowfish2

    " maximal amount of tabs
    set tabpagemax=50

    " open new splits to the right bottom
    set splitbelow
    set splitright

    set ssop-=options    " do not store global and local values in a session
    set ssop-=folds      " do not store folds

    " store the backup files in this location
    set backup
    set backupdir=~/.vim/backup
    set dir=~/.vim/backup//,/var/tmp//,/tmp//,.
    set writebackup

    " wd is always based on the current file
    set autochdir

    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if WINDOWS()
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif

    " extensions {
        " do not carry comments over to the next line
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o |
                    \ setlocal isk-=.

        autocmd Filetype css setlocal ts=2 sts=2 sw=2
        autocmd Filetype html setlocal ts=2 sts=2 sw=2
        autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2

        " autocmd BufNewFile,BufFilePre,BufRead,BufReadPost *.json colorscheme badwolf

        function! SetPlaintextOptions()
            " NeoCompleteEnable
            " colorscheme badwolf
        endfunction

        autocmd BufNewFile,BufFilePre,BufRead,BufReadPost *.md
                    \ set filetype=markdown |
                    \ call SetPlaintextOptions()
        autocmd BufNewFile,BufFilePre,BufRead,BufReadPost *.markdown call SetPlaintextOptions()
        autocmd BufNewFile,BufFilePre,BufRead,BufReadPost *.journal
                    \ setfiletype journal |
                    \ call SetPlaintextOptions()
        autocmd BufNewFile,BufFilePre,BufRead,BufReadPost *.tracwiki
                    \ set filetype=tracwiki |
                    \ call SetPlaintextOptions()
    " }
" }}}

" ui {{{
    " syntax highlighting
    syntax on
    syntax enable
    " highlight current line
    set cursorline

    " no blinking cursor
    set guicursor+=n-v-c:blinkon0
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    " show line numbers
    set nu
    " font size
    " set guifont=Menlo:h15
    set guifont=Hack:h15
    " Highlight problematic whitespace
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
    " enable mouse usage
    set mouse=a
    " hide mouse cursor while typing
    set whichwrap+=h,l
    set foldmethod=indent   "fold based on indent
    set foldnestmax=10      "deepest fold is 10 levels
    set nofoldenable        "dont fold by default
    set foldlevel=1         "this is just what i use
    " highlight current line
    set wildmenu
    " redraw only when we need to
    set lazyredraw

    " disable audio bell
    if has('gui_running')
        autocmd! GUIEnter * set vb t_vb=
    endif
    set noerrorbells
    set novisualbell
    set vb t_vb=
    autocmd GUIENTER,BufNewFile,BufFilePre,BufRead,BufReadPost set vb t_vb=

    " nativ indent detection
    set autoindent
    set nosmartindent
    " activate language detection
    filetype plugin indent on

    " folding
    set foldenable
    set foldmethod=marker
    set foldlevel=0

    " color {
        if has("gui_macvim")
            set background=light

            " colorscheme badwolf
            " colorscheme wolfpack
            " colorscheme dracula
            " colorscheme Spacedust
            " colorscheme inkpot
            colorscheme solarized
            " colorscheme molokai
            " colorscheme gruvbox
            " colorscheme zenburn

            " colorscheme PaperColor
            " colorscheme facebook
            " colorscheme mateial-theme
            " colorscheme pencil
            " colorscheme kalisi
            " colorscheme hemisu
            " colorscheme seoul256
            " colorscheme herald
            " colorscheme VIvid
        else
            " colorscheme neonwave
            set background=dark
            colorscheme gruvbox
        endif
    " }
" }}}

" plugin settings {{{
    " Airline
    " {
        if has('gui_running')
            let g:airline_theme = 'solarized'
        else
            let g:airline_theme = 'badwolf'
        endif
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        set laststatus=2
        set noshowmode
        let g:airline_left_sep = '»'
        let g:airline_left_sep = ''
        " let g:airline_left_sep = '▶'
        let g:airline_right_sep = '«'
        let g:airline_right_sep = ''
        " let g:airline_right_sep = '◀'
        let g:airline_symbols.linenr = '␊'
        let g:airline_symbols.linenr = '␤'
        let g:airline_symbols.linenr = '¶'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.paste = 'ρ'
        let g:airline_symbols.paste = 'Þ'
        let g:airline_symbols.paste = '∥'
        let g:airline_symbols.whitespace = 'Ξ'

        let g:airline_detect_modified = 1
        let g:airline#extensions#tagbar#enabled = 1

        " total linenr/total lines
        let g:airline_section_z = "%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#/%L:%3v"
    " }

    " YouCompleteMe {
        " let g:ycm_always_populate_location_list = 1
        " let g:ycm_min_num_of_chars_for_completion = 99
        let g:ycm_python_binary_path = '/Users/mbayer/Workspace/Envs/python2.7.5/bin/python'

        nnoremap <Leader>yg :YcmCompleter GoTo<CR>
        nnoremap <Leader>yd :YcmCompleter GoToDeclaration<CR>
        nnoremap <Leader>yr :YcmCompleter GoToReferences<CR>
        nnoremap <Leader>yD :YcmCompleter GetDoc<CR>
    " }

    " solarized
    " {
        " Set colorscheme to solarized
        " colorscheme solarized

        " Change the Solarized background to dark or light depending upon the time of
        " day (5 refers to 5AM and 17 to 5PM). Change the background only if it is not
        " already set to the value we want.
        function! SetSolarizedBackground()
            if strftime("%H") >= 5 && strftime("%H") < 17
                if &background != 'light'
                    set background=light
                endif
            else
                if &background != 'dark'
                    set background=dark
                endif
            endif
        endfunction

        " Set background on launch
        " call SetSolarizedBackground()

        " Every time you save a file, call the function to check the time and change
        " the background (if necessary).
        if has("autocmd")
            " autocmd bufwritepost * call SetSolarizedBackground()
        endif
    " }

    " NERDTRee
    " {
        let g:NERDTreeBookmarksFile = resolve(expand("~/.vim/NERDTreeBookmarks"))
        let g:nerdtree_tabs_open_on_gui_startup=0
        " ctrl ww to toggle
        map <leader>n <plug>NERDTreeTabsToggle<CR>

        if has('gui_running')
            " set NERDTree size
            let NERDTreeWinSize=20
            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1

            " always present {
                " let NERDTreeKeepTreeInNewTab=1
                " NERDTree on startup and new tab
                " autocmd vimenter * NERDTree
                " autocmd TabEnter * NERDTree

                " focus filebuffer on startup, new buffer and new tab
                " autocmd vimenter * wincmd l
                " autocmd BufNew * wincmd l
                " autocmd TabEnter * wincmd l

                " close all open buffers on entering a window if the only
                autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

                " Initialize NERDTree as needed {
                function! NERDTreeInitAsNeeded()
                    redir => bufoutput
                    buffers!
                    redir END
                    let idx = stridx(bufoutput, "NERD_tree")
                    if idx > -a
                        NERDTreeMirror
                        NERDTreeFind
                        wincmd l
                    endif
                endfunction
            " }
        endif
    " }

    " easymotion
    " {
        let g:EasyMotion_do_mapping = 0 " Disable default mappings
        let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'
        " map forward and backword easymotion to f
        nnoremap f H:call EasyMotion#WB(0, 0)<CR>
        " nmap f <Plug>(easymotion-overwin-f)
        nmap F <Plug>(easymotion-sl)
        map <Leader>j <Plug>(easymotion-j)
        map <Leader>k <Plug>(easymotion-k)


        " Bi-directional find motion
        " Jump to anywhere you want with minimal keystrokes, with just one key binding.
        " `s{char}{label}`
        " nmap s <Plug>(easymotion-s)
        " or
        " `s{char}{char}{label}`
        " Need one more keystroke, but on average, it may be more comfortable.
        " nmap s <Plug>(easymotion-s2)

        " Turn on case sensitive feature
        let g:EasyMotion_smartcase = 1

        " JK motions: Line motions
        " map <Leader>j <Plug>(easymotion-j)
        " map <Leader>k <Plug>(easymotion-k)
        " map <Leader>w <Plug>(easymotion-w)
        " map <Leader>W <Plug>(easymotion-W)
    " }

    " Gundo
    " {
        nnoremap <Leader>gu :GundoToggle<CR>
    " }


    " tabbar
    " {
        " Proper Ctags locations
        let g:tagbar_ctags_bin='/usr/local/bin/ctags'
        " jump in when opened
        let g:tagbar_autofocus = 1
        " Default is 40, seems too wide
        let g:tagbar_width=26
        " Display panel with F8
        nmap <F8> :TagbarToggle<CR>
        " autocmd BufNewFile,BufReadPost *.py let b:tagbar_ignore = 1
    " }

    " startify
    " {
        " Sessions:
        " :SLoad
        " :SSave
        " :SDelete
        let g:startify_bookmarks = [
                \ '~/.vimrc',
                \ '~/.zshrc',
                \ '~/.emacs.d/init.el'
                \ ]
        let g:startify_change_to_dir = 1
        let g:startify_change_to_vcs_root = 0
        let g:startify_custom_footer = ''
        let g:startify_custom_header = [
                \ '',
                \ '    ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄  ',
                \ '   ███    ███ ███  ▄██▀▀▀███▀▀▀██▄',
                \ '   ███    ███ ███▌ ███   ███   ███',
                \ '   ███    ███ ███▌ ███   ███   ███',
                \ '   ███    ███ ███▌ ███   ███   ███',
                \ '   ███    ███ ███  ███   ███   ███',
                \ '   ███    ███ ███  ███   ███   ███',
                \ '    ▀██████▀  █▀    ▀█   ███   █▀ ',
                \ '',
                \ '',
                \ '',
                \ ]
        let g:startify_custom_indices = []
        let g:startify_disable_at_vimenter = 0
        let g:startify_enable_special = 1
        let g:startify_files_number = 30
        let g:startify_list_order = [
                \ ['   Sessions:'],
                \ 'sessions',
                \ ['   Bookmarks:'],
                \ 'bookmarks',
                \ ['   My most recently used files'],
                \ 'files',
                \ ['   My most recently used files in the current directory:'],
                \ 'dir',
                \ ]
        let g:startify_relative_path = 0
        let g:startify_session_autoload = 0
        let g:startify_session_delete_buffers = 0
        let g:startify_session_dir = '~/.vim/session'
        let g:startify_session_persistence = 1
        let g:startify_session_savecmds = []
        let g:startify_session_savevars = [
               \ 'g:startify_session_savevars',
               \ 'g:startify_session_savecmds',
               \ 'g:random_plugin_use_feature'
               \ ]
        let g:startify_skiplist_server = []
        let g:startify_skiplist = []
    " }

    " YankRing
    " {
        nnoremap <silent> <F7> :YRShow<CR>
    " }

    " calendar.vim
    " {
        let g:calendar_google_calendar = 1
    " }

    " expand-region
    " {
        map + <Plug>(expand_region_expand)
        map - <Plug>(expand_region_shrink)
    " }

    " Rainbow {
        let g:rainbow_active = 0  " 0 if you want to enable it later via :RainbowToggle
    " }

    " MatchTagAlways {
        nnoremap <leader>% :MtaJumpToOtherTag<cr>
    " }

    " Unite {
        " let g:unite_prompt='» '
        " " yank history
        " let g:unite_source_history_yank_enable = 1
        " let g:unite_source_history_yank_file = resolve(expand('~/.vim/unite_yank_history.txt'))
        " let g:neomru#file_mru_path = resolve(expand('~/.vim/unite_mru_files.txt'))
        "
        " let g:unite_source_rec_git_command = ['git', 'rev-parse', '--show-toplevel']
        " let g:unite_source_rec_git_command = ['git', 'ls-tree', '-r', '--name-only', 'HEAD']
        " " let g:unite_source_rec_max_cache_files = 250000
        " let g:unite_source_file_rec_max_cache_files = 0
        " " call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate',
        " "             \ 'max_candidates', 0)
        "
        " if executable('ag')
        "     " Use ag in unite grep source.
        "     let g:unite_source_grep_command = 'ag'
        "     let g:unite_source_rec_async_command= ['ag', '--nocolor', '--nogroup', '--hidden', '-g', '""']
        "     let g:unite_source_grep_default_opts =
        "         \ '-i --vimgrep --hidden --ignore bower_components --ignore ' .
        "         \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        "     let g:unite_source_grep_recursive_opt = ''
        " endif
        "
        " " aliases
        " let g:unite_source_alias_aliases = {
        "         \       'db': {
        "         \           'source': 'file_rec/async',
        "         \           'args': '~/Dropbox',
        "         \       },
        "         \       'b' : 'buffer',
        "         \   }

        function! GitGrep()
            " grep the git repository the current file belongs to
            " -path?
            :cd `git rev-parse --show-toplevel`
            :Unite -start-insert -tab grep:.
            :cd -
        endfunction

        function! GitFind()
            " find files within the git repository
            " -path?
            :cd `git rev-parse --show-toplevel`
            :Unite -start-insert -tab file_rec -force-redraw
            :cd -
        endfunction

        nnoremap <Leader>gg :call GitGrep()<CR>
        nnoremap <Leader>gf :call GitFind()<CR>
        " nnoremap <Leader>g :Unite -start-insert -tab file_rec/git<CR>
        nnoremap <Leader>f :Unite -start-insert -tab file_rec<CR>
        nnoremap <Leader>t :Unite -start-insert tab<CR>
        nnoremap <Leader>g. :Unite -start-insert -tab grep:.<CR>
        nnoremap <Leader>tg :Unite -start-insert -tab grep:$buffers<CR>
        nnoremap <Leader>mr :Unite -start-insert -tab file_mru<CR>
        nnoremap <Leader>y :Unite -tab history/yank<cr>
        nnoremap <Leader>h :Unite -tab -unique history/unite<cr>
        nnoremap <Leader>o :Unite -start-insert -preview outline<cr>
        nnoremap <Leader>jl :Unite jump<cr>
        nnoremap <Leader>c :Unite change<cr>

        " map <buffer> <C-1> <Plug>(unite_redraw)     " <C-l>

        " imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        " imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    " }

    " ScreenSaver {
        nnoremap <Leader>ss :ScreenSaver largeclock<CR>
    " }

    " Syntastic {
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let syntastic_loc_list_height = 5
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    " }

    " Surround {
        vmap <silent><Leader>s" <S-S>"
        vmap <silent><Leader>s' <S-S>'
        vmap <silent><Leader>s( <S-S>)
        vmap <silent><Leader>s[ <S-S>]
        vmap <silent><Leader>s{ <S-S>{
        " combine with expand-region
        map <silent><Leader>" <Plug>(expand_region_expand)<S-S>"
        map <silent><Leader>' <Plug>(expand_region_expand)<S-S>'
        map <silent><Leader>( <Plug>(expand_region_expand)<S-S>)
        map <silent><Leader>{ <Plug>(expand_region_expand)<S-S>{
        map <silent><Leader>[ <Plug>(expand_region_expand)<S-S>]
    "}

    " CSApprox {
        let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
    "}

" }}}
