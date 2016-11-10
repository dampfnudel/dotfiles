(package-initialize)
(require 'package)
(require 'cl)
(setq package-enable-at-startup nil)

(setq package-archives
        '(("gnu" . "http://elpa.gnu.org/packages/")
         ("org" . "http://orgmode.org/elpa/")
         ("melpa" . "https://melpa.org/packages/")
         ("melpa-stable" . "https://stable.melpa.org/packages/")))

;; (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(defun package-upgrade ()
    (interactive)
    (let* ((packages
            '(auto-compile              ; automatically compile Emacs Lisp libraries
                evil                    ; extensible vi layer
                evil-leader             ; the <leader> feature from Vim
                evil-search-highlight-persist             ; highlight the search term in all buffers persistently
                evil-nerd-commenter     ; comment code efficiently
                helm                    ; Incremental and narrowing framework
                expand-region           ; Increases the selected region by semantic units
                yasnippet               ; template system
                flycheck                ; modern on-the-fly syntax checking extension
                git-gutter              ; icons in the gutter area indicating src ctrl changes
                undo-tree               ; undo system
                ;; auto-complete           ; auto completion with popup menu
                company                 ; auto completion with popup menu
                helm-c-yasnippet        ; helm completion for company-mode
                json-snatcher           ; extract the path to a json value, display at modeline
                fireplace               ; a cozy fireplace
                jedi                    ; Python auto-completion for Emacs
                idle-require            ; load elisp libraries while Emacs is idle
                avy                     ; jumping to visible text using a char-based decision tree
                restclient              ; tool to manually explore and test HTTP REST webservices
                js2-mode                ; Improved JavaScript editing mode
                web-mode                ; major mode for editing web templates aka HTML files
                dumb-jump               ; "jump to definition" with support for multiple programming languages
                helm-swoop              ; Efficiently hopping squeezed lines
                smartparens             ; minor mode for dealing with pairs
                which-key               ; minor mode for Emacs that displays the key bindings following your currently entered incomplete command (a prefix) in a popup
                helm-projectile         ; Helm integration for Projectile
                magit                   ; control Git from Emacs
                spaceline               ; Spacemacs powerline theme
                workgroups2             ; session manager
                howdoi                  ; query Stack Overflow, get the most upvoted answer to the first question
                markdown-mode           ; major mode for editing markdown
                ;; smart-mode-line         ; sexy mode-line
                ;; smart-mode-line-powerline-theme
                ;; new package
                ;; themes
                gruvbox-theme           ; light & dark
                solarized-theme         ; light & dark
                spacemacs-theme         ; light & dark
                moe-theme               ; light & dark
                material-theme          ; light & dark
                color-theme-sanityinc-tomorrow ; light & dark
                darcula-theme           ; dark
                leuven-theme            ; light
                organic-green-theme     ; light
                monokai-theme           ; dark
                zenburn-theme           ; dark
                cyberpunk-theme         ; dark
                subatomic-theme         ; dark
                grandshell-theme        ; dark
                afternoon-theme         ; dark
                noctilux-theme          ; dark
                darktooth-theme         ; dark
                gotham-theme            ; dark
                doom-themes             ; light & dark
                spacegray-theme         ; dark
                obsidian-theme          ; dark
                metalheart-theme        ; dark
                badwolf-theme           ; light & dark
                inkpot-theme            ; dark
                seoul256-theme          ; dark
                suscolors-theme         ; dark
                avk-emacs-themes        ; collection
                quasi-monochrome-theme  ; dark
                hemisu-theme            ; light & dark
                cherry-blossom-theme    ; theme
                darkburn-theme          ; dark
                clues-theme             ; dark
                reykjavik-theme         ; dark
                sublime-themes          ; collection
                silkworm-theme          ; dark
                labburn-theme           ; dark
                org                     ; Outline-based notes management and organizer
                org-autolist            ; Automatically insert new list items.
                ;; always load finally
                ox-rst                  ; Export reStructuredText
                ox-odt                  ; Export OpenDocument
                ox-md                   ; Markdown exporter (from org)
                ;; cider                ; Clojure Interactive Development Environment
                ;; company              ; Modular text completion framework
                ;; define-word          ; display the definition of word at point
                ;; diminish             ; Diminished modes from modeline
                ;; drag-stuff           ; Drag stuff around in Emacs
                ;; expand-region        ; Increase selected region by semantic units
                ;; focus                ; Dim color of text in surrounding sections
                ;; geiser               ; GNU Emacs and Scheme talk to each other
                ;; git-gutter-fringe    ; Fringe version of git-gutter.el
                ;; golden-ratio         ; Automatic resizing windows to golden ratio
                ;; haskell-mode         ; A Haskell editing mode
                ;; helm-company         ; Helm interface for company-mode
                ;; maude-mode           ; Emacs mode for the programming language Maude
                ;; multiple-cursors     ; Multiple cursors for Emacs
                ;; olivetti             ; Minor mode for a nice writing environment
                ;; paredit              ; minor mode for editing parentheses
                ;; pdf-tools            ; Emacs support library for PDF files
                ;; projectile           ; Manage and navigate projects in Emacs easily
                ;; slime                ; Superior Lisp Interaction Mode for Emacs
                ;; try))                ; Try out Emacs packages
                ))
            ;; Remove all packages already installed
            (packages (remove-if 'package-installed-p packages)))
        ;; TODO only connect if neccessary
        (when packages
            (ignore-errors (package-refresh-contents)
                        (mapcar 'package-install packages)
                        ;; macOS
                        (when (memq window-system '(mac ns))
                            (package-install 'exec-path-from-shell))))))

(defun tangle-init ()
"If the current buffer is 'init.org' the code-blocks are tangled, and
the tangled file is compiled."
(when (equal (buffer-file-name)
    (expand-file-name "~/Settings/dotfiles/emacsrc.org"))
    ;; avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
    (org-babel-tangle)
    (byte-compile-file (expand-file-name
        (concat user-emacs-directory "init.el"))))))

(add-hook 'after-save-hook 'tangle-init)

(add-to-list 'load-path (expand-file-name
    (concat user-emacs-directory "other-srcs/lisp")))

;; theme
;; trust theme
(setq custom-safe-themes t)
;; (load-theme 'spacemacs-dark)
;; (load-theme 'reykjavik)
(load-theme 'darcula)
(load-theme 'monokai)
;; (load-theme 'darktooth)
;; set font
(set-default-font "Envy Code R 16")

;; disable blinking cursor
(blink-cursor-mode 0)
;; disable audio bell
(setq ring-bell-function 'ignore)
;; remember cursor position
(if (version< emacs-version "25.0")
    (progn
        (require 'saveplace)
  (setq-default save-place t))
  (setq save-place-file (concat user-emacs-directory "persistence/places"))
  (save-place-mode 1))

;; disable welcome window
(setq ns-pop-up-frames nil)

;; disable tool-bar
(tool-bar-mode -1)

;; show line numbers
(global-linum-mode t)

;; y & n instead of yes & no
(fset 'yes-or-no-p 'y-or-n-p)

;; 80-column-ruler
(add-to-list 'load-path (expand-file-name
    (concat user-emacs-directory "other-srcs/Fill-Column-Indicator")))
(require 'fill-column-indicator)

;; TODO define list of used programming languages (prog-mode doesn't work with js)
(add-hook 'python-mode-hook 'turn-on-fci-mode)
(add-hook 'js-mode-hook 'turn-on-fci-mode)

;; highlight current line
(global-hl-line-mode)

;; wrap long lines
(global-visual-line-mode)

;; start fullscreen
;(toggle-frame-maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; display column number
(setq column-number-mode t)

;; switch frames with <Shift-Left/Right/Up/Down>
(windmove-default-keybindings)

(setq-default indent-tabs-mode nil)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
;;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; (setq indent-line-function 'insert-tab)

(set-language-environment "UTF-8")

(show-paren-mode 1)
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#FF0097")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; paths
(setq auto-save-file-name-transforms
          `((".*" ,(concat user-emacs-directory "tmp/auto-save/") t)))
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "tmp/backup")))))
;; backup method
(setq backup-by-copying t)
;; backup frequency
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; TODO shebangs, doesn't work
(add-to-list 'magic-mode-alist '("# vim: set ft=zsh ts=4 sw=4 expandtab :" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))

;; persist bookmarks in this file
(setq bookmark-default-file (concat user-emacs-directory "persistence/bookmarks"))

;; required by require
(defun zone-choose (pgm)
    "Choose a PGM to run for `zone'."
    (interactive
        (list
        (completing-read
        "Program: "
        (mapcar 'symbol-name zone-programs))))
    (let ((zone-programs (list (intern pgm))))
        (zone)))

(require 'evil-leader)
(global-evil-leader-mode)
;; set space as leader-key
(evil-leader/set-leader "<SPC>")

;; use evil search instead of isearch
(setq evil-search-module 'evil-search)
(require 'evil)
(evil-mode 1)
;; let evil treat _ as part of a word
(setq-default evil-symbol-word-search t)

;; org-mode for .org-files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; required by require
(setq org-log-done t)
;; setup priorities from A-Z
(setq org-highest-priority ?A)
(setq org-lowest-priority ?Z)
(setq org-default-priority ?A)
;; concat agenda from this files
(setq org-agenda-files (append '("~/.notes.org" "~/Documents/org/plan/backlog.org") (file-expand-wildcards "~/Documents/org/cal/*\.org")))

;; indentation options
(setq org-startup-folded "showeverything")
;; In this minor mode, all lines are prefixed for display with the necessary amount of space.
;; All headline stars but the last one are made invisible
(add-hook 'org-mode-hook
          (lambda () (org-indent-mode t)) t)

;; initial langauges for org-babel support
(org-babel-do-load-languages
    'org-babel-load-languages '(
        (sh . t)
        (python . t)
        (ruby . t)
        (sqlite . t)
        (java . t)
        (js . t)
        (sql . t)
        (css . t)
))

;; automatically insert list items
;; required by require
(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

(require 'helm-config)
;; TODO experimental
(setq helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

;; TODO only init for src files
;; required by require
(add-hook 'after-init-hook #'global-flycheck-mode)
;; TODO customize error window

;; required by require
;; snippet direcories
(setq yas-snippet-dirs
         '("~/.emacs.d/user-snippets"
         ))
;; yasnippet everywhere
(yas-global-mode 1)

;; required by require
(global-git-gutter-mode +1)
; live update
(custom-set-variables
    '(git-gutter:update-interval 1)
    '(git-gutter:modified-sign "~")
    ; '(git-gutter:added-sign "+")
    ; '(git-gutter:deleted-sign "-")
)

;; required by require
(global-undo-tree-mode)

(add-hook 'after-init-hook 'global-company-mode)

;; ;; Add yasnippet support for all company backends
;; ;; https://github.com/syl20bnr/spacemacs/pull/179
;; (defvar company-mode/enable-yas t
;;   "Enable yasnippet for all backends.")
;;
;; (defun company-mode/backend-with-yas (backend)
;;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;;       backend
;;     (append (if (consp backend) backend (list backend))
;;             '(:with company-yasnippet))))
;;
;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; (require 'auto-complete)
;; ;; TODO deactivate for minibuffer
;; (global-auto-complete-mode t)
;; (ac-config-default)
;; (setq ac-sources (append '(ac-source-yasnippet) ac-sources))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; required by require
(defun js-mode-bindings ()
"Sets a hotkey for using the json-snatcher plugin"
    (when (string-match  "\\.json$" (buffer-name))
        ;;; TODO map @ mappings
    (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
(add-hook 'js-mode-hook 'js-mode-bindings)
(add-hook 'js2-mode-hook 'js-mode-bindings)

(add-to-list 'load-path (expand-file-name
    (concat user-emacs-directory "other-srcs/nyan-mode")))
(require 'nyan-mode)
(nyan-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; TODO test indentation
(custom-set-variables
 '(js2-basic-offset 4)
 '(js2-bounce-indent-p t)
)

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(require 'smartparens-config)
(add-hook 'js-mode-hook #'smartparens-mode)
(add-hook 'python-mode-hook #'smartparens-mode)

(require 'which-key)
(which-key-mode)

(require 'spaceline-config)
(spaceline-spacemacs-theme)

;; TODO requrie
(require 'highlight)
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)

;; TODO set highlight color
;; https://github.com/juanjux/evil-search-highlight-persist/issues/1
;; (defface evil-search-highlight-persist-highlight-face
;;   '((((class color))
;;      (:background "turquoise")))
;;   "Face for the highlighted text."
;;   :group 'evil-search-highlight-persist)

(require 'workgroups2)
;; change workgroups session file
(setq wg-session-file (concat user-emacs-directory "persistence/workgroups"))
;; load it on startup
(workgroups-mode 1)
(wg-find-session-file (concat user-emacs-directory "persistence/workgroups"))

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 50)
;; set file location
(setq recentf-save-file (expand-file-name
    (concat user-emacs-directory "persistence/recentf")))

(setq helm-howdoi
  '((name . "howdoi google")
    (candidates . (lambda ()
                    (funcall helm-google-suggest-default-function)))
    (action . (("howdoi" . howdoi-query)))
    (volatile)
    (requires-pattern . 3)
    (delayed)))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))



(require 'idle-require)             ; Needed in order to use idle-require

(dolist (feature
         '(auto-compile             ; auto-compile .el files
           jedi                     ; auto-completion for python
           zone
           expand-region
           fireplace
           json-snatcher
           undo-tree
           yasnippet
           helm-c-yasnippet
           ;; auto-complete-config
           git-gutter
           org-mode
           org-autolist
           ;; always load finally
           ox-rst
           ox-odt
           ox-md                       ; Markdown exporter (from org)
           ;; matlab                   ; matlab-mode
           ;; ob-matlab                ; org-babel matlab
           ;; ox-latex                 ; the latex-exporter (from org)
           ;; recentf                  ; recently opened files
           ;; tex-mode))               ; TeX, LaTeX, and SliTeX mode commands
           ))
  (idle-require feature))

(setq idle-require-idle-delay 5)
(idle-require-mode 1)

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun src-init ()
    (interactive)
    (load-file (concat user-emacs-directory "init.el")))

(defun helm-howdoi ()
    (interactive)
    (helm :sources 'helm-howdoi))



;; minor mode for keybindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-e") 'move-end-of-line)
    (define-key map (kbd "M-b") 'move-beginning-of-line)
    ;; macOS
    (define-key map (kbd "M-q") 'save-buffers-kill-terminal)        ; quit
    (define-key map (kbd "M-w") 'kill-buffer)                       ; close
    (define-key map (kbd "M-c") 'kill-ring-save)                    ; copy
    (define-key map (kbd "M-v") 'yank)                              ; paste
    (define-key map (kbd "M-s") 'save-buffer)                       ; save
    (define-key map (kbd "M-a") 'mark-whole-buffer)                 ; select all
    (define-key map (kbd "M-x") 'helm-M-x)
    (define-key map (kbd "\C-cl") 'org-store-link)
    (define-key map (kbd "\C-ca") 'org-agenda)
    (define-key map (kbd "C-+") 'er/expand-region)
    ;; TOOD Backspace?
    (define-key map (kbd "DEL") 'backward-delete-char)
    (define-key map (kbd "C--") 'evilnc-comment-or-uncomment-lines)

    ;; evil keymappings
    ;; normal state
    (define-key evil-normal-state-map (kbd "M-o") 'helm-find-files)
    (define-key evil-normal-state-map (kbd "M-b") 'helm-buffers-list)
    (define-key evil-normal-state-map (kbd "+") 'er/expand-region)
    (define-key evil-normal-state-map (kbd "f") 'ace-jump-mode)
    (define-key evil-normal-state-map (kbd "B") 'evil-first-non-blank)
    (define-key evil-normal-state-map (kbd "E") 'evil-end-of-line)
    (define-key evil-normal-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)
    (define-key evil-normal-state-map (kbd "ä") 'delete-other-windows)
    (define-key evil-normal-state-map (kbd "Ä") 'evil-search-highlight-persist-remove-all)
    (define-key evil-normal-state-map (kbd "ö") 'avy-goto-char)
    (define-key evil-normal-state-map (kbd "Ö") 'avy-goto-line)
    (define-key evil-normal-state-map (kbd "f") 'avy-goto-char-in-line)
    (define-key evil-normal-state-map (kbd "C-j") 'scroll-up-command)
    (define-key evil-normal-state-map (kbd "C-k") 'scroll-down-command)

    ;; visual line
    (define-key evil-visual-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)
    ; Overload shifts so that they don't lose the selection
    (define-key evil-visual-state-map (kbd ">") 'evil-shift-right-visual)
    (define-key evil-visual-state-map (kbd "<") 'evil-shift-left-visual)
    (define-key evil-visual-state-map [tab] 'evil-shift-right-visual)
    (define-key evil-visual-state-map [S-tab] 'evil-shift-left-visual)

    ;; evil-leader mappings
    (evil-leader/set-key
    "k" 'evil-window-up
    "j" 'evil-window-down
    "h" 'evil-window-left
    "l" 'evil-window-right
    "x" 'delete-other-windows    ; duplicated
    "y" 'helm-yas-complete
    "f" 'helm-for-files
    "O" 'helm-find-files
    "oh" 'helm-org-in-buffer-headings
    "oa" 'helm-org-agenda-files-headings
    "oc" 'org-reset-checkbox-state-subtre
    "SPC" 'helm-buffers-list
    "B" 'bookmark-set
    "TAB" 'mode-line-other-buffer               ; previous buffer (like 'helm-buffer-list "RET")
    "d" 'dumb-jump-go
    "*" 'helm-swoop
    "ö" 'evil-search-highlight-persist-remove-all        ; duplicated
    "l" 'helm-semantic-or-imenu
    "p" 'helm-projectile
    "m" 'magit-status
    "ss" 'wg-save-session
    "so" 'wg-open-session
    "sc" 'wg-save-session-as
    "S" 'src-init
    "c" 'shell-command
    "Hh" 'helm-howdoi
    "Hi" 'howdoi-query-insert-code-snippet-at-point
    "t" (lambda () (interactive) (evil-ex "%s /foo/bar/g"))
    "w/" 'find-file-other-window)

    ;; macOS
    ;; map command key to meta
    (if (boundp 'ns-command-modifier)
        (setq ns-command-modifier 'meta))
    (if (boundp 'ns-option-modifier)
        (setq ns-option-modifier nil))

    ;; make use of <Meta-Up> <Meta-Down>
    ;; TODO double mapped
    (define-key input-decode-map "\e\eOA" [(meta up)])
    (define-key input-decode-map "\e\eOB" [(meta down)])
    (global-set-key [(meta up)] 'scroll-down-command)
    (global-set-key [(meta down)] 'scroll-up-command)

    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)


;; (template insertion
;; TODO use yasnippet
(defun insert-org-checkbox ()
  (interactive)
  (insert "- [ ] "))
(global-set-key (kbd "M--") 'insert-checkbox)

(defun insert-org-minimal-theme ()
  (interactive)
    (insert "#+SETUPFILE: ~/Settings/dotfiles/org-minimal-theme.setup"))

(defun insert-org-title ()
  (interactive)
  (insert "#+TITLE: "))

(defun insert-src ()
  (interactive)
  (insert "#+BEGIN_SRC emacs-lisp\n\n#+END_SRC"))
