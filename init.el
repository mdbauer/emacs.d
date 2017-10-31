;; Michael's Emacs initialization
;; https://github.com/mdbauer/emacs.d.git

;; set load path for custom lisp
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; emacs custom-settings in separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; package management
(require 'package)
(if (member (system-name) (list "L1MYB00L4" "ubuntu"))
    ;; behind firewall use: https://github.com/d12frosted/elpa-mirror
    (setq package-archives '(("melpa" . "~/.emacs.d/elpa-mirror/melpa/")
                             ("org"   . "~/.emacs.d/elpa-mirror/org/")
                             ("gnu"   . "~/.emacs.d/elpa-mirror/gnu/")))
  ;; otherwise use online archives
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
			   ("elpa" . "http://tromey.com/elpa/")
                           ("gnu" . "https://elpa.gnu.org/packages/"))))
;; packages to install
(setq package-list '(recentf
                     ess
                     auctex
                     org-bullets
                     tramp
                     magit
                     markdown-mode
                     pandoc-mode
                     ))
(package-initialize)
;; refresh package descriptions
(unless package-archive-contents 
  (package-refresh-contents))
;; install missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; my version of better-defaults
(load "~/.emacs.d/init-better-defaults.el")

;; Latex
(load "~/.emacs.d/init-latex.el")

;; ESS
(load "~/.emacs.d/init-ess.el")

;; For Windows
(if (string-equal system-type "windows-nt")
    (load "~/.emacs.d/init-windows.el")
  (load "~/.emacs.d/init-linux.el"))

;; nice console fonts
(if (string-equal system-type "windows-nt")
    (set-frame-font "Consolas-12" nil t)    ;; Windows
  (set-frame-font "Inconsolata-12" nil t))  ;; Linux

;; reduce the number of ding warnings
(setq ring-bell-function
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))

;; more informative frame titles
(setq frame-title-format
          '(buffer-file-name
            "%f"
            (dired-directory dired-directory "%b")))

;; dired-x -- https://www.gnu.org/software/emacs/manual/html_node/dired-x/Installation.html#Installation
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
            ;; (setq dired-guess-shell-gnutar "gtar")
            ;; (setq dired-x-hands-off-my-keys nil)
            ))
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            ;; (dired-omit-mode 1)
            ))
(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)
(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)

;; recentf -- https://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; markdown mode
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))
;; (add-hook 'markdown-mode-hook
;; 	  (lambda ()
;; 	    (markdown-enable-math)))
(setq markdown-enable-math t)
(setq markdown-command "pandoc --from markdown")
(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; org-mode
(load "~/.emacs.d/init-org.el")

;; theme
(load-theme 'tango-dark t)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; compile (make) with  C-x C-m C-m  or C-x RET RET
(setq compilation-scroll-output t)
(global-set-key (kbd "C-x C-m") 'compile)

;; fixing prompts -- https://www.masteringemacs.org/article/disabling-prompts-emacs
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
        kill-buffer-query-functions))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))
(setq server-socket-dir "~/.emacs.d/server")
;; to avoid "Buffer foo still has clients; kill it?"
;; https://shreevatsa.wordpress.com/2007/01/06/using-emacsclient/
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; don't ask for confirmation of these commands
(put 'downcase-region 'disabled nil)  ;; C-x C-l
(put 'upcase-region 'disabled nil)    ;; C-x C-u
(put 'narrow-to-region 'disabled nil) ;; C-x n n

;; does this speed up finding files?
(remove-hook 'find-file-hooks 'vc-find-file-hook)

(find-file "~/Documents/org/tm.org")
