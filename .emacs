;; path where settings files are kept
(add-to-list 'load-path "~/.emacs.d/settings")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; global config variables
(setq plugin-path "~/.emacs.d/plugins/")
(setq elget-path "~/.emacs.d/el-get/")

;; various generic/global config
(require 'custom-functions)
(require 'general-settings)

;----------------------;
;;; Standalone tools ;;;
;----------------------;

;; el-get
(include-plugin "el-get")
(require 'el-get)

;; Git
(include-plugin "magit")
(require 'magit)



;---------------;
;;; Utilities ;;;
;---------------;

;; Popup
(include-elget-plugin "popup")
(require 'popup)

;; Websocket
(include-plugin "websocket")
(require 'websocket)

;; Request
(include-plugin "request")
(require 'request)

;; Auto complete
(require 'auto-complete-settings)

;----------------------;
;;; Settings         ;;;
;----------------------;

;;Better defaults
(require' better-defaults)

;;Custom hotkeys
(require' hotkeys)

;; UI Settings
(require 'ui-settings)

;; General Settings
(require 'general-settings)


;-----------;
;;; Modes ;;;
;-----------;

;; Ido mode
(require 'ido)
(ido-mode 1)

;; Markdown mode
(require 'markdown-settings)

;; Python mode 
(require 'python-settings)

;; LaTeX and Auctex
(require 'latex-settings)

;; Clojure mode
(require 'clojure-settings)

;; Matlab mode
(require 'matlab-settings)


;; C/C++ mode
(require 'c-settings)

;; Haskell mode
(require 'haskell-settings)


;---------------------------------------------------------------------
;; Put auto 'custom' changes in a separate file (this is stuff like
;; custom-set-faces and custom-set-variables)
(load 
 (setq custom-file (expand-file-name "settings/custom.el" user-emacs-directory))
 'noerror)
