;; disable startup message 
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
 
;; initial window size
(add-to-list 'default-frame-alist '(width  . 120))
(add-to-list 'default-frame-alist '(height . 65))
(add-to-list 'default-frame-alist '(left . 790))
(add-to-list 'default-frame-alist '(top . 0))

;; favorite themes:  '('clarity 'pierson 'cobalt 'renegade 'resolve 'robin-hood 'julie 'subdued 'railcast))
;(setq current-theme 'pierson)
(setq current-theme 'leuven)
(set-face-attribute 'org-agenda-date nil :height 90) ; 9 pt font.           

(load-theme current-theme  t t)
(enable-theme current-theme)

(when (featurep 'ns)
  (defun ns-raise-emacs ()
    "Raise Emacs."
    (ns-do-applescript "tell application \"Emacs\" to activate"))

  (defun ns-raise-emacs-with-frame (frame)
    "Raise Emacs and select the provided frame."
    (with-selected-frame frame
      (when (display-graphic-p)
        (ns-raise-emacs))))

  (add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)

  (when (display-graphic-p)
    (ns-raise-emacs)))

;; remember location in files
(setq save-place-file "~/.emacs.d/saveplace") 
(setq-default save-place t)                   
(require 'saveplace)                          


(setq menu-bar-mode nil)
(setq tool-bar-mode nil)
(setq tooltip-mode nil)

 (defun my-terminal-visible-bell ()
   "A friendlier visual bell effect."
   (invert-face 'mode-line)
   (run-with-timer 0.1 nil 'invert-face 'mode-line))
 
 (setq visible-bell       nil
       ring-bell-function #'my-terminal-visible-bell)
