--[[ DeepLTranslate
https://www.hammerspoon.org/Spoons/DeepLTranslate.html
Show a popup window with the translation of the currently selected text
--]]
DeeplTranslate = hs.loadSpoon('DeepLTranslate')
DeeplTranslate:bindHotkeys({translate = { { "alt", "cmd" }, "T" },})

--[[ Commander
https://www.hammerspoon.org/Spoons/Commander.html
This spoon lets execute commands from other spoon by a chooser.
--]]
Commander = hs.loadSpoon('Commander')
hs.hotkey.bind({ "alt", "cmd" }, "C", function()
  Commander:show()
end)

--[[ KSheet
https://www.hammerspoon.org/Spoons/KSheet.html
Keybindings cheatsheet for current application
--]]
KSheet = hs.loadSpoon('KSheet')
hs.hotkey.bind({ "alt", "cmd" }, "H", function()
  KSheet:show()
end)
hs.hotkey.bind({ "alt", "cmd", "shift" }, "H", function()
  KSheet:hide()
end)


--[[ Caffeine
https://www.hammerspoon.org/Spoons/Caffeine.html
Prevent the screen from going to sleep
Shows a cup in the menubar when active
--]]
Caffeine = hs.loadSpoon('Caffeine')
hs.hotkey.bind({ "alt", "cmd" }, "S", function()
  Caffeine:start()
end)
hs.hotkey.bind({ "alt", "cmd", "shift" }, "S", function()
  Caffeine:stop()
end)
