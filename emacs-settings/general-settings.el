; truncate lines even in partial-width windows
(setq truncate-partial-width-windows 1)

; always use spaces, not tabs, when indenting
(setq-default indent-tabs-mode nil)

; ignore case when searching
(setq-default case-fold-search 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Cause different layers of parenthese inemacs to be colored differently. 
;;(require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode)

;;Make a dedicated backup folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )
    (setq auto-save-file-name-transforms
          `((".*" ,"~/.emacs.d/auto-save" t)))


;; Load additional package managers
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(define-key global-map (kbd "RET") 'newline-and-indent)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(provide 'general-settings)
