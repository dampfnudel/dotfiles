(package-initialize)
(require 'package)
(require 'cl)
(setq package-enable-at-startup nil)

(setq package-archives
        '(("gnu" . "http://elpa.gnu.org/packages/")
         ("org" . "http://orgmode.org/elpa/")
         ("melpa" . "https://melpa.org/packages/")
         ("melpa-stable" . "https://stable.melpa.org/packages/")
         ("melpa-milkbox-stable" . "http://melpa-stable.milkbox.net/packages/")
         ; ("elpy" . "https://jorgenschaefer.github.io/packages/")
))

;; (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(defun package-install-from-ini ()
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
                company                 ; auto completion with popup menu
                helm-c-yasnippet        ; helm completion for company-mode
                json-snatcher           ; extract the path to a json value, display at modeline
                fireplace               ; a cozy fireplace
                idle-require            ; load elisp libraries while Emacs is idle
                avy                     ; jumping to visible text using a char-based decision tree
                restclient              ; tool to manually explore and test HTTP REST webservices
                js2-mode                ; Improved JavaScript editing mode
                web-mode                ; major mode for editing web templates aka HTML files
                dumb-jump               ; "jump to definition" with support for multiple programming languages
                helm-swoop              ; Efficiently hopping squeezed lines
                smartparens             ; minor mode for dealing with pairs
                which-key               ; displays the key bindings following your currently entered incomplete command (a prefix) in a popup
                helm-projectile         ; Helm integration for Projectile
                magit                   ; control Git from Emacs
                spaceline               ; Spacemacs powerline theme
                workgroups2             ; session manager
                howdoi                  ; query Stack Overflow, get the most upvoted answer to the first question
                markdown-mode           ; major mode for editing markdown
                helm-ag                 ; use ag with helm
                focus                   ; Focus provides focus-mode that dims the text of surrounding sections
                anaconda-mode           ; Code navigation, documentation lookup and completion for Python
                company-anaconda        ; Anaconda backend for company-mode
                skewer-mode             ; Live web development
                company-tern            ; Tern backend for company-mode.
                org-trello              ; 2-way sync org & trello
                vue-mode                ; major mode for vue.js
                ;; new package
                ;; themes
                rebecca-theme           ; dark
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
                ; try))                ; Try out Emacs packages
                ))
            ;; Remove all packages already installed
            (packages (remove-if 'package-installed-p packages)))
        ;; TODO only connect if neccessary
        (when packages
            (ignore-errors (package-refresh-contents)
                        (mapc 'package-install packages)
                        ;; macOS
                        (when (memq window-system '(mac ns))
                            (package-install 'exec-path-from-shell))))))

(defun tangle-init-emacs ()
"If the current buffer is 'emacsrc.org' the code-blocks are tangled, and
the tangled file is compiled."
(when (equal (buffer-file-name)
    (expand-file-name "~/Settings/dotfiles/emacsrc.org"))
    ;; avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
    (org-babel-tangle)
    (byte-compile-file (expand-file-name "~/Settings/dotfiles/emacsrc.el")))))

(add-hook 'after-save-hook 'tangle-init-emacs)

(add-to-list 'load-path (expand-file-name
    (concat user-emacs-directory "other-srcs/lisp")))

;; TODO
;; theme
;; trust theme
(setq custom-safe-themes t)
;; (load-theme 'labburn)
;; (load-theme 'material-light)
;; (load-theme 'spacemacs-dark)
;; (load-theme 'spacemacs-light)
;; (load-theme 'rebecca)
;; (load-theme 'reykjavik)
;; (load-theme 'darcula)
;; (load-theme 'monokai)
;; (load-theme 'sanityinc-tomorrow-blue)
;; (load-theme 'darktooth)
(load-theme 'doom-nova)
;; (load-theme 'avk-darkblue-yellow)
;; set font
(set-frame-font "Envy Code R 16")

;; follow symbolic links
;; (setq vc-follow-symlinks t)

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

;; slows down emacs
;; show line numbers
(global-linum-mode -1)
(line-number-mode -1)

;; y & n instead of yes & no
(fset 'yes-or-no-p 'y-or-n-p)

; #slowemacs
;; 80-column-ruler
;; (add-to-list 'load-path (expand-file-name
;;     (concat user-emacs-directory "other-srcs/Fill-Column-Indicator")))
;; (setq fci-rule-column 81)
;; (require 'fill-column-indicator)
;; 
;; (setq-default fill-column 80)
;; (setq-default auto-fill-function 'do-auto-fill)
;; 
;; ;; TODO define list of used programming languages (prog-mode doesn't work with js)
;; (add-hook 'python-mode-hook 'turn-on-fci-mode)
;; (add-hook 'js-mode-hook 'turn-on-fci-mode)
;; 
;; ;; highlight current line
;; (global-hl-line-mode)
;; ;; disable hl-line-mode slows down emacs in certain modes
;; ;; M-x cutomize-themes
;; (add-hook 'special-mode-hook (lambda () (hl-line-mode -1)))
;; ;; M-x package-list-packages
;; (add-hook 'package-menu-mode-hook (lambda () (hl-line-mode -1)))
;; ;; magit
;; (add-hook 'magit-mode-hook (lambda () (global-hl-line-mode -1)))
; https://stackoverflow.com/questions/6837511/automatically-disable-a-global-minor-mode-for-a-specific-major-mode
;(define-global-minor-mode my-global-centered-cursor-mode global-undo-tree-mode
;  (lambda ()
;    (when (not (memq major-mode
;                     (list 'fireplace-mode)))
;      (global-undo-tree-mode))))
;
;(my-global-centered-cursor-mode 1)


; #slowemacs
;; wrap long lines
;;(global-visual-line-mode)
;(set-default 'truncate-lines t)

;; start fullscreen
;(toggle-frame-maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; slows down emacs
;; display column number
;; (setq column-number-mode t)

;; switch frames with <Shift-Left/Right/Up/Down>
(windmove-default-keybindings)

(setq-default indent-tabs-mode nil)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; (setq indent-line-function 'insert-tab)

(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(show-paren-mode 1)
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#FF0097")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)
(electric-pair-mode)

;; paths
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; (setq auto-save-file-name-transforms
;;           `((".*" ,(concat user-emacs-directory "tmp/auto-save/") t)))
;; (setq backup-directory-alist
;;       `(("." . ,(expand-file-name
;;                  (concat user-emacs-directory "tmp/backup/")))))
;; ;; backup method
;; (setq backup-by-copying t)
;; ;; backup frequency
;; (setq delete-old-versions t
;;   kept-new-versions 6
;;   kept-old-versions 2
;;   version-control t)

;; ;;TOTRY
;; ;;(setq savehist-file "~/.emacs.d/savehist")
;;(savehist-mode 1)
;;(setq history-length t)
;;(setq history-delete-duplicates t)
;;(setq savehist-save-minibuffer-history 1)
;;(setq savehist-additional-variables
;;'(kill-ring
;;    search-ring
;;    regexp-search-ring))

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
; #slowemacs
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; required by require
(setq org-log-done t)
;; setup priorities from A-Z
(setq org-highest-priority ?A)
(setq org-lowest-priority ?G)
(setq org-default-priority ?A)
;; define states
(setq org-todo-keywords
       '((sequence "TODO" "NEXT" "BLOCKED" "|" "DONE" "FAILED")))
;; concat agenda from this files
(setq org-agenda-files (append '("~/Documents/org/agenda.gpg" "~/Documents/org/wiederkehrende-tasks.org")))
;; (setq org-agenda-files (append '("~/Documents/org/agenda.gpg" "~/Documents/org/wiederkehrende-tasks.org") (file-expand-wildcards "~/Documents/org/cal/*\.org")))

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

;; org-capture
(setq org-default-notes-file "~/Documents/org/backlog.org")

(setq org-capture-templates
'(("t" "Todo" entry (file "~/Documents/org/backlog.org")
        "* TODO %?")))

;; Set to the location of your Org files on your local system
(setq org-directory "~/Documents/org")
;; concat mobile files from this files
(setq org-mobile-files '("mobile-notes.org" "listen/restaurants.org"))

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Documents/org/mobile-captured.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(add-hook 'html-mode-hook
    (lambda ()
        ;; Default indentation is usually 4 spaces, changing to 2.
        (set (make-local-variable 'sgml-basic-offset) 2)))

;(setq python-shell-interpreter "ipython"
;      python-shell-interpreter-args "--simple-prompt --pprint")
(setq python-shell-interpreter "ipython")

(defun python-shell ()
        "Start and/or switch to the REPL."
        (interactive)
        (let ((shell-process
               (or (python-shell-get-process)
                   ;; `run-python' has different return values and different
                   ;; errors in different emacs versions. In 24.4, it throws an
                   ;; error when the process didn't start, but in 25.1 it
                   ;; doesn't throw an error, so we demote errors here and
                   ;; check the process later
                   (with-demoted-errors "Error: %S"
                     ;; in Emacs 24.5 and 24.4, `run-python' doesn't return the
                     ;; shell process
                     (call-interactively #'run-python)
                     (python-shell-get-process)))))
          (unless shell-process
            (error "Failed to start python shell properly"))
          (pop-to-buffer (process-buffer shell-process))
          'anaconda-mode
          'anaconda-eldoc-mode
          (evil-insert-state)))

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))

(add-hook 'python-mode-hook 'anaconda-mode)

(add-hook 'vue[JavaScript] 'tern-mode)
(add-hook 'js2-mode-hook 'tern-mode)
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-tern))

(require 'helm-config)
;; TODO experimental
(setq helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

;; TODO only init for src files
;; required by require
(add-hook 'after-init-hook #'global-flycheck-mode)
;; TODO customize error window

;; yasnippet everywhere
(yas-global-mode 1)

;; required by require
;; snippet direcories
;; TODO always use latest default collection
(setq yas-snippet-dirs
      '("~/dotfiles/emacs/snippets"               ;; personal snippets
        "~/.emacs.d/elpa/yasnippet-20170923.1646/snippets" ;; the default collection
        ))

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

;; fix the company popup (80-column-ruler break it)
;(defun on-off-fci-before-company(command)
;  (when (string= "show" command)
;    (turn-off-fci-mode))
;  (when (string= "hide" command)
;    (turn-on-fci-mode)))

;(advice-add 'company-call-frontends :before #'on-off-fci-before-company)

;; complete with tab
;(defun complete-or-indent ()
;    (interactive)
;    (if (company-manual-begin)
;        (company-complete-common)
;        (indent-according-to-mode)))

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

;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)

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
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
)

(add-hook 'js2-mode
    (lambda ()
        ;; Default indentation is usually 4 spaces, changing to 2.
        (set (make-local-variable 'sgml-basic-offset) 2)))

(add-hook 'js2-mode
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; highlight matching tags
;; TODO: do it like vims match-tag-always
(setq web-mode-enable-current-element-highlight t)

;; indentation
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-hook 'vue-mode
    (lambda ()
        ;; Default indentation is usually 4 spaces, changing to 2.
        (set (make-local-variable 'sgml-basic-offset) 2)))

(add-hook 'vue-mode
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

;;(re(global-evil-surround-mode 1)

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

;; prompt with colors, time, pwd, vc info and horizontal line after cmds
(defmacro with-face (str &rest properties)
    `(propertize ,str 'face (list ,@properties)))

(defun shk-eshell-prompt ()
    (let ((header-bg "#fff"))
    (concat
    (with-face (format-time-string "(%Y-%m-%d %H:%M) " (current-time)) :background header-bg :foreground "#888")
    (with-face
        (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
        :background header-bg)
    (with-face "\n" :background header-bg)
    (with-face user-login-name :foreground "blue")
    "@"
    (with-face "localhost" :foreground "green")
    (if (= (user-uid) 0)
        (with-face " #" :foreground "red")
        " $")
    " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)

; (add-to-list 'load-path (expand-file-name
;     (concat user-emacs-directory "other-srcs/company-emoji")))
; (require 'company-emoji)

; (add-to-list 'company-backends 'company-emoji)

;; macOS font
(set-fontset-font
 t 'symbol
 (font-spec :family "Apple Color Emoji") nil 'prepend)

(require 'projectile)
(projectile-mode)
;; https://github.com/bbatsov/projectile/issues/657
(setq projectile-mode-line " P")

(setq google-translate-default-source-language "en"
      google-translate-default-target-language "de")

(setq avy-all-windows nil)

(custom-set-variables '(org-trello-files '("/Users/mbayer/Documents/org/liversa/backlog.org")))



(require 'idle-require)             ; Needed in order to use idle-require

(dolist (feature
         '(auto-compile             ; auto-compile .el files
           google-translate
           google-translate-default-ui
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

(defun create-scratch-buffer nil
    "create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))

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
    (define-key map (kbd "M-t") 'toggle-word-case)
    (define-key map (kbd "M-+") 'text-scale-adjust)
    (define-key map (kbd "M--") 'text-scale-adjust)
    (define-key map (kbd "M-0") 'text-scale-adjust)
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
    ;; (define-key evil-normal-state-map (kbd "C-h") 'delete-forward-char)
    (define-key evil-normal-state-map (kbd "C-d") 'delete-backward-char)
    (define-key evil-normal-state-map (kbd "M-o") 'helm-find-files)
    (define-key evil-normal-state-map (kbd "M-b") 'helm-buffers-list)
    (define-key evil-normal-state-map (kbd "+") 'er/expand-region)
    (define-key evil-normal-state-map (kbd "f") 'ace-jump-mode)
    (define-key evil-normal-state-map (kbd "B") 'evil-first-non-blank)
    (define-key evil-normal-state-map (kbd "E") 'evil-end-of-line)
    (define-key evil-normal-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)
    ;; (define-key evil-normal-state-map (kbd "ä") 'delete-other-windows)
    ;; (define-key evil-normal-state-map (kbd "Ä") 'evil-search-highlight-persist-remove-all)
    (define-key evil-normal-state-map (kbd "ö") 'avy-goto-line)
    (define-key evil-normal-state-map (kbd "Ö") 'avy-goto-char)
    (define-key evil-normal-state-map (kbd "f") 'avy-goto-char-timer)
    (define-key evil-normal-state-map (kbd "F") 'avy-goto-char-in-line)
    (define-key evil-normal-state-map (kbd "C-j") 'scroll-up-command)
    (define-key evil-normal-state-map (kbd "C-k") 'scroll-down-command)
    (define-key evil-normal-state-map (kbd "~") 'toggle-word-case)
    (define-key evil-normal-state-map (kbd "º") 'evil-forward-paragraph)      ;; <alt-j>
    (define-key evil-normal-state-map (kbd "∆") 'evil-backward-paragraph)     ;; <alt-k>
    (define-key evil-normal-state-map (kbd "U") 'delete-backward-char)
    (define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)
    (define-key evil-normal-state-map (kbd "Y") 'copy-line)

    ;; visual line
    (define-key evil-visual-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)
    ; Overload shifts so that they don't lose the selection
    (define-key evil-visual-state-map (kbd ">") 'evil-shift-right-visual)
    (define-key evil-visual-state-map (kbd "<") 'evil-shift-left-visual)
    (define-key evil-visual-state-map [tab] 'evil-shift-right-visual)
    (define-key evil-visual-state-map [S-tab] 'evil-shift-left-visual)
    (define-key evil-visual-state-map (kbd "B") 'evil-first-non-blank)
    (define-key evil-visual-state-map (kbd "E") 'evil-end-of-line)

    ;; evil-leader mappings
    (evil-leader/set-key
    "/" 'evil-command-window-search-forward
    "|" 'split-window-right
    "-" 'split-window-below
    "k" 'evil-window-up
    "j" 'evil-window-down
    "h" 'evil-window-left
    "l" 'evil-window-right
    "x" 'delete-other-windows    ; duplicated
    "y" 'helm-yas-complete
    "f" 'helm-for-files
    "a" 'helm-ag-project-root
    "O" 'helm-find-files
    "oh" 'helm-org-in-buffer-headings
    "oa" 'helm-org-agenda-files-headings
    "oc" 'org-capture
    "or" 'org-reset-checkbox-state-subtree
    "oe" 'org-export-dispatch
    "ota" 'org-time-stamp
    "oti" 'org-time-stamp-inactive
    "odc" 'org-table-blank-field
    "SPC" 'helm-buffers-list
    "bb" 'bookmark-set
    "bp" 'projectile-add-known-project
    "gn" 'git-gutter:next-hunk
    "gp" 'git-gutter:previous-hunk
    "gs" 'helm-google-suggest
    "v" 'visual-line-mode
    "TAB" 'mode-line-other-buffer               ; previous buffer (like 'helm-buffer-list "RET")
    "D" 'dumb-jump-go
    "d" 'anaconda-mode-show-doc
    "*" 'helm-swoop
    "ö" 'evil-search-highlight-persist-remove-all        ; duplicated
    "p" 'helm-projectile
    "P" 'helm-projectile-find-file-in-known-projects
    "sp" 'projectile-switch-project
    ;; TOTEST
    "A" 'helm-projectile-ag
    "m" 'magit-status
    "nn" 'find-file
    "ns" 'create-scratch-buffer
    "ss" 'wg-save-session
    "so" 'wg-open-session
    "sc" 'wg-save-session-as
    "S" 'src-init
    "r" 'revert-buffer
    "C" 'shell-command
    "ci" 'org-clock-in
    "co" 'org-clock-out
    "cl" 'org-clock-in-last
    "cs" 'org-clock-select-task
    "i" 'python-shell
    "Hh" 'helm-howdoi
    "Hi" 'howdoi-query-insert-code-snippet-at-point
    "tl" 'helm-semantic-or-imenu
    "tt" 'google-translate-at-point
    "tq" 'google-translate-query-translate
    ;; "t" (lambda () (interactive) (evil-ex "%s /foo/bar/g"))
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

(require 'server)
(unless (server-running-p)
  (server-start))

(defun tangle-init-zsh ()
"If the current buffer is 'zsh.org' the code-blocks are tangled"
(when (equal (buffer-file-name)
    (expand-file-name "~/Settings/dotfiles/zsh.org"))
    ;; avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
    (org-babel-tangle))))

(add-hook 'after-save-hook 'tangle-init-zsh)

(custom-set-variables '(epg-gpg-program  "/usr/local/MacGPG2/bin/gpg2"))

(defun kill-ring-save-until (x)
  "kill-ring-save the line at point until the linenumber you pass."
  (interactive "nUntil: ")
  (setq offset (- x (line-number-at-pos)))
  (save-excursion
    (move-beginning-of-line nil)
    (set-mark-command nil)
    (forward-line offset)
    (move-end-of-line nil)
    (kill-ring-save (region-beginning) (region-end)))
  (message "yanked %i lines" (1+ offset)))

(defun copy-line ()
    (interactive)
        (save-excursion
          (back-to-indentation)
          (kill-ring-save
           (point)
           (line-end-position)))
           (message "1 line copied"))

(defun daily ()
    "setup journal windows and buffers"
    (interactive)
    (delete-other-windows)
    (find-file "~/Documents/org/journal.org")
    (split-window-right)
    (evil-window-right 1)
    (find-file "~/Documents/org/agenda.org")
    (evil-window-left 1)
    (evil-goto-first-line)
    (evil-open-above 0)
    (evil-open-above 0)
    (insert "day")
    (yas-expand))

(defun toggle-word-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2016-01-08"
  (interactive)
  (let (
        (deactivate-mark nil)
        -p1 -p2)
    (if (use-region-p)
        (setq -p1 (region-beginning)
              -p2 (region-end))
      (save-excursion
        (skip-chars-backward "[:alnum:]")
        (setq -p1 (point))
        (skip-chars-forward "[:alnum:]")
        (setq -p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region -p1 -p2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region -p1 -p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region -p1 -p2)
      (put this-command 'state 0)))))
