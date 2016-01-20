(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Don't want none of them files without a dangling newline now
(setq require-final-newline t)

(setq make-backup-files nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'load-path "~/.emacs.d/modes/clojure-mode")
(require 'clojure-mode)

(eval-after-load 'clojure-mode
  '(progn
     (remove-hook 'slime-indentation-update-hooks 'put-clojure-indent)))

(defun run-ns-tests ()
  (interactive)
  (nrepl-load-current-buffer)
  (clojure-jump-to-test)
  (nrepl-load-current-buffer)
  (clojure-test-run-tests)
  (quit-window))
(define-key clojure-mode-map (kbd "C-c ,") 'run-ns-tests)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

(add-hook 'prog-mode-hook (lambda ()
                            (paredit-mode 1)))

;; === qrr is better than query-replace-regexp ===
(defalias 'qrr 'query-replace-regexp)

;; === remapping paredit keys, because emacs is a heart-breaker ===
(require 'paredit)
(define-key paredit-mode-map (kbd "C-o C-r") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-o M-r") 'paredit-forward-barf-sexp)
(define-key paredit-mode-map (kbd "C-o C-l") 'paredit-backward-slurp-sexp)
(define-key paredit-mode-map (kbd "C-o M-l") 'paredit-backward-barf-sexp)

;; Cosmetics for diffs, also contained as part of
;; color-theme-dakrone.el
(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-background 'diff-added "gray10")
     (set-face-foreground 'diff-removed "red3")
     (set-face-background 'diff-removed "gray10")))

(eval-after-load 'hl-line
  '(progn
     (set-face-background 'hl-line nil)
     (set-face-background 'region "gray10")))

(setq ido-enable-flex-matching t)

(load-theme 'zenburn t)

;; Automagically revert all buffers
(global-auto-revert-mode 1)

(global-git-gutter-mode t)
