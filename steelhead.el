;; php mode hook
(defun steelhead-php-style ()
  (interactive)
  ; Steelhead uses tabs, not spaces.
  (setq indent-tabs-mode t)
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
  )

(add-hook 'php-mode-hook
          #'steelhead-php-style)

(require 'remember)
(org-remember-insinuate)
(setq org-default-notes-file "~/Documents/sas_timelog")
(define-key global-map (kbd "C-c r") 'org-remember)

(find-file "~/Documents/sas_timelog")