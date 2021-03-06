;; org-mode
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)
(setq
 org-directory org-path
 org-default-notes-file (concat org-directory "notes.org")
 org-agenda-skip-deadline-if-done t
 org-agenda-skip-scheduled-if-done t
 org-clock-into-drawer t
 org-file-apps
 (quote
  ((auto-mode . emacs)
   ("\\.mm\\'" . default)
   ("\\.x?html?\\'" . default)
   ("\\.pdf\\'" . default)
   ("\\.docx\\'" . default))))

;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AGENDA FILES
;;ideally append to existing list, in case custom.el creates the list based on C-c [ command   -- but I couldn't get that to work
;; (setq org-agenda-files (append org-agenda-files '("~/Documents/trends/trends.org" "~/Documents/mpu/mpu.org" "~/Documents/fed-info/fed-info.org")))
;; (setq org-agenda-files (append org-agenda-files (list tm-path)))
;; (setq org-agenda-files (list))

;; list of agenda files in correct location of My Documents
;; (defun in-mydoc (file)
;;   (concat (file-name-as-directory mydoc-path) file))

;; (in-mydoc "trends/trends.org")
;; (setq mydoc-agenda-file (in-mydoc "trends/trends.org"))
;; (dolist (elt mydoc-agenda-files)
;;   (concat (file-name-as-directory mydoc-path) elt))  ;; not sure how to do it with dolist

;; (setq mydoc-agenda-files '("fed-info/fed-info.org"))
;; (setq org-agenda-files (append org-agenda-files (mapcar 'in-mydoc mydoc-agenda-files)))

;; (setq org-agenda-files (append org-agenda-files (list tm-path)))

(setq org-agenda-files (list tm-path))

(setq fed-info-path (concat (file-name-as-directory dropbox-path) "work/Fed Information Effect/fed-info.org"))
(setq org-agenda-files (append org-agenda-files (list fed-info-path)))

(setq cc-path (concat (file-name-as-directory dropbox-path) "work/climate/cc.org"))
(setq org-agenda-files (append org-agenda-files (list cc-path)))

(setq skewness-path (concat (file-name-as-directory dropbox-path) "work/skewness/skewness.org"))
(setq org-agenda-files (append org-agenda-files (list skewness-path)))

(setq mpu-path (concat (file-name-as-directory dropbox-path) "work/Monetary Policy Uncertainty/mpu.org"))
(setq org-agenda-files (append org-agenda-files (list mpu-path)))

(setq fomc-path (concat (file-name-as-directory dropbox-path) "work/FOMC Excess Sensitivity/fomc.org"))
(setq org-agenda-files (append org-agenda-files (list fomc-path)))

(setq ap-path (concat (file-name-as-directory dropbox-path) "Lehre/Empirical Asset Pricing/ap.org"))
(setq org-agenda-files (append org-agenda-files (list ap-path)))

(setq hamburg-path (concat (file-name-as-directory org-path) "hamburg.org"))
(setq org-agenda-files (append org-agenda-files (list hamburg-path)))



