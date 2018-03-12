# general

## use the system clipboard
set clipboard+=unnamed

# search

## highlight hits
set hlsearch
## case insensitive until the use of uppercase letters in the pattern
set smartcase
set ignorecase

# keymappings / keybindings

## remappings
map E $
map B ^
map ö /
map ä *
map <Space>g *
map <Space><Tab> :action SearchEverywhere <CR> foooo
map <Space><Space> :action SearchEverywhere <CR>

## mappings

### edit
map <Space>- :action CommentByLineComment <CR>
map <Space>. :action CommentByBlockComment <CR>
map <Space>r :action RenameElement <CR>
map ~ :action EditorToggleCase <CR>

### goto
map <Space>f :action FindInPath <CR>
map gs :action SelectIn <CR>
map gf :action Forward <CR>
map gb :action Back <CR>
map <Space><Tab> :action Back <CR>
map gd :action GotoDeclaration <CR>
map gfn :action MethodDown <CR>
map gfp :action MethodUp <CR>
map g; :action JumpToLastChange <CR>

### splits
map <Space>| :action SplitVertically <CR>
map <Space>l :action NextSplitter <CR>
map <Shift><Right> :action NextSplitter <CR>
map <Space>h :action PrevSplitter <CR>
map <Shift><Left> :action PrevSplitter <CR>
map <Space>x :action Unsplit <CR>