;;; Global
(global-visual-line-mode 1)
(show-paren-mode 1)
(column-number-mode)

;;; text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
  '(lambda() (set-fill-column 90)))

;; smooth-scrolling
(require 'smooth-scroll)
(smooth-scroll-mode 't)
(setq mouse-wheel-progressive-speed 'f) ;; don't accelerate scrolling
(setq smooth-scroll-mode 't)
(setq smooth-scroll/hscroll-step-size 10)
(setq smooth-scroll/vscroll-step-size 10)

;; ido mode for managing buffers
(require 'ido)
(ido-mode t)

;; markdown mode
(load "markdown-mode.el")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; org-mode
(setq org-startup-indented 't)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-archive-location (concat org-archive-dir "/%s_archive::*"))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)
            (set-fill-column 90)))

;; mobileorg settings
(cond (is-home-machine
       (setq org-mobile-inbox-for-pull "~/Dropbox/notes/inbox.org")
       (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
       (setq org-mobile-files '("~/Dropbox/notes" "~/Dropbox/notes/proj"))
       (setq org-return-follows-link 'RET)
       (setq org-log-repeat 'nil)
       (setq org-agenda-files
             (append
              (file-expand-wildcards "~/Dropbox/notes/x-*.org")
              (file-expand-wildcards "~/Dropbox/notes/daily-journal.org")
              (file-expand-wildcards "~/Dropbox/notes/proj/x-*.org")))
       (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'")
       (setq org-agenda-skip-unavailable-files t)
       (setq org-agenda-skip-scheduled-if-done t)
       )
      )

;; org-present
(autoload 'org-present "org-present" nil t)

(eval-after-load "org-present"
  '(progn
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)))))

(require 'epa-file)
(setq epa-file-cache-passphrase-for-symmetric-encryption 't)
(setq epa-file-encrypt-to: "ovi@sofariu.com")

;; setup files ending in “.gpg” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . org-mode))

; scheme and gradle modes for files:
(add-to-list 'auto-mode-alist '("\\.gradle" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.rkt" . scheme-mode))

;; geiser
(setq geiser-active-implementations '(racket))
(lispy-parens)

;; flyspell
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq ispell-silently-savep t)

(dolist (hook '(org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(setq evil-emacs-state-cursor '(box "green")
      evil-normal-state-cursor '(box "purple"))

(evil-mode)
(global-evil-leader-mode)
(require 'evil-org)

