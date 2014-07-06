;; Enable eldoc in Clojure buffers
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; Hides the NREPL buffers
(setq nrepl-hide-special-buffers t)
;; Removes the result prefix
;(set cider-interactive-eval-result-prefix "")
;; Makes the REPL history wrap around when its end is reached 
(setq cider-repl-wrap-history t)
;; Colors parentheses according to depth 
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(provide 'clojure-settings)
