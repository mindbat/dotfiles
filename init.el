(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Don't want none of them files without a dangling newline now
(setq require-final-newline t)

(setq make-backup-files nil)

(show-paren-mode 1)

(global-display-line-numbers-mode)

;; no tabs, please
(setq indent-tabs-mode nil)

;; always split vertical
(setq split-width-threshold 160)
(setq split-height-threshold nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'load-path "~/.emacs.d/modes/clojure-mode")

(require 'clojure-mode)

(eval-after-load 'clojure-mode
  '(progn
     (remove-hook 'slime-indentation-update-hooks 'put-clojure-indent)))

(setq cider-show-error-buffer nil)
(setq cider-prompt-for-symbol nil)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'git-gutter-mode)

(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

(add-hook 'cider-repl-mode-hook #'paredit-mode)

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

;;(load-theme 'zenburn t)

;; Automagically revert all buffers
(global-auto-revert-mode 1)

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-agenda-files (append (directory-files-recursively "~/Code/worknotes" "org$")))

;; rust-lang
(require 'use-package)
(use-package racer
  :ensure t
  :init
  (progn
    (add-hook 'racer-mode-hook #'eldoc-mode)))

(use-package rust-mode
  :ensure t
  :init
  (progn
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'rust-mode #'git-gutter-mode)
    (add-hook
     'rust-mode-hook
     (lambda ()
       (local-set-key (kbd "C-c n") #'rust-format-buffer)
       (local-set-key (kbd "C-c C-k") #'rust-compile)))))

(use-package flycheck-rust
  :ensure t
  :defer t
  :after rust-mode
  :init
  (progn
    (add-hook
     'flycheck-mode-hook #'flycheck-rust-setup)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-rust racer go-mode terraform-mode cider zenburn-theme yaml-mode rust-mode paredit markdown-mode magit git-gutter clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
