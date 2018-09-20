(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p) ;; enough to write just y/n
(set-face-attribute 'default nil :height 140) ;; increase text size on emacs GUI

;; enable linum only for conventional modes
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d\u2502") ;; nice formatting for linum

(winner-mode 1)    ;; winner to quickly restore window config
(electric-pair-mode 1) ;; ensure parenthesis and braces are paired

(setq ring-bell-function 'ignore) ;; no annoying bells

(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; fullscreen on startup
(setq transient-mark-mode nil) ;; disable transient-mark-mode

(setq tags-revert-without-query 1)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(use-package helm-config)

(use-package helm :ensure t)
(use-package swiper-helm :ensure t)

(use-package helm-mode
  :config
  (helm-mode 1))

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

;; Make Helm window at the bottom WITHOUT using any extra package
(setq helm-always-two-windows nil)
(setq helm-display-buffer-default-height 13)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))

(use-package try
	:ensure t)

(use-package which-key
      :ensure t 
      :config
      (which-key-mode))

(use-package org 
  :ensure t
  :pin org)

    (setenv "BROWSER" "chromium-browser")

        (use-package org-bullets
        :ensure t
        :config
        (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

            (custom-set-variables
             '(org-directory "~/Dropbox/orgfiles")
             '(org-default-notes-file (concat org-directory "/notes.org"))
             '(org-export-html-postamble nil)
             '(org-hide-leading-stars t)
             '(org-startup-folded (quote overview))
             '(org-startup-indented t)
             )

            (setq org-file-apps
  		(append '(
          		  ("\\.pdf\\'" . "evince %s")
 ("\\.x?html?\\'" . "/usr/bin/chromium-browser %s")
          		  ) org-file-apps ))

            (global-set-key "\C-ca" 'org-agenda)

            (setq org-agenda-custom-commands
            '(("c" "Simple agenda view"
            ((agenda "")
            (alltodo "")))))

            (global-set-key (kbd "C-c c") 'org-capture)

            (setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
            "~/Dropbox/orgfiles/soe-cal.org"
          			       "~/Dropbox/orgfiles/i.org"
          			       "~/Dropbox/orgfiles/schedule.org"))
            (setq org-capture-templates
          			  '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
          				   "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
          				  ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
          				   "* %? %^L %^g \n%T" :prepend t)
          				  ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
          				   "* %?\n%T" :prepend t)
          				  ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
          				   "* TODO %?\n%u" :prepend t)
  					  ("m" "Mail To Do" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
  					   "* TODO %a\n %?" :prepend t)
  					  ("g" "GMail To Do" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
  					   "* TODO %^L\n %?" :prepend t)
  					  ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
          				   "* %?\n%u" :prepend t)
  					  ))

        (defadvice org-capture-finalize 
            (after delete-capture-frame activate)  
        "Advise capture-finalize to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))

        (defadvice org-capture-destroy 
            (after delete-capture-frame activate)  
        "Advise capture-destroy to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))  

        (use-package noflet
        :ensure t )
        (defun make-capture-frame ()
        "Create a new frame and run org-capture."
        (interactive)
        (make-frame '((name . "capture")))
        (select-frame-by-name "capture")
        (delete-other-windows)
        (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
            (org-capture)))

; (require 'ox-beamer)
; for inserting inactive dates
(define-key org-mode-map (kbd "C-c >") (lambda () (interactive (org-time-stamp-inactive))))

(use-package htmlize :ensure t)

(use-package ace-window
:ensure t
:init
(progn
(setq aw-scope 'frame)
(global-set-key (kbd "C-x O") 'other-frame)
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
  ))

(setq proof-splash-enable nil)
(custom-set-variables '(coq-prog-name "/usr/local/bin/coqtop") '(proof-three-window-enable t))

(use-package company
:ensure t
:config
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)

(global-company-mode t)
)

(use-package company-irony
:ensure t
:config 
(add-to-list 'company-backends 'company-irony)

)

(use-package irony
:ensure t
:config
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
)

(use-package irony-eldoc
:ensure t
:config
(add-hook 'irony-mode-hook #'irony-eldoc))

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)
(use-package company-jedi
    :ensure t
    :config
    (add-hook 'python-mode-hook 'jedi:setup)
       )

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

;; company box mode
;(use-package company-box
;:ensure t
;  :hook (company-mode . company-box-mode))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(setq py-python-command "python3")
(setq python-shell-interpreter "python3")


    (use-package elpy
    :ensure t
    :config 
    (elpy-enable))

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

; Highlights the current cursor line
  (global-hl-line-mode t)

  ; flashes the cursor's line when you scroll
  (use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  ; (setq beacon-color "#666600")
  )

  ; deletes all the whitespace when you hit backspace or delete
  (use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))


  (use-package multiple-cursors
  :ensure t)

  ; expand the marked region in semantic increments (negative prefix to reduce region)
  ;; (use-package expand-region
  ;; :ensure t
  ;; :config 
  ;; (global-set-key (kbd "C-=") 'er/expand-region))

(setq save-interprogram-paste-before-kill t)


(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'revert-buffer)

; mark and edit all copies of the marked region simultaniously. 
(use-package iedit
:ensure t)

; if you're windened, narrow to the region, if you're narrowed, widen
; bound to C-x n
(defun narrow-or-widen-dwim (p)
"If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
(interactive "P")
(declare (interactive-only))
(cond ((and (buffer-narrowed-p) (not p)) (widen))
((region-active-p)
(narrow-to-region (region-beginning) (region-end)))
((derived-mode-p 'org-mode)
;; `org-edit-src-code' is not a real narrowing command.
;; Remove this first conditional if you don't want it.
(cond ((ignore-errors (org-edit-src-code))
(delete-other-windows))
((org-at-block-p)
(org-narrow-to-block))
(t (org-narrow-to-subtree))))
(t (narrow-to-defun))))

;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
;; This line actually replaces Emacs' entire narrowing keymap, that's
;; how much I like this command. Only copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)

(use-package js2-mode
:ensure t
:ensure ac-js2
:init
(progn
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
))

(use-package js2-refactor
:ensure t
:config 
(progn
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.
(add-hook 'js2-mode-hook #'js2-refactor-mode)))
(use-package tern
:ensure tern
:ensure tern-auto-complete
:config
(progn
(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(tern-ac-setup)
))

;;(use-package jade
;;:ensure t
;;)

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))


;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(use-package hydra 
    :ensure hydra
    :init 
    (global-set-key
    (kbd "C-x t")
	    (defhydra toggle (:color blue)
	      "toggle"
	      ("a" abbrev-mode "abbrev")
	      ("s" flyspell-mode "flyspell")
	      ("d" toggle-debug-on-error "debug")
	      ("c" fci-mode "fCi")
	      ("f" auto-fill-mode "fill")
	      ("t" toggle-truncate-lines "truncate")
	      ("w" whitespace-mode "whitespace")
	      ("q" nil "cancel")))
    (global-set-key
     (kbd "C-x j")
     (defhydra gotoline 
       ( :pre (linum-mode 1)
	      :post (linum-mode -1))
       "goto"
       ("t" (lambda () (interactive)(move-to-window-line-top-bottom 0)) "top")
       ("b" (lambda () (interactive)(move-to-window-line-top-bottom -1)) "bottom")
       ("m" (lambda () (interactive)(move-to-window-line-top-bottom)) "middle")
       ("e" (lambda () (interactive)(end-of-buffer)) "end")
       ("c" recenter-top-bottom "recenter")
       ("n" next-line "down")
       ("p" (lambda () (interactive) (forward-line -1))  "up")
       ("g" goto-line "goto-line")
       ))
    (global-set-key
     (kbd "C-c t")
     (defhydra hydra-global-org (:color blue)
       "Org"
       ("t" org-timer-start "Start Timer")
       ("s" org-timer-stop "Stop Timer")
       ("r" org-timer-set-timer "Set Timer") ; This one requires you be in an orgmode doc, as it sets the timer for the header
       ("p" org-timer "Print Timer") ; output timer value to buffer
       ("w" (org-clock-in '(4)) "Clock-In") ; used with (org-clock-persistence-insinuate) (setq org-clock-persist t)
       ("o" org-clock-out "Clock-Out") ; you might also want (setq org-log-note-clock-out t)
       ("j" org-clock-goto "Clock Goto") ; global visit the clocked task
       ("c" org-capture "Capture") ; Don't forget to define the captures you want http://orgmode.org/manual/Capture.html
	     ("l" (or )rg-capture-goto-last-stored "Last Capture"))

     ))

(defhydra multiple-cursors-hydra (:hint nil)
  "
     ^Up^            ^Down^        ^Other^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("r" mc/mark-all-in-region-regexp :exit t)
  ("q" nil)

  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore))

(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'mu4e-compose-mode-hook 'turn-on-flyspell)
(add-hook 'mu4e-compose-mode-hook 'turn-on-auto-fill)

(use-package shell-switcher
    :ensure t
    :config 
    (setq shell-switcher-mode t)
    :bind (("C-'" . shell-switcher-switch-buffer)
	   ("C-x 4 '" . shell-switcher-switch-buffer-other-window)
	   ("C-M-'" . shell-switcher-new-shell)))


  ;; Visual commands
  (setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
				 "ncftp" "pine" "tin" "trn" "elm" "vim"
				 "nmtui" "alsamixer" "htop" "el" "elinks"
				 ))
                                 (setq eshell-visual-subcommands '(("git" "log" "diff" "show")))
  (setq eshell-list-files-after-cd t)
  (defun eshell-clear-buffer ()
    "Clear terminal"
    (interactive)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (eshell-send-input)))
  (add-hook 'eshell-mode-hook
	    '(lambda()
	       (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

  (defun eshell/magit ()
    "Function to open magit-status for the current directory"
    (interactive)
    (magit-status default-directory)
    nil)

 ;; smart display stuff
(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(add-hook 'eshell-mode-hook
  (lambda ()
    (eshell-smart-initialize)))
;; eshell here
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

(defcustom dotemacs-eshell/prompt-git-info
  t
  "Turns on additional git information in the prompt."
  :group 'dotemacs-eshell
  :type 'boolean)

;; (epe-colorize-with-face "abc" 'font-lock-comment-face)
(defmacro epe-colorize-with-face (str face)
  `(propertize ,str 'face ,face))

(defface epe-venv-face
  '((t (:inherit font-lock-comment-face)))
  "Face of python virtual environment info in prompt."
  :group 'epe)

  (setq eshell-prompt-function
      (lambda ()
        (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face 'eshell-prompt)
                (when (and dotemacs-eshell/prompt-git-info
                           (fboundp #'vc-git-branches))
                  (let ((branch (car (vc-git-branches))))
                    (when branch
                      (concat
                       (propertize " [" 'face 'font-lock-keyword-face)
                       (propertize branch 'face 'font-lock-function-name-face)
                       (let* ((status (shell-command-to-string "git status --porcelain"))
                              (parts (split-string status "\n" t " "))
                              (states (mapcar #'string-to-char parts))
                              (added (count-if (lambda (char) (= char ?A)) states))
                              (modified (count-if (lambda (char) (= char ?M)) states))
                              (deleted (count-if (lambda (char) (= char ?D)) states)))
                         (when (> (+ added modified deleted) 0)
                           (propertize (format " +%d ~%d -%d" added modified deleted) 'face 'font-lock-comment-face)))
                       (propertize "]" 'face 'font-lock-keyword-face)))))
                (when (and (boundp #'venv-current-name) venv-current-name)
                  (concat 
                    (epe-colorize-with-face " [" 'epe-venv-face) 
                    (propertize venv-current-name 'face `(:foreground "#2E8B57" :slant italic))
                    (epe-colorize-with-face "]" 'epe-venv-face))) 
                (propertize " $ " 'face 'font-lock-constant-face))))

(use-package ggtags
:ensure t
:config 
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
)

(use-package origami
:ensure t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org" (name . "^.*org$"))
	     ("IRC" (or (mode . circe-channel-mode) (mode . circe-server-mode)))
	       ("web" (or (mode . web-mode) (mode . js2-mode)))
	       ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
	       ("mu4e" (or

               (mode . mu4e-compose-mode)
               (name . "\*mu4e\*")
               ))
	       ("programming" (or
			       (mode . python-mode)
			       (mode . c++-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ))))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-auto-mode 1)
	    (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
					;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

(defun z/nikola-deploy () ""
(interactive)
(venv-with-virtualenv "blog" (shell-command "cd ~/gh/cestlaz.github.io; nikola github_deploy"))
)

(defun z/swap-windows ()
""
(interactive)
(ace-swap-window)
(aw-flip-window)
)

(use-package haskell-mode
:ensure t
:config
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

)

(use-package shell-pop
:ensure t
  :bind (("s-t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("ehell" "eshell" (lambda nil (eshell)))))
  (setq shell-pop-term-shell "eshell")
  ;; need to do this manually or not picked up by `shell-pop'
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package wgrep
:ensure t
)
(use-package wgrep-ag
:ensure t
)
(require 'wgrep-ag)

(use-package ag
:ensure t)

(use-package pcre2el
:ensure t
:config 
(pcre-mode)
)

(use-package atomic-chrome
:ensure t
:config (atomic-chrome-start-server))
(setq atomic-chrome-buffer-open-style 'frame)

(use-package pdf-tools
:ensure t)
(use-package org-pdfview
:ensure t)

(require 'pdf-tools)
(require 'org-pdfview)

(use-package auto-yasnippet
:ensure t)
