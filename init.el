;;;; init.el --- something -*- lexical-binding: t; -*-

;;; Commentary:

;; Useful links:
;; https://github.com/MatthewZMD/.emacs.d
;; https://github.com/poncie/.emacs.d
;; https://github.com/seagle0128/.emacs.d
;; http://pages.sachachua.com/.emacs.d/Sacha.html
;; https://github.com/hlissner/doom-emacs
;; https://www.gnu.org/software/emacs/manual

;;; Code:

;; User Information
(setq user-full-name           "Jan Felix Langenbach"
      user-mail-address        "o.hase3@gmail.com"
      user-theme-directory     (expand-file-name "themes/" user-emacs-directory)
      user-autoload-directory  (expand-file-name "autoload/" user-emacs-directory))



;;;; Constants

(defconst IS-GUI
  (display-graphic-p)
  "Are we running on a GUI Emacs?")

(defconst IS-WINDOWS
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst IS-LINUX
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst IS-MACOS
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

(defconst IS-ROOT
  (string-equal "root" (getenv "USER"))
  "Are you a ROOT user?")

(defconst HAS-RG
  (executable-find "rg")
  "Do we have ripgrep?")

(defconst HAS-PYTHON
  (executable-find "python")
  "Do we have python?")

(defconst HAS-PYTHON3
  (executable-find "python3")
  "Do we have python3?")

(defconst HAS-TR
  (executable-find "tr")
  "Do we have tr?")

(defconst HAS-MVN
  (executable-find "mvn")
  "Do we have Maven?")

(defconst HAS-CLANGD
  (or (executable-find "clangd")                            ; usually
      (executable-find "/usr/local/opt/llvm/bin/clangd"))   ; macOS
  "Do we have clangd?")

(defconst HAS-GCC
  (executable-find "gcc")
  "Do we have gcc?")

(defconst HAS-GIT
  (executable-find "git")
  "Do we have git?")

(defconst HAS-PDFLATEX
  (executable-find "pdflatex")
  "Do we have pdflatex?")

(defconst HAS-DVIPNG
  (executable-find "dvipng")
  "Do we have dvipng?")



;;;; Package Initialization

(require 'package)

(push '("melpa" . "http://melpa.org/packages/") package-archives)
(push '("cselpa" . "https://elpa.thecybershadow.net/packages/") package-archives)
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-enable-imenu-support t)
(require 'use-package)
(setq use-package-always-ensure t
      use-package-expand-minimally t
      use-package-compute-statistics t)

(use-package dash)
(use-package bind-key)

(load-file (expand-file-name "customize.el" user-emacs-directory))



;;;; Macros

(eval-when-compile
  (require 'cl-macs)
  (require 'dash))

(defmacro comment (&rest _)
  "Comment out one or more s-expressions."
  nil)

(defmacro uncomment (&rest forms)
  "Collects FORMS into `progn'.
Useful to quickly uncomment a `comment'."
  (cons 'progn forms))

(defmacro unbind-keys (&rest keys)
  "Unbind multiple KEYS specified by strings for `kbd'."
  (cons 'progn (cl-loop for key in keys collect `(unbind-key ,key))))

(defmacro translate-key (key target)
  "Define a translation by binding KEY to TARGET in `key-translation-map'."
  `(bind-key ,key ,target key-translation-map))

(defmacro translate-keys (&rest keys)
  "Bind KEYS as pairs in `key-translation-map'."
  (cons 'progn (cl-loop for keypair in (-partition 2 keys)
                        collect (macroexpand `(translate-key ,@keypair)))))

(defmacro add-hooks (target &rest hooks)
  "Add multiple HOOKS to TARGET."
  (cons 'progn (cl-loop for hook in hooks collect `(add-hook ',target #',hook))))

(defmacro add-prog-hook (hook)
  "Add a HOOK to `prog-mode-hook'."
  `(add-hook 'prog-mode-hook #',hook))

(defmacro add-text-hook (hook)
  "Add a HOOK to `text-mode-hook'."
  `(add-hook 'text-mode-hook #',hook))

(defmacro add-prog-hooks (&rest hooks)
  "Add multiple HOOKS to `prog-mode-hook'."
  (cons 'progn (cl-loop
                for hook in hooks
                collect (macroexpand `(add-prog-hook ,hook)))))

(defmacro add-text-hooks (&rest hooks)
  "Add multiple HOOKS to `text-mode-hook'."
  (cons 'progn (cl-loop
                for hook in hooks
                collect (macroexpand `(add-text-hook ,hook)))))

(defmacro add-progtext-hook (hook)
  "Add HOOK to `prog-mode-hook' and `text-mode-hook'."
  (list 'progn (macroexpand `(add-prog-hook ,hook)) (macroexpand `(add-text-hook ,hook))))

(defmacro add-progtext-hooks (&rest hooks)
  "Add multiple HOOKS to `prog-mode-hook' and `text-mode-hook'."
  (cons 'progn (cl-loop
                for hook in hooks
                collect (macroexpand `(add-prog-hook ,hook))
                collect (macroexpand `(add-text-hook ,hook)))))



;;;; Packages

(use-package bind-key)

(comment (use-package diminish
           :commands diminish
           :config
           (diminish 'emacs-lisp-mode "Elisp")
           (diminish 'visual-line-mode)))

(use-package delight
  :commands delight
  :config
  (delight 'emacs-lisp-mode "Elisp" :major)
  (delight 'visual-line-mode nil 'simple))

(use-package auto-package-update
  :defer 1
  :custom
  (auto-package-update-interval 7) ;; in days
  (auto-package-update-prompt-before-update t)
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

(use-package company
  :hook ((prog-mode text-mode comint-mode) . company-mode)
  :bind ("S-SPC" . company-complete))

;;; Text editing

(use-package hungry-delete
  :bind (("M-<backspace>" . hungry-delete-backward)
         ("M-<delete>" . hungry-delete-forward)))

(use-package move-text
  :bind (("M-<down>" . move-text-down)
         ("M-<up>" . move-text-up)))

;;; Miscellaneous

(use-package reformatter   ; https://github.com/purcell/reformatter.el
  :commands reformatter-define)

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package format-all
  :bind ("C-c C-f" . format-all-buffer))

(if IS-GUI
    (progn
      (use-package all-the-icons)
      (use-package neotree
        :after all-the-icons
        :bind (("<f5>" . neotree-toggle))
        :custom (neo-theme 'icons)))
  (progn
    (use-package neotree
      :bind (("<f5>" . neotree-toggle))
      :custom (neo-theme 'arrow))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package undo-tree
  :delight
  :hook (after-init . global-undo-tree-mode))

;;; Games

(use-package 2048-game
  :commands 2084-game)



;;; Which-key Configuration

(use-package which-key
  :delight
  :defer 0.5
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  :config
  (which-key-setup-side-window-right-bottom)
  (which-key-add-key-based-replacements
    "ESC"       '("M-" . "Meta key bindings")
    "ESC ESC"   "keyboard-escape-quit"
    "<menu>"    '("user-specific" . "User specific commands")
    "<menu> c"  "config"
    "C-c"       '("mode-specific" . "Mode specific commands")
    "C-c !"     "flycheck"
    "C-h 4"     "other-window"
    "C-x"       '("global" . "Global commands")
    "C-x RET"   "locale"
    "C-x ESC"   "complex-repeat"
    "C-x 4"     "other-window"
    "C-x 5"     "other-frame"
    "C-x 6"     "two-column"
    "C-x 8"     '("unicode" . "Unicode symbols")
    "C-x @"     '("apply-modifier" . "Add a modifier to the next event")
    "C-x a"     "abbrev"
    "C-x a i"   "inverse"
    "C-x v"     "version-control"
    "C-x n"     "narrow"
    "C-x r"     "rectangle/register"
    "M-s"       "search"
    "M-s h"     "highlight"
    "M-g"       "goto"
    )
  (which-key-mode))



;;; Ivy Configuration

(use-package ivy
  :delight
  :defer 0.1
  :custom (ivy-wrap t)
  :bind (("C-x b"   . ivy-switch-buffer)
         ("C-c v"   . ivy-push-view)
         ("C-c V"   . ivy-pop-view)
         ("C-c C-r" . ivy-resume)
         :map ivy-minibuffer-map
         ("RET" . ivy-alt-done)    ; Make RET recurse into directories
         ("C-j" . ivy-done)
         ("C-<up>" . ivy-previous-history-element)
         ("C-<down>" . ivy-next-history-element)
         )
  :config
  (ivy-mode))

(use-package counsel
  :after ivy
  :delight
  :demand
  :bind (("<f1> l"  . find-library)
         ("<f2> i"  . counsel-info-lookup-symbol)
         ("<f2> u"  . counsel-unicode-char)
         ("<f2> j"  . counsel-set-variable)

         ("C-c c" . counsel-compile)
         ("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c L" . counsel-git-log)
         ("C-c k" . counsel-rg)
         ("C-c m" . counsel-linux-app)
         ("C-c n" . counsel-fzf)
         ;; ("C-x l" . counsel-locate) ; Rebound C-x l to C-x [
         ("C-c J" . counsel-file-jump)
         ;; ("C-S-o" . counsel-rhythmbox) ; No Rythmbox
         ;; ("C-c w" . counsel-wmctrl) ; No wmctrl

         ("C-c b" . counsel-bookmark)
         ("C-c d" . counsel-descbinds)
         ("C-c o" . counsel-outline)
         ("C-c t" . counsel-load-theme)
         ("C-c F" . counsel-org-file))
  :config
  (counsel-mode))

(use-package swiper
  :after ivy
  :bind ("C-s" . swiper-isearch))

(use-package amx                        ; Select previous commands by default
  :after ivy)



;;; Smartparens

(defun jfl/wrap-spaces (&rest _ignored)
  "Insert a space after the point."
  (insert ?\s)
  (backward-char))

(defun jfl/newline-indent (&rest _ignored)
  "Insert a newline and indent."
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(use-package smartparens
  :defer 0.2
  :custom (sp-highlight-pair-overlay . nil)
  :bind (("C-(" . sp-backward-sexp)
         ("C-)" . sp-forward-sexp))
  :config
  (require 'smartparens-config)
  ;; Remove this when #624 comes through.
  (cl-loop for trigger in '("(" "{" "[") do
           (sp-local-pair 'prog-mode trigger nil :post-handlers '((jfl/wrap-spaces "SPC"))))
  ;; Open new line on RET after open brace.
  (sp-local-pair 'prog-mode "{" nil :post-handlers '((jfl/wrap-spaces    "SPC")
                                                     (jfl/newline-indent "RET")))
  (sp-local-pair 'pascal-mode "begin" "end" :post-handlers '((jfl/newline-indent "RET")))
  (sp-with-modes '(tex-mode
                   plain-tex-mode
                   latex-mode
                   LaTeX-mode)
    (sp-local-pair "\"`" "\"'"
                   :unless '(sp-latex-point-after-backslash sp-in-math-p)
                   :post-handlers '(sp-latex-skip-double-quote))
    (sp-local-pair "\"<" "\">"
                   :unless '(sp-latex-point-after-backslash sp-in-math-p)
                   :post-handlers '(sp-latex-skip-double-quote)))
  (smartparens-global-mode)
  (show-smartparens-global-mode))



;;; Yasnippet WIP



;;;; Builtin Modes

;;; Checkdoc

(with-eval-after-load 'checkdoc
  (use-package checkdoc-url-buttonize))

;;; Doc View Mode

(eval-when-compile (require 'doc-view))
(with-eval-after-load 'doc-view
  (bind-keys
   :map doc-view-mode-map
   ("<mouse-1>" . doc-view-next-page)
   ("<mouse-3>" . doc-view-previous-page)
   ("C-<mouse-4>" . doc-view-enlarge)
   ("C-<mouse-5>" . doc-view-shrink)))

;;; Org Mode

(eval-when-compile (require 'org-indent))
(with-eval-after-load 'org-indent (add-hook 'org-mode-hook #'org-indent-mode))



;;;; Languages

;;; Common Lisp

(defvar quicklisp-home (or (getenv "QUICKLISP_HOME") "~/quicklisp/")
    "The directory where quicklisp is installed.")

(use-package slime
  :commands slime
  :custom ((slime-net-coding-system . ('utf-8-unix))
           (slime-repl-history-file . ((expand-file-name "slime-history.eld" user-emacs-directory))))
  :init
  (setq slime-default-lisp 'sbcl)
  (setq slime-lisp-implementations
        '((sbcl ("/usr/bin/sbcl") :coding-system utf-8-unix)))
  :config
  (load (expand-file-name "slime-helper.el" quicklisp-home)))

(with-eval-after-load 'lisp-mode
  (bind-key "C-c C-f" (lambda () (indent-region (point-min) (point-max))) lisp-mode-map))

;;; Elisp

(add-hook 'emacs-lisp-mode-hook (lambda () (set 'comment-column 40)))

;;; LaTeX

(eval-after-load 'tex-mode '(add-hook 'latex-mode-hook #'latex-electric-env-pair-mode))

(use-package latex-preview-pane
  :commands latex-preview-pane-mode)

(use-package tex                        ; AUCTeX
  :ensure auctex
  :hook ((tex-mode   . TeX-tex-mode)
         (latex-mode . TeX-latex-mode))
  :custom ((TeX-PDF-mode nil)           ; Important! Vital for preview-mode
           (preview-image-type (if HAS-DVIPNG 'dvipng 'png))) ; All around faster
  :config
  (setq TeX-auto-save t
        TeX-parse-self t)
  (setq-default TeX-master nil)

  (eval-after-load 'latex
    '(bind-keys :map LaTeX-mode-map
                ("C-c C-f"   . nil)
                ("C-c C-S-f" . TeX-font)))
  (eval-after-load 'which-key
    '(which-key-add-major-mode-key-based-replacements 'latex-mode
       "C-c C-p" '("preview" . "Inline formula preview")
       "C-c C-p C-c" "clear-out"
       "C-c C-o" "fold-mode"
       "C-c C-q" "fill"
       "C-c C-t" "toggle")))

(use-package company-auctex
  :after tex company
  :config
  (company-auctex-init))


;;; Markdown

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (reformatter-define markdownfmt
    :program "markdownfmt")
  (bind-key "C-c C-f" #'markdownfmt-buffer markdown-mode-map))


;;; Pascal

(with-eval-after-load 'pascal
  (setq pascal-indent-level 2)
  (reformatter-define ptop
    :program "/usr/bin/ptop"
    :args `("-i" ,(number-to-string pascal-indent-level)
            "-c" "/home/janfel/.config/pascal/ptop.cfg"
            "/dev/stdin"
            "/dev/stdout"))

  (bind-key "C-c C-f" #'ptop-buffer pascal-mode-map))

;;; Python

(eval-after-load 'python
  '(bind-key "C-c C-h" #'python-eldoc-at-point python-mode-map))

(use-package python-black
  :after python
  :bind (:map python-mode-map
              ("C-c C-f" . python-black-buffer)))



;;; Themes

(eval-after-load 'custom '(push user-theme-directory custom-theme-load-path))

(use-package nord-theme
  :defer t)

(use-package doom-themes
  :defer t
  :custom-face
  (cursor ((t (:background "BlanchedAlmond"))))
  :config
  ;; flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(load-theme 'doom-one)



;;;; Functions

(defun find-config-file ()
  "Edit init.el."
  (interactive)
  (find-file user-init-file))

(defun find-config-directory ()
  "Open the config directory in dired."
  (interactive)
  (dired user-emacs-directory))

(defun other-window-backwards (count &optional all-frames)
  "Select another window going backwards in cyclic ordering of windows.
This function goes in the opposite direction of
`other-window' and is implemented in terms of it.
The argument COUNT is multiplied with -1 and
ALL-FRAMES is passed directly to `other-window'."
  (interactive "p")
  (other-window (* count -1) all-frames))

;; (cl-loop for (func . doc) in
;;          '(("find-config-directory" . "Open the config directory in dired")
;;            )
;;          do (autoload (intern func) (expand-file-name func AUTOLOAD-DIR) doc 'interactive nil))

(defalias 'exit 'save-buffers-kill-emacs)
(defalias 'quit 'save-buffers-kill-emacs)



;;;; Keybindings

;; Unset keys
(unbind-keys
 "M-DEL"
 "<menu>"
 ;; "C-z"
 "<XF86Forward>"
 "<XF86Back>")

;; Set keys
(bind-keys
 ("C-<tab>"           . other-window)
 ("C-S-<iso-lefttab>" . other-window-backwards)
 ("C-ö"               . kill-region)
 ("C-ä"               . kill-ring-save)
 ("C-p"               . yank)
 ("C-x M-k"           . kill-current-buffer)
 ;;("C-c I" . find-config-file)
 ("C-M-<prior>"       . backward-page)
 ("C-M-<next>"        . forward-page))


(bind-keys*
 ("C-e" . execute-extended-command)
 ("C-f" . swiper-isearch))

(bind-keys
 :prefix "<menu>"
 :prefix-map user-prefix-map
 ("c f" . find-config-file)
 ("c d" . find-config-directory))



;;;; Hooks

(defun jfl|line-numbers ()
  "Hook for line numbers."
  (setq display-line-numbers 'relative)
  (display-line-numbers-mode))

(add-hooks after-init-hook              ; When Emacs has finished initializing:
           electric-indent-mode         ; Autoindent when pressing return
           column-number-mode           ; Show column number in modeline
           global-visual-line-mode      ; Break lines evenly
           delete-selection-mode        ; Overwrite selection
           )

(comment                                ; If not using smartparens
 (add-hooks after-init-hook
            show-paren-mode             ; Show matching parentheses
            electric-pair-mode          ; Insert closing braces
            ))

(add-progtext-hooks                     ; In programming and text buffers:
 jfl|line-numbers                       ; Show line numbers
 hl-line-mode                           ; Highlight current line
 )

;;; Behaviour hooks
(add-hook 'before-save-hook #'whitespace-cleanup) ; Clean up on save



;;;; Miscellaneous

;; Shorten questions
(fset 'yes-or-no-p 'y-or-n-p)

;; Inhibit startup screen if we're opening files.
(unless (= (safe-length command-line-args) 1)
  (setq inhibit-startup-screen t))

;; Make shell open in the current buffer.
(push '("^\\*shell\\*$" . (display-buffer-same-window)) display-buffer-alist)

;; Smooth Scrolling
;; Copied from: https://github.com/MatthewZMD/.emacs.d/blob/master/elisp/init-scroll.el
(setq scroll-step 1
      scroll-margin 2
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      auto-window-vscroll nil
      fast-but-imprecise-scrolling nil
      mouse-wheel-scroll-amount '(1 ((shift) . 5))
      mouse-wheel-progressive-speed nil
;; Horizontal Scroll
      hscroll-step 1
      hscroll-margin 2)

;;; init.el ends here

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp)
;; End:
