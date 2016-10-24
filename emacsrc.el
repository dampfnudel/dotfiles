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

(let* ((packages
        '(auto-compile              ; automatically compile Emacs Lisp libraries
            evil                    ; extensible vi layer
            evil-leader             ; the <leader> feature from Vim
            helm                    ; Incremental and narrowing framework
            expand-region           ; Increases the selected region by semantic units
            yasnippet               ; template system
            flycheck                ; modern on-the-fly syntax checking extension
            git-gutter              ; icons in the gutter area indicating src ctrl changes
            undo-tree               ; undo system
            auto-complete           ; auto completion with popup menu
            json-snatcher           ; extract the path to a json value, display at modeline
            fireplace               ; a cozy fireplace
            jedi                    ; Python auto-completion for Emacs
            idle-require            ; load elisp libraries while Emacs is idle
            evil-nerd-commenter     ; comment code efficiently
            avy                     ; jumping to visible text using a char-based decision tree
            restclient              ; tool to manually explore and test HTTP REST webservices 
            ;; themes
            gruvbox-theme
            solarized-theme
            monokai-theme
            zenburn-theme
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
            ;; helm-projectile      ; Helm integration for Projectile
            ;; helm-swoop           ; Efficiently hopping squeezed lines
            ;; js2-mode             ; Improved JavaScript editing mode
            ;; magit                ; control Git from Emacs
            ;; markdown-mode        ; Emacs Major mode for Markdown-formatted files
            ;; material-theme       ; A Theme based on Google Material Design
            ;; matlab-mode          ; MATLAB integration with Emacs
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
                        (package-install 'exec-path-from-shell)))))

(defun tangle-init ()
"If the current buffer is 'init.org' the code-blocks are tangled, and
the tangled file is compiled."
(when (equal (buffer-file-name)
    (expand-file-name (concat user-emacs-directory "emacsrc.org")))
    ;; avoid running hooks when tangling.
    (let ((prog-mode-hook nil))
    (org-babel-tangle)
    (byte-compile-file (concat user-emacs-directory "init.el")))))

(add-hook 'after-save-hook 'tangle-init)

;; theme
;; trust theme
(setq custom-safe-themes t)
(load-theme 'gruvbox)
;; set font size to 16pt
(set-face-attribute 'default nil :height 160)

;; disable blinking cursor
(blink-cursor-mode 0)
;; disable audio bell
(setq ring-bell-function 'ignore)
;; remember cursor position
(if (version< emacs-version "25.0")
    (progn
        (require 'saveplace)
  (setq-default save-place t))
  (save-place-mode 1))

;; disable welcome window
(setq ns-pop-up-frames nil)
;; disable tool-bar
(tool-bar-mode -1)
;; show line numbers
(global-linum-mode t)
;; y & n instead of yes & no
(fset 'yes-or-no-p 'y-or-n-p)

;; display column number
(setq column-number-mode t)

;; switch frames with <Shift-Left/Right/Up/Down>
(windmove-default-keybindings)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
;;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

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

(require 'evil)
(evil-mode 1)

;; org-mode for .org-files
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; required by require
(setq org-log-done t)
;; setup priorities from A-Z
(setq org-highest-priority ?A)
(setq org-lowest-priority ?Z)
(setq org-default-priority ?A)
;; concat agenda from this files
(setq org-agenda-files (append '("~/.notes.org") (file-expand-wildcards "~/Documents/org/cal/*\.org")))

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

;; TODO only init for src files
;; required by require
(add-hook 'after-init-hook #'global-flycheck-mode)
;; TODO customize error window

;; snippet direcories
;; required by require
(setq yas-snippet-dirs
        '("~/.emacs.d/snippets/yasnippet-snippets"
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

(require 'auto-complete)
;; TODO deactivate for minibuffer
(global-auto-complete-mode t)

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

;; macOS
;; make use of <Meta-Up> <Meta-Down>
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'scroll-down-command)
(global-set-key [(meta down)] 'scroll-up-command)

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
    (define-key map (kbd "M-b") 'helm-buffers-list)
    (define-key map (kbd "M-o") 'helm-find-files)
    (define-key map (kbd "M-p") 'helm-projectile)
    (define-key map (kbd "M-l") 'helm-semantic-or-imenu)
    (define-key map (kbd "\C-cl") 'org-store-link)
    (define-key map (kbd "\C-ca") 'org-agenda)
    (define-key map (kbd "C-+") 'er/expand-region)
    ;; TOOD Backspace?
    (define-key map (kbd "DEL") 'backward-delete-char)
    (define-key map (kbd "C--") 'evilnc-comment-or-uncomment-lines)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

;; evil keymappings
;; normal state
(define-key evil-normal-state-map (kbd "M-o") 'helm-find-files)
(define-key evil-normal-state-map (kbd "M-b") 'helm-buffers-list)
(define-key evil-normal-state-map (kbd "+") 'er/expand-region)
(define-key evil-normal-state-map (kbd "f") 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "B") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "E") 'evil-end-of-line)
(define-key evil-normal-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd "ö") 'avy-goto-char)
(define-key evil-normal-state-map (kbd "Ö") 'avy-goto-line)
(define-key evil-normal-state-map (kbd "f") 'avy-goto-char-in-line)

;; visual line
(define-key evil-visual-state-map (kbd "-") 'evilnc-comment-or-uncomment-lines)

;; evil-leader
(evil-leader/set-key
  "f" 'find-file
  "b" 'helm-buffers-list)

;; macOS
;; map command key to meta
(if (boundp 'ns-command-modifier)
    (setq ns-command-modifier 'meta))
(if (boundp 'ns-option-modifier)
    (setq ns-option-modifier nil))

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
