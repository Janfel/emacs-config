;;;; jfl-customize.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; Make customize.el save into this file
(setq custom-file load-file-name)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode nil t)
 '(TeX-quote-language-alist
   (quote
    (("ngerman" "\"`" "\"'" nil)
     ("german" "\"`" "\"'" nil))))
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(auto-package-update-delete-old-versions t t)
 '(auto-package-update-hide-results t t)
 '(auto-package-update-interval 7 t)
 '(auto-package-update-prompt-before-update t t)
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "k&r"))))
 '(company-idle-delay 0.2)
 '(company-tooltip-idle-delay 0.2)
 '(custom-safe-themes
   (quote
    ("70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "82358261c32ebedfee2ca0f87299f74008a2e5ba5c502bde7aaa15db20ee3731" default)))
 '(fci-rule-color "#5B6268")
 '(helm-grep-ag-command
   "rg --color=always --smart-case --no-heading --line-number %s %s %s")
 '(indent-tabs-mode nil)
 '(ivy-wrap t t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(neo-theme (quote icons) t)
 '(objed-cursor-color "#ff6c6b")
 '(opascal-case-label-indent 2)
 '(opascal-indent-level 2)
 '(package-selected-packages
   (quote
    (flycheck markdown-mode goto-line-preview live-preview auctex counsel swiper ivy helm which-key use-package undo-tree org-bullets nord-theme neotree move-text hungry-delete format-all doom-themes diminish auto-package-update all-the-icons 2048-game)))
 '(pascal-indent-level 2)
 '(preview-image-type (quote dvipng) t)
 '(show-paren-delay 0)
 '(slime-net-coding-system (quote utf-8-unix) t)
 '(slime-repl-history-file "/home/janfel/.emacs.d/slime-history.eld" t)
 '(sp-highlight-pair-overlay nil t)
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil)
 '(which-key-prefix-prefix "+" t)
 '(which-key-separator " " t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "BlanchedAlmond"))))
 '(sp-show-pair-match-content-face ((t (:background "#21242b"))) t))
