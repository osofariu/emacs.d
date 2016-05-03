;; make outline pretty by indenting it
(setq org-startup-indented 't)

(define-key global-map "\C-cl" 'org-store-link)
;; can insert link with <C-C C-L>

(define-key global-map "\C-ca" 'org-agenda)

;; what to log when task done
(setq org-log-done t)
(setq org-log-repeat 'nil)

;; follow links wtith RETURN
(setq org-return-follows-link 'RET)

;; location and format for archive file
(setq org-archive-location (concat org-archive-dir "/%s_archive::"))

;; suppress extra blank lines in plain lists
(setq org-list-empty-line-terminates-plain-lists t)
(defun now ()
  (format-time-string  "%H:%M:%S" (current-time)))
  
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
         "\n
* <%(now)> %i
- Today’s MIT’s:
  - [ ] %?

- Today's plans (would like to do):
  - [ ] 

- Retrospective:
  -  

")
        ("n" "Notes" entry (file+datetree (concat org-directory "/notes.org")) 
         "* %^{Description} %^g 
         %? 
         Added: %U") 
        ))

;;"* %?\nEntered on %U\n %i\n %a"

;; org-capture default notes file
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 4)))

(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
(setq org-completion-use-ido t)                       ; try this

;; mobileorg settings for home
(cond (is-home-machine
       (setq org-mobile-inbox-for-pull (concat org-directory "/inbox.org"))
       (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
       (setq org-mobile-files '("~/Dropbox/notes" "~/Dropbox/notes/z-proj"))
       (setq org-agenda-files
             (append
              (file-expand-wildcards (concat org-directory "/*.org"))
              (file-expand-wildcards (concat org-directory "/z-proj/*.org"))))
       (setq org-refile-files org-agenda-files)
       (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'")
       (setq org-agenda-skip-unavailable-files t)
       (setq org-agenda-skip-scheduled-if-done t)
       )
      (t (setq org-refile-files (file-expand-wildcards (concat org-directory "/*.org"))))
      )


(add-hook 'org-mode-hook
          (lambda ()
           (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)
           (define-key global-map "\C-cc" 'org-capture)
            (set-fill-column 90)))

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




