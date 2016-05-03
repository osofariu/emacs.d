(define-abbrev-table 'global-abbrev-table '(
                                            ("afaict" "as far as I can tell" nil 1)
                                            ("omuse" "http://www.emacswiki.org/cgi-bin/oddmuse.pl" nil 0)
                                            ("btw" "by the way" nil 3)
                                            ("wether" "whether" nil 5)
                                            ("ewiki" "http://www.emacswiki.org/cgi-bin/wiki.pl" nil 3)
                                            ("pov" "point of view" nil 1)
                                            (";dd" "" org-skeleton-daily-entry)
                                            ))


(define-skeleton org-skeleton-daily-entry
  "Insert a daily entry" nil
  
  " "  (insert-current-time)
"- Today’s MIT’s:\n"
"  - [ ] \n"
"\n"
"- Today's plans (would like to do):\n"
"  - [ ] \n"
"\n"
"- Retrospective:\n"
"  - [ ] \n")


(defun insert-daily-entry ()
  "insert daily entry"
  (interactive)
  (org-skeleton-daily-entry))

(defun reload-current-buffer ()
  "reload current buffer"
  (interactive)
  (load-file (buffer-file-name)))

