(require 'server)
(unless (server-running-p)
  (server-start))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

 
(load "~/.emacs.d/functions.el")
(load "~/.emacs.d/abbrevs.el")
(load-directory "~/.emacs.d/config")



