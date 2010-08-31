(load "more-my-org-mode/org-mac-message")

(defun commafy-number (n)
  "Put commas in an integer"
  (let ((chunks ()))
    (do ((chunk (mod (abs n) 1000) (mod rest 1000))
         (rest (floor (abs n) 1000) (floor rest 1000)))
        ((and (zerop chunk) (zerop rest)))
      (push (number-to-string chunk) chunks)
      (when (< chunk 100) (push "0" chunks))
      (when (< chunk 10) (push "0" chunks))
      (when (plusp rest) (push "," chunks)))
    (while (string= (first chunks) "0") (pop chunks))
    (when (minusp n) (push "-" chunks))
    (apply 'concat chunks)))

(defun uncommafy-number (str)
  (if (numberp str)
      str
    (float (string-to-number (remove ?, str)))))

(when (file-exists-p "~/steelhead")
  (let ((org-mac-mail-account "spawnordie"))
    (global-set-key "\C-cm" 
                    'org-mac-message-insert-selected)))

(setq org-todo-keywords
      '((sequence "TODO(t!)" "INPROGRESS(p!)" "WAIT(w@/!)" "FIXME(f)" "FUTURE(u@!)" "|" "DONE(d@/!)" "CANCELED(c@!)")))

(defun send-rhi-email (email-text email-subject)
  (let ((email-text (concat email-text "\nThanks,\nAlan")))
    (do-applescript
     (concat
      "tell application \"Mail\"\n"
         "set theMessage to make new outgoing message with properties {subject:\"" email-subject "\", content:\"" email-text "\", visible:true}\n"
         "tell theMessage\n"
            "make new to recipient with properties {name:\"Tracy Weber\", address:\"tracyw@spawnordie.com\"}\n"
            "make new to recipient with properties {name:\"Prateek Sharma\", address:\"teek@spawnordie.com\"}\n"
            "make new to recipient with properties {name:\"Chad Meek\", address:\"chad.meek@rht.com\"}\n"
         "end tell\n"
      "end tell\n"))))

(defun send-timesheet (&optional p)
  (interactive "P")
  "Sends the current table as a timesheet to Steelhead"
  (let ((org-enable-table-editor t))
    (if (not (org-at-table-p))
        (error "Must be used in a table")
      (save-excursion
        (let* ((beg (org-table-begin))
               (end (org-table-end))
               (timesheet (buffer-substring beg end)))
          (send-rhi-email timesheet "Hours for the week of XXXX"))))))
  

(provide 'my-org-mode)