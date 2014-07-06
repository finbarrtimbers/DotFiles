(require 'go-mode)

;; run gofmt before save
(add-hook 'before-save-hook 'gofmt-before-save)


(provide 'go-settings)
