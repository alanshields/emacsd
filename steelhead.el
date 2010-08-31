;; php mode hook
(defun steelhead-php-style ()
  (interactive)
  ; Steelhead uses tabs, not spaces.
  (setq indent-tabs-mode t)
  ; Fill to 80 columns, not 70 (for M-q)
  (setq fill-column 80)
  ; Steelhead uses javadoc comments like so:
  ; /*
  ; * something here
  ; */
  ; (add-to-list 'c-offsets-alist '(c . c-lineup-comment))
  ; Allman style (AKA bsd)
  (c-add-style "steelhead"
               '("bsd"
                 (c-basic-offset . 3)
                 (c-offsets-alist
                  ; phpdoc comment
                  (c . 0)
                  ; next-line function args
;                  (arglist-cont-nonempty . +)
                  (case-label . +)
                  ))
               t)
               
  ; 3 characters per tab
  (setq tab-width 3)

  ; Electric parens seems to break with php-enhanced-mode
  (setq c-electric-flag nil)
  ; Mumamo on
  ; (nxhtml-mumamo-mode)

  ; Key bindings
  (local-set-key (kbd "C-c C-t") 'align-php-assign)
  (local-set-key (kbd "C-c C-a") 'align-table)
  )

(add-hook 'php-mode-hook
          #'steelhead-php-style)

;; They use Eclipse. Okay. We need to be compatible. Okay.
(defun steelhead-java-style ()
  (interactive)
  ; Tabs, not spaces.
  (setq indent-tabs-mode t)
  ; Fill to 80 columns, not 70 (for M-q)
  (setq fill-column 80)
  ; Java style
  (c-add-style "steelhead-java"
               '("java"
                 (c-offsets-alist
                  (topmost-intro-cont . 0)))
               t)
  ; 4 characters per tab
  (setq tab-width 4))

(add-hook 'java-mode-hook
          #'steelhead-java-style)


(require 'remember)
(org-remember-insinuate)
(setq org-default-notes-file "~/Documents/sas_timelog")
(define-key global-map (kbd "C-c r") 'org-remember)

(find-file "~/Documents/sas_timelog")