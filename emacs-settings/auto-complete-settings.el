;-------------------;
;;; Auto-Complete ;;;
;-------------------;

(setq ac-directory (make-elget-path "auto-complete"))
(add-to-list 'load-path ac-directory)
(require 'auto-complete) 
(add-to-list 'ac-dictionary-directories (concat ac-directory "ac-dict"))
(require 'auto-complete-config) 
(ac-config-default)
(global-auto-complete-mode 1)

;; Unbind M-h and set it to automatically help w/ commands 
 (defalias 'h 'ac-quick-help)

;; Add support for NREPL (clojure)
(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))


(provide 'auto-complete-settings)
