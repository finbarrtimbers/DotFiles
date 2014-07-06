;; joining && autojoing

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
	    '((".*\\.freenode.net" )
		       (".*\\.gimp.org" "#unix" "#gtk+")))
