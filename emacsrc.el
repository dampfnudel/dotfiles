; vim: set ft=lisp ts=4 sw=4 expandtab :

;    ███████╗███╗   ███╗ █████╗  ██████╗███████╗██████╗  ██████╗
;    ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
;    █████╗  ██╔████╔██║███████║██║     ███████╗██████╔╝██║
;    ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║██╔══██╗██║
; ██╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║██║  ██║╚██████╗
; ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

; ASCII-Art credits: http://patorjk.com/software/taag/#p=testall&h=0&v=0&f=ANSI%20Shadow&t=.emacsrc

;;; TODO {
    ; osx
        ; shell open
        ; copy
        ; cmd a
    ; orgmodify
        ; cheatsheets
        ; org-files
        ; archive
        ; capture
        ; evil o
    ; plugins
        ; magit
        ; restclient
        ; dired
        ; ace-jump
        ; yasnippet
        ; undo tree
        ; expand region
        ; eshell
        ; paredit
        ; doctor
        ; dunnet
;;; }

;;; general {
    ;;; theme
    ; (load-theme 'misterioso)

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
    (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                          64 68 72 76 80 84 88 92 96 100 104 108 112
                          116 120))

    ;;; set backup directory
    (setq backup-directory-alist `(("." . "~/.emacs.d/backup")))
    ;;; backup method
    (setq backup-by-copying t)
    ;;; backup frequency
    (setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
;;; }

;;; key mappings {
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
        map)
      "my-keys-minor-mode keymap.")

    (define-minor-mode my-keys-minor-mode
      "A minor mode so that my key settings override annoying major modes."
      :init-value t
      :lighter " my-keys")

    (my-keys-minor-mode 1)

    ;;; map command key to meta
    (if (boundp 'ns-command-modifier)
        (setq ns-command-modifier 'meta))
    (if (boundp 'ns-option-modifier)
        (setq ns-option-modifier nil))

    ;; template insertion
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
;;; }


;;; plugins {
    ;;; activate package managers
    (require 'package)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
    (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
    (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
    (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
    ; (setq package-enable-at-startup nil)
    (package-initialize)

    ;; weather-metno-el
    (require 'weather-metno)
    (add-to-list 'load-path "~/.emacs.d/elpa/weather-metno-20150831.1807")
    (setq weather-metno-get-image-props '(:width 16 :height 16 :ascent center))
    (setq weather-metno-location-name "Lindau, Germany"
      weather-metno-location-latitude 47
      weather-metno-location-longitude 9)

    ;;; org-mode
    (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
    (require 'org)
    (define-key global-map "\C-cl" 'org-store-link)
    (define-key global-map "\C-ca" 'org-agenda)
    (setq org-log-done t)
    (setq org-agenda-files (append '("~/.notes.org") (file-expand-wildcards "~/Documents/org/cal/*\.org")))

    ; Must have org-mode loaded before we can configure org-babel
    ; (require 'org-install)

    ; indentation
    (add-hook 'org-mode-hook
              (lambda ()
                (org-indent-mode t))
              t)

    ; Some initial langauges we want org-babel to support
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

    ;;; evil
    (require 'evil)
    (evil-mode 1)

    ;;; helm
    (require 'helm-config)
    ;;; set helm-M-x as default
    (global-set-key (kbd "M-x") 'helm-M-x)

    ;;; fireplace
    (require 'fireplace)
;;; }

;;; generated {
    (custom-set-variables
        ;; custom-set-variables was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
    '(custom-enabled-themes (quote (zenburn)))
    '(custom-safe-themes
    (quote
        ("afbb40954f67924d3153f27b6d3399df221b2050f2a72eb2cfa8d29ca783c5a8" default))))
    (custom-set-faces
        ;; custom-set-faces was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
        )
; }
