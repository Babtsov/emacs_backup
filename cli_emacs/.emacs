
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; enable linum only for conventional modes
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d\u2502") ;; nice formatting for linum

(menu-bar-mode -1) ;; disable menubar
(winner-mode 1)    ;; winner to quickly restore window config
(defalias 'yes-or-no-p 'y-or-n-p) ;; enough to write just y/n
(defalias 'list-buffers 'ibuffer) ;; make ibuffer default
(windmove-default-keybindings) ;; use shift + arrows to move between windows
(global-set-key (kbd "C-x m") 'imenu) ;; bind to imenu instead of mail
;;(global-set-key (kbd "C-x r") 'gdb-restore-windows)
(electric-pair-mode 1) ;; ensure parenthesis and braces are paired
(setq transient-mark-mode nil) ;; disable transient-mark-mode

;;(global-set-key (kbd "C-q") (kbd "C-g"));; quit with C-q
(setq tags-revert-without-query 1)

;; https://stackoverflow.com/questions/11700934/emacs-set-and-toggle-show-trailing-whitespace
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company helm-xref swiper-helm counsel swiper ivy helm-ag helm auto-complete smooth-scrolling)))
 '(show-trailing-whitespace t))
 ;; highlight annoying trailing whitespace

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
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

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




;;(setq helm-split-window-in-side-p t)
;;(setq helm-split-window-default-side 'left)
;;(setq helm-split-window-in-side-p 'nil)

;;(setq helm-always-two-windows t)

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



;; (ivy-mode 1)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)





(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


