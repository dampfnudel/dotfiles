; vim: set ft=lisp ts=4 sw=4 expandtab :

;    ███████╗███╗   ███╗ █████╗  ██████╗███████╗██████╗  ██████╗
;    ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
;    █████╗  ██╔████╔██║███████║██║     ███████╗██████╔╝██║
;    ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║██╔══██╗██║
; ██╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║██║  ██║╚██████╗
; ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

; ASCII-Art credits: http://patorjk.com/software/taag/#p=testall&h=0&v=0&f=ANSI%20Shadow&t=.emacsrc

;;; TODO {
    ; orgmodify
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
    ;;; map command key to meta
    (if (boundp 'ns-command-modifier)
        (setq ns-command-modifier 'meta))
    (if (boundp 'ns-option-modifier)
        (setq ns-option-modifier nil))

    ;;; osx: quit, close, copy, paste, save
    (global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
    (global-set-key (kbd "M-w") 'kill-buffer)
    (global-set-key (kbd "M-c") 'kill-ring-save)
    (global-set-key (kbd "M-v") 'yank)
    (global-set-key (kbd "M-s") 'save-buffer)
;;; }


;;; plugins {
    ;;; activate package managers
    (require 'package)
    (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
    (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
    (setq package-enable-at-startup nil)
    (package-initialize)

    ;;; org-mode
    (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
    (require 'org)
    (define-key global-map "\C-cl" 'org-store-link)
    (define-key global-map "\C-ca" 'org-agenda)
    (setq org-log-done t)

    ;;; os-rst (org-mode rst export)
    (require 'ox-rst)

    ;;; evil
    (require 'evil)
    (evil-mode 1)

    ;;; helm
    (require 'helm-config)

    ;;; fireplace
    (require 'fireplace)
;;; }

;;; custom {
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
