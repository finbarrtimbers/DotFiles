
;ess-mode configuration
(setq ess-ask-for-ess-directory nil)
(setq inferior-R-program-name "/usr/local/bin/R")
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(setq ess-eval-visibly-p nil)
(setq ess-toggle-underscore nil)
(require 'ess-site)


(provide 'r-settings)
