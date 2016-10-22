; vim: set ft=lisp ts=4 sw=4 expandtab :

;    ███████╗███╗   ███╗ █████╗  ██████╗███████╗██████╗  ██████╗
;    ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
;    █████╗  ██╔████╔██║███████║██║     ███████╗██████╔╝██║
;    ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║██╔══██╗██║
; ██╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║██║  ██║╚██████╗
; ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

; ASCII-Art credits: http://patorjk.com/software/taag/#p=testall&h=0&v=0&f=ANSI%20Shadow&t=.emacsrc

;;; (TODO
    ; modeline
    ; errors/warnings
    ; orgmodify
        ; org-files
        ; archive
        ; capture
        ; evil o
    ; plugins
        ; magit
        ; restclient
        ; eshell
        ; paredit
        ; doctor
        ; dunnet
        ;https://github.com/flycheck/flycheck/
        ;https://github.com/Fuco1/smartparens
        ;https://github.com/auto-complete/auto-complete
        ;https://github.com/abo-abo/avy
        ;https://github.com/nonsequitur/smex/
        ;https://github.com/jacktasia/dumb-jump
        ;https://github.com/abo-abo/hydra
        ;https://github.com/timcharper/evil-surround
        ;http://cedet.sourceforge.net/
;;; )

;;; (general
    ;;; theme
    (load-theme 'misterioso)

    ;; maximized on startup
    ; (add-hook 'after-init-hook '(lambda () (w32-send-sys-command #xf030)))
    ;; remember cursor position, for emacs 25.1 or later
    ; (save-place-mode 1)
    ;; remember cursor position
    (if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))
    ;;; disable blinking cursor
    (blink-cursor-mode 0)
    ;;; disable welcome window
    (setq ns-pop-up-frames nil)
    ;;; disable audio bell
    (setq ring-bell-function 'ignore)
    ;;; disable tool-bar
    (tool-bar-mode -1)
    ;;; set font size to 16pt
    (set-face-attribute 'default nil :height 160)
    ;;; show line numbers
    (global-linum-mode t)

    ;;; show trailing whitespace
    (setq-default show-trailing-whitespace t)
    ;;; use 4 spaces instead of tabs
    (setq-default indent-tabs-mode nil)
    (setq-default tab-width 4)
    (setq indent-line-function 'insert-tab)

(defvar my-offset 4 "My indentation offset. ")
(defun backspace-whitespace-to-tab-stop ()
  "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
  (interactive)
  (if (or indent-tabs-mode
          (region-active-p)
          (save-excursion
            (> (point) (progn (back-to-indentation)
                              (point)))))
      (call-interactively 'backward-delete-char-untabify)
    (let ((movement (% (current-column) my-offset))
          (p (point)))
      (when (= movement 0) (setq movement my-offset))
      ;; Account for edge case near beginning of buffer
      (setq movement (min (- p 1) movement))
      (save-match-data
        (if (string-match "[^\t ]*\\([\t ]+\\)$" (buffer-substring-no-properties (- p movement) p))
            (backward-delete-char (- (match-end 1) (match-beginning 1)))
          (call-interactively 'backward-delete-char))))))

    ; (setq-default indent-tabs-mode nil)
    ; (setq tab-width 4) ; or any other preferred value
    ; (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
    ;                       64 68 72 76 80 84 88 92 96 100 104 108 112
    ;                       116 120))

    ;;; set backup directory
    (setq auto-save-file-name-transforms
              `((".*" ,(concat user-emacs-directory "auto-save/") t)))
    (setq backup-directory-alist
          `(("." . ,(expand-file-name
                     (concat user-emacs-directory "backup")))))
    ;;; backup method
    (setq backup-by-copying t)
    ;;; backup frequency
    (setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

    ;;; modeline
    ;;; display column number
    (setq column-number-mode t)
;;; )

;;; (fun
    (require 'zone)
    ; (zone-when-idle 120)

    (defun zone-choose (pgm)
        "Choose a PGM to run for `zone'."
        (interactive
         (list
          (completing-read
           "Program: "
           (mapcar 'symbol-name zone-programs))))
        (let ((zone-programs (list (intern pgm))))
          (zone)))
;;; )

;;; (plugins
    ;;; (activate package managers
        (require 'package)
        ; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
        (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
        (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
        (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
        (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

        ; (setq package-enable-at-startup nil)
        (package-initialize)
        (when (not package-archive-contents)
            (package-refresh-contents))

        ;;; automate package installs
        ; list the packages you want
        (setq package-list '(company evil expand-region fireplace git-gutter helm
                                  helm-projectile org ox-rst projectile
                                  restclient tabbar undo-tree weather-metno yasnippet
                                  zenburn-theme))

        ; list the repositories containing them
        (setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                                 ("gnu" . "http://elpa.gnu.org/packages/")
                                 ("marmalade" . "http://marmalade-repo.org/packages/")))

        ; activate all the packages (in particular autoloads)
        (package-initialize)

        ; fetch the list of packages available
        (unless package-archive-contents
          (package-refresh-contents))

        ; install the missing packages
        (dolist (package package-list)
          (unless (package-installed-p package)
            (package-install package)))
    ;;; )
    ;;; (flycheck
        (add-hook 'after-init-hook #'global-flycheck-mode)

        ;; TODO only activate for specific modes
        ; (add-hook 'python-mode-hook             #'flycheck-mode)
        ; (add-hook 'js-mode-hook                 #'flycheck-mode)
        ; (add-hook 'web-mode-hook                #'flycheck-mode)
        ; (add-hook 'lisp-interaction-mode-hook   #'flycheck-mode)

        (defun my-flycheck-hook ()
          "Limit Flycheck error list buffer height to 10 lines."
          (when (not (get-buffer-window "*Flycheck errors*"))
            (save-selected-window
              (save-excursion
                (let* ((w (split-window-vertically))
                       (h (window-height w)))
                  (select-window w)
                  (switch-to-buffer "*Flycheck errors*")
                  (shrink-window (- h 5)))))))
        (add-hook 'flycheck-error-list-mode-hook 'my-flycheck-hook)

        ;; disable jshint since we prefer eslint checking
        ; (setq-default flycheck-disabled-checkers
        ;   (append flycheck-disabled-checkers
        ;     '(javascript-jshint)))

        ; (add-to-list 'display-buffer-alist
        ;              (,(rx bos "*Flycheck errors*" eos)
        ;               (display-buffer-reuse-window
        ;                display-buffer-in-side-window)
        ;               (side            . bottom)
        ;               (reusable-frames . visible)
        ;               (window-height   . 0.33)))
    ;;; )


    ;;; (weather-metno-el
        (require 'weather-metno)
        (add-to-list 'load-path "~/.emacs.d/elpa/weather-metno-20150831.1807")
        (setq weather-metno-get-image-props '(:width 16 :height 16 :ascent center))
        (setq weather-metno-location-name "Lindau, Germany"
          weather-metno-location-latitude 47
          weather-metno-location-longitude 9)
    ;;; )

    ;;; (org-mode
        (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
        (require 'org)
        (setq org-log-done t)
        (setq org-startup-folded "showeverything")
        (setq org-highest-priority ?A)
        (setq org-lowest-priority ?Z)
        (setq org-default-priority ?A)
        (setq org-agenda-files (append '("~/.notes.org") (file-expand-wildcards "~/Documents/org/cal/*\.org")))

        ; indentation
        (add-hook 'org-mode-hook
                  (lambda ()
                    (org-indent-mode t))
                  t)

        ; initial langauges we want org-babel to support
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

        (require 'org-autolist)
        (add-hook 'org-mode-hook (lambda () (org-autolist-mode)))

        ;;; os-rst (org-mode rst export)
        (require 'ox-rst)
        (require 'ox-odt)
    ; )

    ;;; (evil
        (require 'evil)
        (evil-mode 1)
    ;;; )

    ;;; (helm
        (require 'helm-config)
    ;;; )

    ;;; (yasnippet
        (setq yas-snippet-dirs
              '("~/.emacs.d/snippets/yasnippet-snippets"
                ))

        (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
    ;;; )

    ;;; ace-jump-mode
    (add-to-list 'load-path "/Users/mbayer/.emacs.d/elpa/ace-jump-mode-2.0/")
    (autoload
      'ace-jump-mode
      "ace-jump-mode"
      "Emacs quick move minor mode"
    t)

    ;;; (tabbar
        (tabbar-mode 1)

        (setq tabbar-background-color "#7f7f7f")
        (custom-set-faces
         '(tabbar-default ((t (:inherit variable-pitch :background "#7f7f7f" :foreground "black" :weight bold))))
         '(tabbar-button-highlight ((t (:inherit tabbar-default))))
         '(tabbar-highlight ((t (:underline t))))
         '(tabbar-selected ((t (:inherit tabbar-default :background "#000000" :underline nil))))
         '(tabbar-separator ((t (:inherit tabbar-default :background "#7f7f7f"))))
         '(tabbar-unselected ((t (:inherit tabbar-default :background "#7f7f7f")))))

        ;; change padding of the tabs
        ;; we also need to set separator to avoid overlapping tabs by highlighted tabs
        (custom-set-variables
         '(tabbar-separator (quote (0.5))))
        ;; adding spaces
        (defun tabbar-buffer-tab-label (tab)
          "Return a label for TAB.
        That is, a string used to represent it on the tab bar."
          (let ((label  (if tabbar--buffer-show-groups
                            (format "[%s]  " (tabbar-tab-tabset tab))
                          (format "%s  " (tabbar-tab-value tab)))))
            ;; Unless the tab bar auto scrolls to keep the selected tab
            ;; visible, shorten the tab label to keep as many tabs as possible
            ;; in the visible area of the tab bar.
            (if tabbar-auto-scroll-flag
                label
              (tabbar-shorten
               label (max 1 (/ (window-width)
                               (length (tabbar-view
                                        (tabbar-current-tabset)))))))))
    ;;; )

    ;;; (git-gutter
        (global-git-gutter-mode +1)
        ; live update
        (custom-set-variables
         '(git-gutter:update-interval 2)
         '(git-gutter:modified-sign "~")
         ; '(git-gutter:added-sign "+")
         ; '(git-gutter:deleted-sign "-")
        )
    ;;; )

    ;;; (nyan-mode
        (add-to-list 'load-path "~/.emacs.d/github/nyan-mode")
        (require 'nyan-mode)
        (nyan-mode)
    ;;; )

    ;;; expand-region
    (require 'expand-region)

    ;;; fireplace
    (require 'fireplace)

    ;;; undo-tree
    (global-undo-tree-mode)

    ;;; windmove
    (windmove-default-keybindings)

    ; ;;; company
    ; (add-hook 'after-init-hook 'global-company-mode)

    ;;; (auto-complete
        (require 'auto-complete)
        ;; TODO deactivate for minibuffer
        ; ;; no auto-complete in minibuffers
        ; (defun auto-complete-mode-maybe ()
        ;   "No maybe for you. Only AC!"
        ;   (unless (minibufferp (current-buffer))
        ;     (auto-complete-mode 1)))
        (global-auto-complete-mode t)
    ;;; )


    ;;; json-mode
    ;; TODO really required
    (require 'json-mode)

    ;;; json-snatcher
    (require 'json-snatcher)
    (defun js-mode-bindings ()
    "Sets a hotkey for using the json-snatcher plugin"
     (when (string-match  "\\.json$" (buffer-name))
            ;;; TODO map @ mappings
        (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
    (add-hook 'js-mode-hook 'js-mode-bindings)
    (add-hook 'js2-mode-hook 'js-mode-bindings)

    ;;; (jedi
        (add-hook 'python-mode-hook 'jedi:setup)
        (setq jedi:complete-on-dot t)
        ;; M-x jedi:install-server RET
    ;;; )
;;; )

;;; (generated
    ; (custom-set-variables
    ;     ;; custom-set-variables was added by Custom.
    ;     ;; If you edit it by hand, you could mess it up, so be careful.
    ;     ;; Your init file should contain only one such instance.
    ;     ;; If there is more than one, they won't work right.
    ; '(custom-enabled-themes (quote (zenburn)))
    ; '(custom-safe-themes
    ; (quote
    ;     ("afbb40954f67924d3153f27b6d3399df221b2050f2a72eb2cfa8d29ca783c5a8" default))))
    ; (custom-set-faces
    ;     ;; custom-set-faces was added by Custom.
    ;     ;; If you edit it by hand, you could mess it up, so be careful.
    ;     ;; Your init file should contain only one such instance.
    ;     ;; If there is more than one, they won't work right.
    ;     )
; )

;;; (keymappings, keybindings, keychords
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'scroll-down-command)
(global-set-key [(meta down)] 'scroll-up-command)

(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'scroll-down-command)


    (defvar my-keys-minor-mode-map
      (let ((map (make-sparse-keymap)))
        (define-key map (kbd "M-e") 'move-end-of-line)
        (define-key map (kbd "M-b") 'move-beginning-of-line)
        ;;; osx
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
        (define-key map (kbd "C->") 'tabbar-forward)
        (define-key map (kbd "C-<") 'tabbar-backward)
        (define-key map (kbd "C-+") 'er/expand-region)
        (define-key map (kbd "C-c SPC") 'ace-jump-mode)
        (define-key map (kbd "DEL") 'backward-delete-char)
        map)
      "my-keys-minor-mode keymap.")

    (define-minor-mode my-keys-minor-mode
      "A minor mode so that my key settings override annoying major modes."
      :init-value t
      :lighter " my-keys")

    (my-keys-minor-mode 1)

    (define-key evil-normal-state-map (kbd "M-o") 'helm-find-files)
    (define-key evil-normal-state-map (kbd "M-b") 'helm-buffers-list)
    (define-key evil-normal-state-map (kbd "+") 'er/expand-region)
    (define-key evil-normal-state-map (kbd "f") 'ace-jump-mode)
    (define-key evil-normal-state-map (kbd "B") 'evil-first-non-blank)
    (define-key evil-normal-state-map (kbd "E") 'evil-end-of-line)

    ;;; map command key to meta
    (if (boundp 'ns-command-modifier)
        (setq ns-command-modifier 'meta))
    (if (boundp 'ns-option-modifier)
        (setq ns-option-modifier nil))

    ;;; (template insertion
        (defun insert-checkbox ()
          (interactive)
          (insert "- [ ] "))
        (global-set-key (kbd "M--") 'insert-checkbox)

        (defun insert-org-mininam-theme ()
          (interactive)
          (insert "#+SETUPFILE: ~/Settings/dotfiles/org-minimal-theme.setup"))

        (defun insert-org-title ()
          (interactive)
          (insert "#+TITLE: "))
    ;;; )
;;; )
