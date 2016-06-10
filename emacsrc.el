;;; general {
    ;;; theme
    (load-theme 'misterioso)

    ;;; disable blinking cursor
    (blink-cursor-mode 0)

    ;;; disable welcome window
    (setq ns-pop-up-frames nil)

    ;;; disable audio bell
     (setq visible-bell t)

    ;;; disable tool-bar
    (tool-bar-mode -1)
    ;;; set font size to 16pt
    (set-face-attribute 'default nil :height 160)

    ;;; show trailing whitespace
    (setq-default show-trailing-whitespace t)
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
