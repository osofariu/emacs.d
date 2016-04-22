;; --- .emacs:

;; Prevent accidentally killing emacs.
(global-set-key [(control x) (control c)]
		'(lambda ()
		   (interactive)
		   (if (y-or-n-p-with-timeout "Exit Emacs ? " 4 nil)
		       (save-buffers-kill-emacs))))

(fset 'save-encrypt
   [?\C-x ?\C-s tab tab tab ?m tab tab tab return])
 
(global-set-key (kbd "C-c s") 'save-encrypt)

;(add-hook 'org-mode-hook
;         (lambda () (if (file-name-extension (buffer-file-name))
;                       (local-set-key (kbd "C-x s") 'save-encrypt))))


(fset 'insert-after-node
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([C-return M-down] 0 "%d")) arg)))

(define-key global-map (kbd "<C-M-return>") 'insert-after-node)

;; re-map control to command on OSX
(setq mac-command-modifier 'control)

;; editing
(setq-default indent-tabs-mode nil)


(global-set-key [(control c) (control r)] 'reload-current-buffer)

;; --- functions.el:

(global-set-key "\C-cd" 'insert-current-date)
(global-set-key "\C-cD" 'insert-current-date-time)
(global-set-key "\C-cT" 'insert-current-time)

;; --- abbrevs.el:
;(global-set-key "\C-cJ" 'daily-entry)
(global-set-key "\C-cJ" 'insert-daily-entry)

(global-set-key (kbd "<f8>") 'ispell-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word))
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

;; use mouse-3 to spell word under cursor
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))

(global-set-key (kbd "<f9>") 'ispell)

;; magit
(global-set-key [(control c)(control g)] 'magit-status)
