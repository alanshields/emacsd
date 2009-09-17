;; php mode hook
(defun steelhead-php-style ()
  (interactive)
  ; Steelhead uses tabs, not spaces.
  (setq indent-tabs-mode t)
  ; Steelhead uses javadoc comments like so:
  ; /*
  ; * something here
  ; */
  (add-to-list 'c-offsets-alist '(c . c-lineup-comment))
  ; Allman style (AKA bsd) - but for some reason this isn't working. Let's keep moving.
  (c-set-style "bsd" nil)

  ; Electric parens seems to break with php-enhanced-mode
  (setq c-electric-flag nil)
  ; Mumamo on
  (nxhtml-mumamo-mode))
 

(add-hook 'php-mode-hook
          #'steelhead-php-style)

(require 'remember)
(org-remember-insinuate)
(setq org-default-notes-file "~/Documents/sas_timelog")
(define-key global-map (kbd "C-c r") 'org-remember)

(find-file "~/Documents/sas_timelog")