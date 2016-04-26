(setq org-startup-indented 't)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-archive-location (concat org-archive-dir "/%s_archive::"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n %i\n %a")
        ("n" "Notes" entry (file+datetree (concat org-directory "/notes.org")) 
         "* %^{Description} %^g 
         %? 
         Added: %U") 
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org")
         "* %?\nEntered on %U\n %i\n %a"))))
      
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)
            (set-fill-column 90)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 4)))

(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
(setq org-completion-use-ido t)                       ; try this
;; mobileorg settings
(cond (is-home-machine
       (setq org-mobile-inbox-for-pull (concat org-directory "/inbox.org"))
       (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
       (setq org-mobile-files '("~/Dropbox/notes" "~/Dropbox/notes/z-proj"))
       (setq org-return-follows-link 'RET)
       (setq org-log-repeat 'nil)
       (setq org-agenda-files
              (file-expand-wildcards (concat org-directory "/*.org")))
       (setq org-refile-files org-agenda-files)
       (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'")
       (setq org-agenda-skip-unavailable-files t)
       (setq org-agenda-skip-scheduled-if-done t)
       )
      (else
       (setq org-refile-files (file-expand-windcards (concat org-directory "/*.org"))))
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
