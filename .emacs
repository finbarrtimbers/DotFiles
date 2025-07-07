;; Suppress user-emacs-directory warning
(setq user-emacs-directory-warning nil)
(setq vc-follow-symlinks t)

;; Performance optimizations
(setq gc-cons-threshold 100000000)  ;; Increase garbage collection threshold
(setq read-process-output-max (* 1024 1024)) ;; 1mb - helps with LSP performance

;; Make every interface talk UTF-8, kills the char-or-string-p 134217826 error
(set-language-environment "UTF-8")
(setq locale-coding-system         'utf-8
      selection-coding-system      'utf-8
      keyboard-coding-system       'utf-8)
(when (not (display-graphic-p))    ; needed only for tty Emacs
  (set-terminal-coding-system 'utf-8))
(prefer-coding-system 'utf-8)

;; Display and rendering fixes
(setq-default bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)
(setq-default tab-width 4)
(setq redisplay-dont-pause t)
(setq jit-lock-defer-time 0)

;; Font settings - uncomment and modify if needed
;; (when (member "Fira Code" (font-family-list))
;;   (set-frame-font "Fira Code-12"))
;; If you don't have Fira Code, try another monospace font:
(set-frame-font "Monospace-12")

;; Fix TLS issue
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Server configuration
(require 'server)
(if (not (server-running-p))
    (server-start))

;; Package management setup
(require 'package)
(setq package-list '(s dash editorconfig use-package jsonrpc
                      lsp-mode lsp-ui lsp-pyright reformatter))

;; Package repositories
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; Initialize and ensure packages are installed
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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

;; Ensure use-package is available
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Configure LSP mode with better defaults
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((python-mode . lsp-deferred)
         (python-ts-mode . lsp-deferred))
  :custom
  ;; Performance tweaks
  (lsp-idle-delay 0.5)
  (lsp-log-io nil)
  (lsp-completion-provider :capf)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-keep-workspace-alive nil)
  (lsp-enable-symbol-highlighting nil)
  (lsp-enable-links nil)
  (setq lsp-file-watch-threshold 20000)
  (lsp-signature-auto-activate nil))

;; Configure LSP UI for minimal interference with Copilot
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-show-code-actions nil))

;; LSP Pyright configuration
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Reformatter for Python
(use-package reformatter
  :hook 
  (python-mode . ruff-format-on-save-mode)
  (python-ts-mode . ruff-format-on-save-mode)
  :config
  (reformatter-define ruff-format
    :program "ruff"
    :args `("format" "--stdin-filename" ,buffer-file-name "-")))

;; Copilot setup with improved integration
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("dist" "*.el"))
  :hook (prog-mode . copilot-mode)
  :custom
  (copilot-indent-offset 4)
  (copilot-idle-delay 0.2)
  :config
  ;; Prevent overlapping completion displays
  (advice-add 'copilot--display-overlay :before
              (lambda (&rest _) 
                (remove-overlays (point) (line-end-position) 'category 'copilot)))
  
  ;; Higher priority to ensure copilot overlays are visible
  (setq copilot-overlay-priority 100))

;; Improved Copilot keybindings that work well with LSP
(with-eval-after-load 'copilot
  ;; Smarter TAB completion that works with both systems
  (defun rk/copilot-tab ()
    "Tab command that will complete with copilot if a completion is available.
Otherwise will try company, yasnippet or normal tab-indent."
    (interactive)
    (or (copilot-accept-completion)
        (indent-for-tab-command)))
  
  ;; Define a function to complete or accept completion
  (defun rk/copilot-complete-or-accept ()
    "Command that either triggers a completion or accepts one if available."
    (interactive)
    (if (copilot--overlay-visible)
        (progn
          (copilot-accept-completion)
          (open-line 1)
          (next-line))
      (copilot-complete)))
  
  ;; Key bindings
  (define-key copilot-mode-map (kbd "TAB") #'rk/copilot-tab)
  (define-key copilot-mode-map (kbd "C-<tab>") #'copilot-accept-completion)
  (define-key global-map (kbd "M-C-<return>") #'rk/copilot-complete-or-accept))

;; UI settings
(menu-bar-mode -1)
;; Only use GUI elements if they're available
(when (display-graphic-p)
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1)))
(setq column-number-mode t)
(icomplete-mode 1)
(setq completion-show-help nil)

;; Global keybindings
(global-set-key (kbd "C-x C-g") 'goto-line)
(setq vc-follow-symlinks t)

;; Python-specific settings
(add-hook 'python-base-mode-hook 'flymake-mode)
(setq python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))

;; Custom variables (kept from your original config)
(custom-set-variables
 '(package-selected-packages (quote (dash s format-all auto-complete markdown-mode))))
(custom-set-faces)

;; Enable useful operations
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Reduce memory footprint when done loading
(add-hook 'after-init-hook #'(lambda () (setq gc-cons-threshold 800000)))
