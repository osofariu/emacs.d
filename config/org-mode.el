(require 'org-mobile)
;; make outline pretty by indenting it
(setq org-startup-indented 't)

;; see tags
(setq org-complete-tags-always-offer-all-agenda-tags t)

;; fontify code blocks
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; can insert link with <C-C C-L>
(define-key global-map "\C-cl" 'org-store-link)

;; see agenda
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


;; more todo states
(cond ((eq is-home-machine nil)
       (setq org-todo-keywords
             '((sequence "TODO" "DOING" "DONE")))))

;; suppress extra blank lines in plain lists
(setq org-list-empty-line-terminates-plain-lists t)

(defun now-date ()
  (interactive
  (format-time-string  "%Y-%m-%d %" (current-time)))
)
(defun now-time ()
  (format-time-string  "%H:%M:%S" (current-time)))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/main.org") "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+olp+datetree (lambda () (concat org-directory "/journal.org")))
         "\n
* <%(now-time)> %i
** %?

")
        ("n" "Notes" entry (file+datetree (concat org-directory "/notes.org"))
         "* %^{Description} %^g
         %?
         Added: %U")
        ))

(setq org-agenda-custom-commands
      '(("w" todo "TODO"
         ((org-agenda-sorting-strategy '(priority-down))
          (org-agenda-prefix-format "  Mixed: ")))
        ("U" tags-tree "+boss-urgent"
         ((org-show-context-detail 'minimal)))
        ("N" search ""
         ((org-agenda-files '("~org/notes.org"))
          (org-agenda-text-search-extra-files nil)))))

;; org-capture default notes file
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 2)))

(setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(setq org-refile-use-outline-path t)                  ; Show full paths for refiling
(setq org-completion-use-ido t)                       ; try this

;; org-mode export
(eval-after-load "org"
  '(require 'ox-md nil t))

(cond (is-home-machine
;; mobile sync scheduling
       (defvar org-mobile-sync-timer nil)
       (defvar org-mobile-sync-idle-secs (* 60 5))

       (defun org-mobile-sync ()
         (interactive)
         (org-mobile-pull)
         (org-mobile-push))

       (defun org-mobile-sync-enable ()
         "enable mobile org idle sync"
         (interactive)
         (setq org-mobile-sync-timer
               (run-with-idle-timer org-mobile-sync-idle-secs t
                                    'org-mobile-sync)));

       (defun org-mobile-sync-disable ()
         "disable mobile org idle sync"
         (interactive)
         (cancel-timer org-mobile-sync-timer))))

;;(org-mobile-sync-enable)


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
      (t (setq org-agenda-files (file-expand-wildcards (concat org-directory "/*.org")))
         (setq org-refile-files (file-expand-wildcards (concat org-directory "/*.org")))))

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


;;(font-lock-add-keywords 'org-mode
;;                    '(("\\(src_\\)\\([^[{]+\\)\\(\\[:.*\\]\\){\\([^}]*\\)}"
;;                       (1 '(:foreground "black" :weight 'normal :height 10)) ; src_ part
;;                       (2 '(:foreground "cyan" :weight 'bold :height 75 :underline "red")) ; "lang" part.
;;                       (3 '(:foreground "#555555" :height 70)) ; [:header arguments] part.
;;                       (4 'org-code) ; "code..." part.
;;)))

;; (setq org-html-htmlize-output-type 'inline-css) ;; default
;;(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
;;(setq org-html-htmlize-font-prefix "org-")

(cond (is-home-machine
       ;; Trying something new
       ;; Configure these two variables
       (setq org-mobile-inbox-for-pull "~/Dropbox/notes/inbox.org" 
             org-mobile-directory "~/Dropbox/Apps/MobileOrg")
       (require 'gnus-async) 
       ;; Define a timer variable
       (defvar org-mobile-push-timer nil
         "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")
       ;; Push to mobile when the idle timer runs out
       (defun org-mobile-push-with-delay (secs)
         (when org-mobile-push-timer
           (cancel-timer org-mobile-push-timer))
         (setq org-mobile-push-timer
               (run-with-idle-timer
                (* 1 secs) nil 'org-mobile-push)))
       ;; After saving files, start an idle timer after which we are going to push 
       (add-hook 'after-save-hook 
                 (lambda () 
                   (if (or (eq major-mode 'org-mode) (eq major-mode 'org-agenda-mode))
                       (dolist (file (org-mobile-files-alist))
                         (if (string= (expand-file-name (car file)) (buffer-file-name))
                             (org-mobile-push-with-delay 10))))))
       ;; watch mobileorg.org for changes, and then call org-mobile-pull
       (defun org-mobile-install-monitor (file secs)
         (run-with-timer
          0 secs
          (lambda (f p)
            (unless (< p (second (time-since (elt (file-attributes f) 5))))
              (org-mobile-pull)
              (org-mobile-push)))
          file secs))
       (defvar monitor-timer (org-mobile-install-monitor (concat org-mobile-directory "/mobileorg.org") 30)
         "Check if file changed every 30 s.")
))
