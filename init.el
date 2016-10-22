; vim: set ft=lisp ts=4 sw=4 expandtab :

;    ███████╗███╗   ███╗ █████╗  ██████╗███████╗██████╗  ██████╗
;    ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔════╝
;    █████╗  ██╔████╔██║███████║██║     ███████╗██████╔╝██║
;    ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║██╔══██╗██║
; ██╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║██║  ██║╚██████╗
; ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝

; ASCII-Art credits: http://patorjk.com/software/taag/#p=testall&h=0&v=0&f=ANSI%20Shadow&t=.emacsrc

;; This file replaces itself with the actual configuration at first run.

;; require org for tangling
(require 'org)
;; open the configuration
(find-file (concat user-emacs-directory "init.org"))
;; tangle it
(org-babel-tangle)
;; load it
(load-file (concat user-emacs-directory "init.el"))
;; finally byte-compile it
(byte-compile-file (concat user-emacs-directory "init.el"))
