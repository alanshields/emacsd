;; php mode hook
(defun steelhead-php-style ()
  (interactive)
  ; Steelhead uses javadoc comments like so:
  ; /*
  ; * something here
  ; */
  (add-to-list 'c-offsets-alist '(c . c-lineup-comment))
  ; Steelhead uses tabs, not spaces.
  (setq indent-tabs-mode t)
  ; Steelhead uses 4 space indentation
  (setq c-basic-offset 4)
  (setq tab-width 4))

(add-hook 'php-mode-hook
          #'steelhead-php-style)

(require 'remember)
(org-remember-insinuate)
(setq org-default-notes-file "~/Documents/sas_timelog")
(define-key global-map (kbd "C-c r") 'org-remember)

(find-file "~/Documents/sas_timelog")