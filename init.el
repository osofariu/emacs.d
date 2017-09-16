(setq org-directory "~/Dropbox/notes")
(setq org-archive-dir "~/Dropbox/notes/archive")
(setq is-home-machine nil)

;; TODO commit the version on my work machine and push

(cond ((equal (system-name) "Cato.local") ;; HOME
       (add-to-list 'default-frame-alist '(font . "Monaco-12"))
       (setq is-home-machine t))
      
      ((equal (substring (downcase (system-name)) 0 6) "oliver") ;; WORK
       (add-to-list 'default-frame-alist '(font . "Monaco-12"))
       (setq is-home-machine nil)
       (setq org-directory "~/Dropbox/notes/work")
       (setq org-archive-dir "~/Dropbox/notes/work/archive"))
      ((equal (system-name) "artemis") ;; LINUX VM
       (setq is-home-machine nil)))
       
(setq custom-file "~/.emacs.d/custom.el")

(require 'package)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)


;;; Add locations to load-path
(add-to-list 'load-path "/usr/share/emacs/site-lisp")
 
;; color-theme
;(require 'color-theme)
         
(setq ess-r-versions nil) ;; *BEFORE* ess-site is loaded (!)

;; active Babel languages
(org-babel-do-load-languages
   'org-babel-load-languages
   '((sh         . t)
     (js         . t)
     (emacs-lisp . t)
     (perl       . t)
     (scala      . t)
     (clojure    . t)
     (python     . t)
     (ruby       . t)
     (css        . t)))

(require 'htmlize)
;(require 'ob-scala)

(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/abbrevs.el")
(load-directory "~/.emacs.d/config")

(require 'server)
(unless (server-running-p)
  (server-start))
