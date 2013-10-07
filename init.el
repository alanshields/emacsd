(setq visible-bell t)

(prefer-coding-system 'utf-8)

(add-to-list 'load-path "~/.emacs.d")

(dynamic-completion-mode)

(if (boundp tool-bar-mode)
    (tool-bar-mode 0))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      nrepl))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; ctrl-z goes to eshell, not shell. ctrl-x ctrl-z still goes to shell
(global-set-key (kbd "C-z") 'eshell)


(put 'narrow-to-page 'disabled nil)

;; eshell stuff
(add-hook 'eshell-mode-hook
          '(progn
             (defun eshell-maybe-bol ()
               (interactive)
               (let ((p (point)))
                 (eshell-bol)
                 (if (= p (point))
                     (beginning-of-line))))
             '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Inconsolata"))))
 '(mmm-output-submode-face ((t (:background "FloralWhite" :foreground "forestgreen")))))

; no menu bar. Werd.
(when (not t)
  (menu-bar-mode nil))

(require 'uniquify)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(coffee-tab-width 2)
 '(cperl-auto-newline nil)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(exec-path (quote ("/usr/texbin" "/usr/bin" "/bin" "/opt/local/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 4)
 '(ns-alternate-modifier (quote super))
 '(ns-command-modifier (quote meta))
 '(org-agenda-files nil)
 '(rails-use-indent-and-complete nil)
 '(safe-local-variable-values (quote ((lua-indent-level . 4))))
 '(sentence-end-double-space nil)
 '(should-untabify nil)
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))


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

(put 'narrow-to-region 'disabled nil)

(defun remove-leading-and-trailing-whitespace (start end)
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-max))
      ; trim trailing whitespace
      (skip-syntax-backward " ")
      (delete-region (point) (point-max))
      ; trim leading whitespace
      (goto-char (point-min))
      (skip-syntax-forward " ")
      (delete-region (point-min) (point)))))

(defun my-chomp (str)
  "..."
  (save-excursion
    (with-temp-buffer
      (insert str)
      (remove-leading-and-trailing-whitespace (point-min) (point-max))
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun length-after-tab-expansion (str)
  (let ((len 0))
    (dotimes (i (length str))
      (if (= ?\t (elt str i))
          (setq len (+ len tab-width))
        (setq len (+ len 1))))
    len))

(defun align-table (start end)
  "Aligns text in the region in a table format split by ,"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (delete-trailing-whitespace)
      (cl-flet ((split-this-line ()
                              (save-excursion
                                (beginning-of-line)
                                (split-string (buffer-substring-no-properties (point) (line-end-position)) "," nil)))
             (trimmed-lengths (list-of-columns) ; first column is not trimmed
                              (let ((accum nil))
                                (dotimes (i (length list-of-columns))
                                  (let ((len (if (zerop i)
                                                 (length-after-tab-expansion (elt list-of-columns i))
                                               (length (my-chomp (elt list-of-columns i))))))
                                    (setq accum (cons len accum))))
                                (reverse accum))))
        (let ((all-lengths (let ((lengths (list)))
                             (save-excursion
                               (while (not (= (point-max) (point)))
                                 (setq lengths (cons
                                                (trimmed-lengths (split-this-line))
                                                lengths))
                                 (forward-line)))
                             lengths)))
          (let ((max-lengths (reduce
                              (lambda (list-a list-b)
                                (mapcar (lambda (nth)
                                          (max (or (elt list-a nth) 0)
                                               (or (elt list-b nth) 0)))
                                        (number-sequence 0 (max 0
                                                                (1- (max (length list-a)
                                                                         (length list-b)))))))
                              all-lengths)))
            (save-excursion
              (goto-char (point-min))
              (let ((first-line-p 1))
                (while (not (= (point-max) (point)))
                                        ;(when (not first-line-p)
                                        ;1) ; indent
                  (let ((column-number 0))
                    (while (search-forward "," (line-end-position) t)
                      (when (not (zerop column-number)) ; first column is only indented, not trimmed
                        (let ((column-starting-position (save-excursion
                                                          (goto-char (1- (point)))
                                                          (search-backward "," (line-beginning-position) t)
                                                          (1+ (point))))
                              (column-ending-position (1- (point))))
                          (remove-leading-and-trailing-whitespace column-starting-position column-ending-position)
                          (save-excursion
                            (let ((column-starting-position (save-excursion
                                                              (goto-char (1- (point)))
                                                              (search-backward "," (line-beginning-position) t)
                                                              (1+ (point))))
                                  (column-ending-position (1- (point))))
                              (let ((cur-length (- column-ending-position column-starting-position)))
                                (let ((indent-deficit (+ 1 ; 1 mandatory padding
                                                         (- (elt max-lengths column-number) cur-length) ; difference
                                                         (if (= 1 column-number)
                                                             (save-excursion
                                                               (goto-char (line-beginning-position))
                                                               (search-forward "," (line-end-position) t)
                                                               (- (elt max-lengths 0)
                                                                  (length-after-tab-expansion (buffer-substring-no-properties (1- (point)) (line-beginning-position)))))
                                                           0))))
                                  (goto-char column-starting-position)
                                  (dotimes (i indent-deficit)
                                    (insert " "))))))))
                      (setq column-number (1+ column-number))))
                  (setq first-line-p 0)
                  (forward-line))))))))))

(defun align-php-assign (beg end)
  "Align a typical PHP assignment block (aligns along = and =>)"
  (interactive "r")
  (align-regexp beg end "\\(\\s-*\\)\\(=>\\|=\\)" 1 1 nil))

(defun calc-update-embedded (&optional arg end obeg oend)
  "Starts then immediately stops Calc Embedded mode to update a formula"
  (interactive "P")
  (require 'calc-ext)
  (calc-do-embedded arg end obeg oend)
  (calc-do-embedded arg end obeg oend))

(defun re-search-overlap (regexp &optional noerror)
  "Find the first match overlapping the current position"
  (interactive "M")
  (let ((eol (line-end-position))
        (curpos (point))
        found)
    (goto-char (line-beginning-position))
    (while (and (not found)
                (re-search-forward regexp eol t))
      (when (and (<= (match-beginning 0) curpos)
               (>= (match-end 0) curpos))
        (setq found t)))
    (if found
        found
      (if noerror
          nil
        (error "Could not find %s overlapping current position" regexp)))))

(defun informal-to-calc-format (&optional arg end obeg oend)
  "Take /* math */ at point and convert it to /*$ math => 0 $*/"
  (interactive "P")
  (save-excursion
    (when (not (re-search-overlap "/\\*.*?\\*/" t))
      (error "Could not find /* math */"))
    (save-restriction
      (narrow-to-region (+ 2 (match-beginning 0)) (- (match-end 0) 2))
      (replace-string "$" "" nil (point-min) (point-max)) ;; get rid of dollar signs like $5
      (goto-char (point-min))
      (insert "$")
      (goto-char (point-max))
      (insert " => 0 $")
      (goto-char (- (point-max) 4)))
    (calc-update-embedded)))

(defun flip-region (&optional start end)
  (interactive "r")
  (let* ((contents (buffer-substring start end))
         (reversed (concat (reverse (string-to-list contents)))))
    (delete-region start end)
    (insert reversed)))

;; Steelhead specific configurations
(when (file-exists-p "~/steelhead")
  (load "steelhead.el"))
(put 'downcase-region 'disabled nil)

(setq-default ispell-program-name "/usr/local/bin/aspell")
