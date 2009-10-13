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

(provide 'my-org-mode)