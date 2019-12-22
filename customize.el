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
 '(auto-package-update-delete-old-versions t)
 '(auto-package-update-hide-results t)
 '(auto-package-update-interval 7)
 '(auto-package-update-prompt-before-update t)
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((java-mode . "java")
     (awk-mode . "awk")
     (other . "k&r"))))
 '(company-idle-delay 0.2)
 '(company-selection-wrap-around t)
 '(company-tooltip-idle-delay 0.2)
 '(cursor-type t)
 '(custom-safe-themes
   (quote
    ("0fe9f7a04e7a00ad99ecacc875c8ccb4153204e29d3e57e9669691e6ed8340ce" "1ca1f43ca32d30b05980e01fa60c107b02240226ac486f41f9b790899f6f6e67" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" "e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "82358261c32ebedfee2ca0f87299f74008a2e5ba5c502bde7aaa15db20ee3731" default)))
 '(fci-rule-color "#5B6268")
 '(haskell-process-args-ghci (quote ("-ferror-spans")))
 '(helm-grep-ag-command
   "rg --color=always --smart-case --no-heading --line-number %s %s %s")
 '(indent-tabs-mode nil)
 '(ivy-wrap t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(js-indent-level 2)
 '(lsp-ui-doc-enable t t)
 '(lsp-ui-flycheck-enable t t)
 '(lsp-ui-imenu-enable t t)
 '(lsp-ui-peek-enable t t)
 '(lsp-ui-sideline-enable nil t)
 '(lua-indent-level 2 t)
 '(neo-theme (quote icons) t)
 '(objed-cursor-color "#ff6c6b")
 '(opascal-case-label-indent 2)
 '(opascal-indent-level 2)
 '(pascal-indent-level 2)
 '(pdf-view-midnight-colors (cons "#27212E" "#FFFFFF"))
 '(preview-image-type (quote dvipng) t)
 '(show-paren-delay 0)
 '(slime-net-coding-system (quote utf-8-unix) t)
 '(slime-repl-history-file "/home/janfel/.emacs.d/slime-history.eld" t)
 '(sp-escape-quotes-after-insert nil)
 '(sp-highlight-pair-overlay nil)
 '(tab-always-indent (quote complete))
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
 '(which-key-prefix-prefix "+")
 '(which-key-separator " "))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "BlanchedAlmond"))))
 '(sp-show-pair-match-content-face ((t (:background "#21242b"))) t))
