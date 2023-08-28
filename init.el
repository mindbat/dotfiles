(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)
(package-install 'use-package)

;; Don't want none of them files without a dangling newline now
(setq require-final-newline t)

(setq make-backup-files nil)

(show-paren-mode 1)

(global-display-line-numbers-mode)

;; no tabs, please
(setq-default indent-tabs-mode nil)

;; always split vertical
(setq split-width-threshold 160)
(setq split-height-threshold nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; eldoc gets out of hand sometimes
(setq eldoc-echo-area-use-multiline-p nil)

(require 'clojure-mode)

;; needed for git-gutter to keep working
;; see: https://github.com/emacs-mirror/emacs/blob/c4e038c7be38b2e6cf2d2c7c39264f068f789c02/etc/NEWS.29#L494
;; and: https://github.com/emacsorphanage/git-gutter/issues/226
(require 'linum)

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
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)
     (define-key paredit-mode-map (kbd "RET") nil)))

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

(load-theme 'zenburn t)

;; Automagically revert all buffers
(global-auto-revert-mode 1)

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-agenda-files (quote ("~/Code/worknotes")))

;; rust-lang
(require 'use-package)
;;(use-package racer
;;  :ensure t
;;  :init
;;  (progn
;;    (add-hook 'racer-mode-hook #'eldoc-mode)))

(use-package rust-mode
  :ensure t
  :init
  (progn
    ;;(add-hook 'rust-mode-hook #'racer-mode)
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
   '(ac-etags salt-mode git-link zerodark-theme flycheck-clojure flycheck-haskell flycheck-julia zenburn-theme yaml-mode use-package terraform-mode racer paredit markdown-mode magit json-mode js2-mode go-mode git-gutter flycheck-rust cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
