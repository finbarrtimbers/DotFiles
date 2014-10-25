(load "/usr/local/Cellar/auctex/11.87/share/emacs/site-lisp/auctex.el" nil t t)
(load "/usr/local/Cellar/auctex/11.87/share/emacs/site-lisp/preview-latex.el" nil t t)
;;Syntax Higlight
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)

;; Math Mode
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(setq LaTeX-item-indent 0
	  LaTeX-indent-level 4
	  TeX-PDF-mode t
          )

(provide 'latex-settings)
