;; php mode hook
(defun steelhead-php-style ()
  (add-to-list 'c-offsets-alist '(c . c-lineup-comment))
  (setq c-hanging-braces-alist '((substatement-open before after)
                                 (arglist-cont-nonempty)
                                 (defun . (before)))))
(add-hook 'php-mode-hook
          #'steelhead-php-style)

(find-file "~/Documents/sas_timelog")