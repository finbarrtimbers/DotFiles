(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; needed for package management
(require 'package)

; list the packages you want
(setq package-list '(
		     ;; needed for Github Copilot
		     s dash editorconfig use-package jsonrpc
		       lsp-mode lsp-ui lsp-pyright
		     ))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; works well for python
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package reformatter
  :hook 
  (python-mode . ruff-format-on-save-mode)
  (python-ts-mode . ruff-format-on-save-mode)
  :config
  (reformatter-define ruff-format
    :program "ruff"
    :args `("format" "--stdin-filename" ,buffer-file-name "-")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; new package manager (straight.el) bootstrap:
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


;; I don't have a copilot sub, so I"m disabling this.
;; load Github Copilot:
;;(use-package copilot
;;  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
;;  :ensure t)

;;(add-hook 'prog-mode-hook 'copilot-mode)


(defun rk/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one
is available. Useful if you tend to hammer your keys like I do."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))

;;(define-key global-map (kbd "M-C-<return>") #'rk/copilot-complete-or-accept)

(defun rk/copilot-tab ()
  "Tab command that will complete with copilot if a completion is
available. Otherwise will try company, yasnippet or normal
tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (indent-for-tab-command)))

;;(define-key global-map (kbd "TAB") #'rk/copilot-tab)

;; disable the menu bar
(menu-bar-mode -1)

;; show the column number
(setq column-number-mode t)

;; Enable incremental minibuffer completion.
(icomplete-mode 1)
(setq completion-show-help nil)

;; custom keybindings
(global-set-key (kbd "C-x C-g") 'goto-line)

;; never ask if I want to follow a symlink to a vc file
(setq vc-follow-symlinks t)

;; python settings
(add-hook 'python-base-mode-hook 'flymake-mode)
(setq python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))
      
;;(add-hook 'python-mode-hook 'lsp)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (dash s format-all auto-complete markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
