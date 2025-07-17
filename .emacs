;; -*- lexical-binding: t; -*-

;;; ---------------------------------------------------------------------------
;;;  Disable GPG sig checking (work-around for archive-contents.sig failures)
;;; ---------------------------------------------------------------------------

(setq package-check-signature nil)   ;; re-enable later if you install GPG keys

;;; ---------------------------------------------------------------------------
;;;  Core tweaks
;;; ---------------------------------------------------------------------------

(setq gc-cons-threshold         (* 100 1024 1024)
      read-process-output-max   (* 1024 1024)
      bidi-paragraph-direction  'left-to-right
      bidi-inhibit-bpa          t
      redisplay-dont-pause      t
      jit-lock-defer-time       0
      vc-follow-symlinks        t
      warning-suppress-types    '((files user-emacs-directory)))

;;; ---------------------------------------------------------------------------
;;;  UTF-8 everywhere
;;; ---------------------------------------------------------------------------

(set-language-environment "UTF-8")
(setq locale-coding-system     'utf-8
      selection-coding-system  'utf-8
      keyboard-coding-system   'utf-8)
(prefer-coding-system 'utf-8)
(unless (display-graphic-p)
  (set-terminal-coding-system 'utf-8))

;;; ---------------------------------------------------------------------------
;;;  Display
;;; ---------------------------------------------------------------------------

(when (display-graphic-p)
  (ignore-errors
    (set-frame-font "Monospace-12" t t))
  (tool-bar-mode   -1)
  (scroll-bar-mode -1))
(menu-bar-mode -1)
(column-number-mode 1)
(icomplete-mode 1)
(setq completion-show-help nil
      tab-width 4)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;;; ---------------------------------------------------------------------------
;;;  Server
;;; ---------------------------------------------------------------------------

(require 'server)
(unless (server-running-p) (server-start))

;;; ---------------------------------------------------------------------------
;;;  package.el + use-package
;;; ---------------------------------------------------------------------------

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

;;; ---------------------------------------------------------------------------
;;;  Utility libs
;;; ---------------------------------------------------------------------------

(use-package s)
(use-package dash)
(use-package jsonrpc)

;;; ---------------------------------------------------------------------------
;;;  LSP stack
;;; ---------------------------------------------------------------------------

(use-package lsp-mode
  :hook ((python-mode python-ts-mode) . lsp-deferred)
  :custom
  (lsp-idle-delay                 0.5)
  (lsp-log-io                     nil)
  (lsp-completion-provider        :capf)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-keep-workspace-alive       nil)
  (lsp-enable-symbol-highlighting nil)
  (lsp-enable-links               nil)
  (lsp-file-watch-threshold       20000)
  (lsp-signature-auto-activate    nil))

(use-package lsp-ui
  :after   lsp-mode
  :hook    (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable              nil)
  (lsp-ui-sideline-enable         nil)
  (lsp-ui-sideline-show-code-actions nil))

(use-package lsp-pyright
  :after lsp-mode
  :hook ((python-mode python-ts-mode) . lsp-deferred))

;;; ---------------------------------------------------------------------------
;;;  Ruff formatter + Flymake
;;; ---------------------------------------------------------------------------

(use-package reformatter)

(reformatter-define ruff-format
  :program "ruff"
  :args    (list "format" "--stdin-filename" buffer-file-name "-"))

(defun my/python-ruff-setup ()
  (ruff-format-on-save-mode 1)
  (flymake-mode 1)
  (setq-local python-flymake-command
              '("ruff" "--quiet" "--stdin-filename=stdin" "-")))
(add-hook 'python-mode-hook    #'my/python-ruff-setup)
(add-hook 'python-ts-mode-hook #'my/python-ruff-setup)

;;; ---------------------------------------------------------------------------
;;;  GitHub Copilot
;;; ---------------------------------------------------------------------------

;; Clone https://github.com/copilot-emacs/copilot.el into ~/.emacs.d/site-lisp/copilot
(use-package copilot
  :straight nil
  :load-path "~/.emacs.d/site-lisp/copilot"
  :hook (prog-mode . copilot-mode)
  :custom
  (copilot-indent-offset 4)
  (copilot-idle-delay   0.2)
  :config
  (setq copilot-overlay-priority 100)
  (advice-add 'copilot--display-overlay :before
              (lambda (&rest _)
                (remove-overlays (point) (line-end-position) 'category 'copilot)))
  (define-key copilot-mode-map (kbd "TAB")
    (lambda ()
      (interactive)
      (or (copilot-accept-completion)
          (indent-for-tab-command))))
  (define-key copilot-mode-map (kbd "C-<tab>") #'copilot-accept-completion)
  (global-set-key (kbd "M-C-<return>")
                  (lambda ()
                    (interactive)
                    (if (copilot--overlay-visible)
                        (progn
                          (copilot-accept-completion)
                          (open-line 1)
                          (forward-line 1))
                      (copilot-complete)))))

;;; ---------------------------------------------------------------------------
;;;  Misc
;;; ---------------------------------------------------------------------------

(global-set-key (kbd "C-x C-g") #'goto-line)
(put 'downcase-region 'disabled nil)

(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 8 1024 1024))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(reformatter lsp-pyright lsp-ui lsp-mode use-package s dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
