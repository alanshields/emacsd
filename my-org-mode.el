(load "more-my-org-mode/org-mac-message")

(when (file-exists-p "~/steelhead")
  (let ((org-mac-mail-account "spawnordie"))
    (global-set-key "\C-cm" 
                    'org-mac-message-insert-selected)))

(setq org-todo-keywords
      '((sequence "TODO(t!)" "INPROGRESS(p!)" "WAIT(w@/!)" "FIXME(f)" "FUTURE(u@!)" "|" "DONE(d@/!)" "CANCELED(c@)")))