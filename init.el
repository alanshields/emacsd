; the colors! My god, the colors!
;(add-to-list 'default-frame-alist '(foreground-color . "white"))
;(add-to-list 'default-frame-alist '(background-color . "black"))
;(add-to-list 'default-frame-alist '(font . "-bitstream-bitstream vera sans mono-medium-r-normal--14-103-98-98-c-84-iso8859-1"))

;; To byte-compile .emacs.d, run this command:
(defun my-byte-compile-initd ()
  (byte-recompile-directory "~/.emacs.d" 0))

(dynamic-completion-mode)

(if (boundp tool-bar-mode)
    (tool-bar-mode 0))

(add-to-list 'load-path "~/.emacs.d")
;(add-to-list 'load-path "~/.emacs.d/emacs-rails")
;(require 'rails)

;; SLIME
(let ((slime-dir "/opt/local/share/emacs/site-lisp/slime"))
  (when (file-exists-p slime-dir)
    (setq load-path (cons slime-dir load-path))
    (require 'slime-autoloads)
    (setq slime-lisp-implementations
	  `((sbcl ("/opt/local/bin/sbcl"))
	    (clisp ("/opt/local/bin/clisp"))))
    (add-hook 'lisp-mode-hook
	      (lambda ()
		(cond ((not (featurep 'slime))
		       (require 'slime) 
		       (normal-mode)))))))

(eval-after-load "slime"
   '(slime-setup '(slime-fancy slime-banner)))

;; SGML stuff
(setq sgml-set-face t)
(setq sgml-auto-activate-dtd t)
(setq sgml-indent-data t)

;; Bigloo's scheme mode
(autoload 'bdb "bdb" "bdb mode" t)
(autoload 'bee-mode "bee-mode" "bee mode" t)

(setq auto-mode-alist
      (append '(("\\.scm$" . bee-mode)
                ("\\.sch$" . bee-mode)
                ("\\.scme$" . bee-mode)
                ("\\.bgl$" . bee-mode)
                ("\\.bee$" . bee-mode))
              auto-mode-alist))


;; Use Windows's meta-return for tag completion
;(byte-compile-file "~/fuzzy_complete.el" t)
;(global-set-key (kbd "ESC RET") 'fuzzy-complete-tag)

;; ctrl-z goes to eshell, not shell. ctrl-x ctrl-z still goes to shell
(global-set-key (kbd "C-z") 'eshell)


;; Tag tables
;;(setq tags-table-list
;;      '("~/Documents/identity/dev-FOAD-1.0"))



(put 'narrow-to-page 'disabled nil)

;; rhtml
(when (and (locate-library "mmm-mode")
	   (locate-library "mmm-settings"))
  (require "mmm-settings"))

(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))

(add-to-list 'auto-mode-alist '("templates/.*\\.html$" . html-mode))

;; eshell stuff
(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))
(add-hook 'eshell-mode-hook
          '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)))

;; Tuareg caMeL mode
;; (add-to-list 'load-path "~/.emacs.d/tuareg/")
;; (setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
;; (autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;;  '(default ((t (:stipple nil :background "#ffffff" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 101 :width normal :family "bitstream-bitstream vera sans mono"))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mmm-output-submode-face ((t (:background "FloralWhite" :foreground "forestgreen")))))

;; color theme time
; (require 'color-theme)
; (color-theme-clarity)
;; goddamn mmm-mode and its non-inheriting faces!
; (set-face-background 'mmm-default-submode-face "dark slate gray")

; no menu bar. Werd.
(when (not t)
  (menu-bar-mode nil))

;; Don't mess with the clean directory unless you have to!
(add-hook 'before-save-hook
          (lambda ()
            (when (string-match "clean_sweetapp" (buffer-file-name))
              (when (not (yes-or-no-p
                          (format "%s is in the clean directory.  Save anyway? "
                                  (buffer-file-name))))
                (error "Save not confirmed")))))

(require 'uniquify)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(cperl-auto-newline nil)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 4)
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(rails-use-indent-and-complete nil)
 '(safe-local-variable-values (quote ((lua-indent-level . 4))))
 '(sentence-end-double-space nil)
 '(should-untabify nil)
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))


;; Gnus!
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/gnus/lisp/"))
;; (require 'gnus-load)
;; (require 'info)
;; (add-to-list 'Info-default-directory-list (expand-file-name "~/.emacs.d/gnus/texi"))

;; bbdb
;; (add-to-list 'load-path "~/.emacs.d/bbdb-2.35/lisp/")
;; (require 'bbdb)
;; (bbdb-initialize 'gnus)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)

;; JSlint
;; (require 'javascript-mode)
;; (setq auto-mode-alist (cons '("\\.js\\'" . javascript-mode)
;;              auto-mode-alist))
(add-to-list 'load-path "~/.emacs.d/js2-mode/build/")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook
  (lambda ()
    ;;; make emacs recognize the error format produced by jslint
    (set (make-local-variable 'compilation-error-regexp-alist)
       '(("^\\([a-zA-Z.0-9_/-]+\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3)))
    (set (make-local-variable 'compile-command)
       (let ((file (file-name-nondirectory buffer-file-name)))
          (concat "/Users/sshields/bin/jslint " file)))))

;; TRAMP debug
;; (require 'tramp)
;; (setq tramp-verbose 6)
;; (setq tramp-debug-buffer t)


;; Org-Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook
          (lambda ()
            (when (not (featurep 'my-org-mode))
              (require 'my-org-mode)
              (when (file-exists-p "~/Documents/sas_timelog")
                (add-to-list 'org-agenda-files "~/Documents/sas_timelog"))
              (org-mode))))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; PHP mode
(load "nxhtml/autostart.el")
; nXhtml has branched off significantly from this by now.
;(load "php-mode-improved.el")
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(put 'narrow-to-region 'disabled nil)


;; Steelhead specific configurations
(when (file-exists-p "~/steelhead")
  (load "steelhead.el"))