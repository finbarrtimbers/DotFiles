(defalias 'rs 'replace-string)
(defalias 'rr 'replace-regex)
(defalias 'er 'eval-region)
(defalias 'er 'eval-region)

;; Custom Key-Bindings
(global-set-key (kbd "M-{") 'comment-region)
(global-set-key (kbd "M-}") 'uncomment-region)
(global-set-key (kbd "C-q") 'move-beginning-of-line)
(global-set-key (kbd "C-x C-g") 'goto-line)
;;(global-set-key (kbd "C-x C-[ ") 'doc-view-shrink)
;;(global-set-key (kbd "C-x C-] ") 'doc-view-enlarge)




(provide 'hotkeys)
