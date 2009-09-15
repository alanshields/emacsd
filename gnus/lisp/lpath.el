;; Shut up.

(defun maybe-fbind (args)
  (while args
    (or (fboundp (car args))
	(defalias (car args) 'ignore))
    (setq args (cdr args))))

(defun maybe-bind (args)
  (mapcar (lambda (var) (unless (boundp var) (set var nil))) args))

(maybe-fbind '(Info-directory
	       Info-menu clear-string cp-supported-codepages create-image
	       custom-autoload display-graphic-p display-time-event-handler
	       epg-check-configuration find-coding-system find-image
	       help-buffer image-size image-type-available-p insert-image
	       line-number-at-pos make-mode-line-mouse-map make-network-process
	       make-temp-file propertize put-image rmail-msg-is-pruned
	       rmail-msg-restore-non-pruned-header sort-coding-systems
	       tool-bar-add-item tool-bar-add-item-from-menu
	       tool-bar-local-item-from-menu unicode-precedence-list
	       url-generic-parse-url url-http-file-exists-p
	       url-insert-file-contents vcard-pretty-print w32-focus-frame
	       w3m-detect-meta-charset w3m-region x-focus-frame))
(maybe-bind '(eudc-protocol
	      filladapt-mode help-xref-stack-item
	      rmail-insert-mime-forwarded-message-function url-version
	      w3-meta-charset-content-type-regexp
	      w3-meta-content-type-charset-regexp))

(if (featurep 'xemacs)
    (progn
      (maybe-fbind '(codepage-setup
		     delete-overlay detect-coding-string display-images-p
		     eudc-expand-inline event-click-count event-end event-start
		     find-coding-systems-for-charsets
		     find-coding-systems-region find-coding-systems-string
		     mail-abbrevs-setup mouse-minibuffer-check mouse-movement-p
		     mouse-scroll-subr overlay-lists posn-point posn-window
		     read-event set-buffer-multibyte
		     select-frame-set-input-focus select-safe-coding-system
		     string-as-multibyte timer-set-function track-mouse
		     window-edges))
      (maybe-bind '(adaptive-fill-first-line-regexp
		    buffer-display-table buffer-file-coding-system
		    current-language-environment cursor-in-non-selected-windows
		    default-enable-multibyte-characters
		    default-file-name-coding-system enable-multibyte-characters
		    gnus-agent-expire-current-dirs anguage-info-alist
		    line-spacing mark-active mouse-selection-click-count
		    mouse-selection-click-count-buffer pgg-parse-crc24
		    show-trailing-whitespace temporary-file-directory
		    timer-list tool-bar-mode transient-mark-mode)))
  (maybe-fbind '(bbdb-complete-name
		 delete-annotation delete-extent device-connection dfw-device
		 events-to-keys find-face font-lock-set-defaults frame-device
		 get-char-table glyph-height glyph-width ldap-search-entries
		 mail-aliases-setup make-annotation make-event make-glyph
		 map-extents message-xmas-redefine put-char-table
		 run-mode-hooks set-extent-property set-itimer-function
		 set-keymap-default-binding temp-directory
		 valid-image-instantiator-format-p
		 w3-coding-system-for-mime-charset w3-do-setup
		 w3-prepare-buffer w3-region window-pixel-height
		 window-pixel-width))
  (maybe-bind '(help-echo-owns-message
		itimer-list mail-mode-hook mm-w3m-mode-map nobreak-char-display
		show-nonbreak-escape)))

(when (and (featurep 'xemacs)
	   (not (featurep 'mule)))
  (maybe-fbind '(ccl-execute-on-string
		 char-charset charsetp coding-system-get find-charset-region
		 get-charset-property pgg-parse-crc24-string))
  (maybe-bind '(language-info-alist))
  (unless (featurep 'file-coding)
    (maybe-fbind '(coding-system-base
		   coding-system-change-eol-conversion coding-system-list
		   coding-system-p decode-coding-region decode-coding-string
		   detect-coding-region encode-coding-region
		   encode-coding-string))
    (maybe-bind '(coding-system-for-read
		  coding-system-for-write file-name-coding-system))))

(defun nnkiboze-score-file (a)
  )

(defun split-line (&optional arg)
  )

(provide 'lpath)

;;; arch-tag: d1ad864f-dca6-4d21-aa3f-be3248e66dba
