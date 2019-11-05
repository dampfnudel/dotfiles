# general

## use the system clipboard
set clipboard+=unnamed
## disable timeout for key sequences
set notimeout

## vim-surround
set surround

# search

## highlight hits
set hlsearch
## case insensitive until the use of uppercase letters in the pattern
set smartcase
set ignorecase
set incsearch

# keymappings / keybindings

## remappings
map # :action FindUsages <CR>
map B ^
# map f F
map E $
# nnoremap E $
# nnoremap $ :action EditorMatchBrace <CR>

# in current file
map ö /
map Ö :action FileStructurePopup <CR>
map ge :action GotoNextError <CR>

# in current project
map ä :action RecentFiles <CR>
map Ä :action FindInPath <CR>

# map ü :action SelectIn <CR>
map ü :action VimReformatVisual <CR>
map Ü :action Refactorings.QuickListPopupAction <CR>

map ß :action InsertLiveTemplate <CR>

# map <Space><Space> :action SearchEverywhere <CR>

## mappings

### edit
map ~ :action EditorToggleCase <CR>
map + :action EditorSelectWord <CR>
map - :action EditorUnSelectWord <CR>

### goto
map <Space> :action MethodDown <CR>
map <Shift><Up> :action MethodUp <CR>
map <Shift><Down> :action MethodDown <CR>
# map <Space>f :action FindInPath <CR>
map gf :action Forward <CR>
map gb :action Back <CR>
map gd :action GotoDeclaration <CR>
map gu :action FindUsages <CR>
map gfj :action MethodDown <CR>
map gfk :action MethodUp <CR>
map g; :action JumpToLastChange <CR>
map gn :action JumpToNextChange <CR>

### splits
#map | :action SplitVertically <CR>
map <Space>l :action NextSplitter <CR>
map <Shift><Right> :action NextSplitter <CR>
map <Space>h :action PrevSplitter <CR>
map <Shift><Left> :action PrevSplitter <CR>
map <Space>x :action Unsplit <CR>

## delete
## change last word in line
map <Space>cl Ebcw
## change from = to $
map <Space>c= Bf=wC <Del>

# emacsIDEs
# map f :action emacsIDEAs.AceJump <CR>