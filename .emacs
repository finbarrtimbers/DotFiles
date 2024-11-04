;; Initialize package system
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Configure use-package to use straight.el by default
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Core packages
(use-package s :straight t)
(use-package dash :straight t)
(use-package editorconfig :straight t)
(use-package jsonrpc :straight t)

;; Python development environment
(use-package lsp-mode
  :straight t
  :commands lsp)

(use-package lsp-ui
  :straight t
  :commands lsp-ui-mode)

(use-package lsp-pyright
  :straight t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

(use-package reformatter
  :straight t
  :hook 
  (python-mode . ruff-format-on-save-mode)
  (python-ts-mode . ruff-format-on-save-mode)
  :config
  (reformatter-define ruff-format
    :program "ruff"
    :args `("format" "--stdin-filename" ,buffer-file-name "-")))

;; Python specific settings
(use-package python
  :custom
  (python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))
  :hook
  (python-base-mode . flymake-mode))

;; UI Preferences
(menu-bar-mode -1)
(setq column-number-mode t)
(icomplete-mode 1)
(setq completion-show-help nil)

;; Version Control settings
(setq vc-follow-symlinks t)

;; Custom keybindings
(global-set-key (kbd "C-x C-g") 'goto-line)

;; Enable region case commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Keep custom settings in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
