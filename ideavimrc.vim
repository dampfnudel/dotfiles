# general

## use the system clipboard
set clipboard+=unnamed
## disable timeout for key sequences
set notimeout

# search

## highlight hits
set hlsearch
## case insensitive until the use of uppercase letters in the pattern
set smartcase
set ignorecase
set incsearch

# keymappings / keybindings

## remappings
map E $
map B ^
map ö /
map Ö :action FileStructurePopup <CR>
map ä :action FindInPath <CR>
map Ä :action SelectIn <CR>
map # :action FindUsages <CR>
map ü :action Refactorings.QuickListPopupAction <CR>
# map <Space><Space> :action SearchEverywhere <CR>

## mappings

### edit
map ~ :action EditorToggleCase <CR>
map + :action EditorSelectWord <CR>
map - :action EditorUnSelectWord <CR>

### goto
# map <Space>f :action FindInPath <CR>
map gf :action Forward <CR>
map gb :action Back <CR>
map gd :action GotoDeclaration <CR>
map gu :action FindUsages <CR>
map gfn :action MethodDown <CR>
map gfp :action MethodUp <CR>
map g; :action JumpToLastChange <CR>

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
