;;;; early-init.el -*- lexical-binding: t; -*-

;;; M-EMACS Startup Performance Magic

(defconst better-gc-cons-threshold 67108864 ; 64mb
  "The default value to use for `gc-cons-threshold'.
  If you experience freezing, decrease this. If you experience stuttering, increase this.")

;; Deactivate garbage collection
(setq gc-cons-threshold most-positive-fixnum)
;; Deactivate magic filenames
(defconst file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Reactivate garbage collection
            (setq gc-cons-threshold better-gc-cons-threshold)
            ;; Reactivate magic filenames
            (setq file-name-handler-alist file-name-handler-alist-original)
            ;; Remove temporary variable
            (makunbound 'file-name-handler-alist-original)
            ;; AutoGC
            (if (boundp 'after-focus-change-function)
              (add-function :after after-focus-change-function
                (lambda () (unless (frame-focus-state) (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))
            ;; -AutoGC
            ;; MinibufferGC
            (defun gc-minibuffer-setup-hook ()
              (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

            (defun gc-minibuffer-exit-hook ()
              (garbage-collect)
              (setq gc-cons-threshold better-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))
            ;; -MinibufferGC

;; In Emacs 27+, package initialization occurs before `user-init-file' is
;; loaded, but after `early-init-file'.
(setq package-enable-at-startup nil)

;; Ask package.el to not add (package-initialize) to .emacs.
(setq package--init-file-ensured t)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Ignore X resources; its settings would be redundant with the other settings
;; in this file and can conflict with later config (particularly where the
;; cursor color is concerned).
(advice-add #'x-apply-session-resources :override #'ignore)

;; Disable UI elements early, to prevent catching a glimpse of them.
; (menu-bar-mode -1)
; (push '(menu-bar-lines . 0) default-frame-alist)
; (push '(tool-bar-lines . 0) default-frame-alist)
; (push '(vertical-scroll-bars) default-frame-alist)

;; UnsetSRF
; (setq site-run-file nil)
;; -UnsetSRF
