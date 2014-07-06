(add-to-list 'load-path "~/elisp")
(require 'screenwriter)
(global-set-key (kbd "<f5>")   'screenwriter-mode)
(setq auto-mode-alist (cons '("\\.scp" . screenwriter-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.screenplay" . screenwriter-mode) auto-mode-alist))

(provide 'writing)
