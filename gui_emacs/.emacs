
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; enable linum only for conventional modes
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)

(setq linum-format "%4d\u2502") ;; nice formatting for linum

;; GUI specific setups
(tool-bar-mode -1) ;; disable tool bar
(set-face-attribute 'default nil :height 140) ;; increase text size on emacs GUI
 (setq scroll-conservatively 10000 scroll-preserve-screen-position 1)
(setq ring-bell-function 'ignore) ;; no annoying bells
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; fullscreen on startup

(winner-mode 1)    ;; winner to quickly restore window config
(defalias 'yes-or-no-p 'y-or-n-p) ;; enough to write just y/n
(defalias 'list-buffers 'ibuffer) ;; make ibuffer default
(windmove-default-keybindings) ;; use shift + arrows to move between windows
(global-set-key (kbd "C-x m") 'imenu) ;; bind to imenu instead of mail

(electric-pair-mode 1) ;; ensure parenthesis and braces are paired
(setq transient-mark-mode nil) ;; disable transient-mark-mode

(setq tags-revert-without-query 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-resize-on-pa-text-height 22)
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (htmlize company helm-xref swiper-helm counsel swiper ivy helm-ag helm auto-complete)))

'(show-trailing-whitespace t))
;; highlight annoying trailing whitespace
;; https://stackoverflow.com/questions/11700934/emacs-set-and-toggle-show-trailing-whitespace

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; load emacs 24's package system. Add MELPA repository.
;; http://ergoemacs.org/emacs/emacs_package_system.html
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t))



;; package specific inits
(ac-config-default)


(require 'helm-config)
(helm-mode 1)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(define-key global-map [remap execute-extended-command] 'helm-M-x)

(global-set-key (kbd "C-s")  'swiper-helm)
(global-set-key (kbd "C-x m") 'helm-imenu-in-all-buffers) ;; bind to imenu instead of mail


(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)


(require 'helm-xref)
(setq xref-show-xrefs-function 'helm-xref-show-xrefs)


;; Make Helm window at the bottom WITHOUT using any extra package
;; https://www.reddit.com/r/emacs/comments/345vtl/make_helm_window_at_the_bottom_without_using_any/
;; (add-to-list 'display-buffer-alist
;;                     `(,(rx bos "*helm" (* not-newline) "*" eos)
;;                          (display-buffer-in-side-window)
;;                          (inhibit-same-window . t)
;;                          (window-height . 0.4)))


(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 13)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))




(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


