(require 'cc-mode)

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(defun compile-hook ()
    (local-set-key (kbd "C-c C-c") 'compile))

(add-hook 'c++-mode-hook 'compile-hook)

(provide 'c-settings)
