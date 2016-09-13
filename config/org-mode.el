

;; make outline pretty by indenting it
(setq org-startup-indented 't)

;; fontify code blocks
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(define-key global-map "\C-cl" 'org-store-link)
;; can insert link with <C-C C-L>

(define-key global-map "\C-ca" 'org-agenda)

;; what to log when task done
(setq org-log-done t)
(setq org-log-repeat 'nil)

;; follow links with RETURN
(setq org-return-follows-link 'RET)

;; location and format for archive file
(setq org-archive-location (concat org-archive-dir "/%s_archive::"))

;; open org-capture in new frame
(add-hook 'org-capture-mode-hook 'delete-other-windows)
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
*** %? 

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

;; org-mode export
(eval-after-load "org"
  '(require 'ox-md nil t))

;; mobileorg settings for home
(cond (is-home-machine
       (setq org-mobile-inbox-for-pull (concat org-directory "/inbox.org"))
       (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
       (setq org-mobile-files '("~/Dropbox/notes" "~/Dropbox/notes/projects"))
       (setq org-agenda-files
             (append
              (file-expand-wildcards (concat org-directory "/*.org"))
              (file-expand-wildcards (concat org-directory "/projects/*.org"))))
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





(font-lock-add-keywords 'org-mode
                    '(("\\(src_\\)\\([^[{]+\\)\\(\\[:.*\\]\\){\\([^}]*\\)}"
                       (1 '(:foreground "black" :weight 'normal :height 10)) ; src_ part
                       (2 '(:foreground "cyan" :weight 'bold :height 75 :underline "red")) ; "lang" part.
                       (3 '(:foreground "#555555" :height 70)) ; [:header arguments] part.
                       (4 'org-code) ; "code..." part.
                       )))
; (setq org-html-htmlize-output-type 'inline-css) ;; default
;(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
;;(setq org-html-htmlize-font-prefix "org-")
