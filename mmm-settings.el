(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
;;(set-face-background 'mmm-output-submode-face  "DarkSlateBlue")
;;(set-face-background 'mmm-code-submode-face    "DarkSlateBlue")
;;(set-face-background 'mmm-comment-submode-face "DarkOliveGreen")
(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
		 ("<%=" . mmm-output-submode-face)
		 ("<%"  . mmm-code-submode-face))
    :front "<%[#=]?"
    :back "%>"
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
	     (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
	     (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))
(add-hook 'html-mode-hook
	  (lambda ()
	    (setq mmm-classes '(erb-code))
	    (mmm-mode-on)))
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (ruby-electric-mode nil)))
(global-set-key [f8] 'mmm-parse-buffer)

(mmm-add-classes
 '((my-django-expr
    :submode python-mode
    :face mmm-declaration-submode-face
    :front "{%"
    :back "%}"
    :include-front t
    :include-back t)))

(mmm-add-classes
 '((my-django-var
    :submode python
    :face mmm-output-submode-face
    :front "{{"
    :back "}}"
    :include-front t
    :include-back t)))

(mmm-add-classes
'((my-html-here-doc
   :submode html-mode
   :face mmm-output-submode-face
   :front "<<\"---html---\""
   :back "---html---"
   :include-front nil
   :include-back nil)))
(mmm-add-mode-ext-class nil ".*\\.pl" 'my-html-here-doc)

(mmm-add-mode-ext-class nil "templates/.*\\.html$" 'my-django-var)
(mmm-add-mode-ext-class nil "templates/.*\\.html$" 'my-django-expr)
