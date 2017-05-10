;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-date-format "%Y-%m-%d"
  "Format of date to insert with `insert-current-date' func
See help of `format-time-string' for possible replacements")


(defvar current-time-format "%H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
;       (insert "==========\n")
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun insert-current-date ()
  "insert the current date and time into current buffer.
Uses `current-date-format' for the formatting the date/time."
       (interactive)
;       (insert "==========\n")
       (insert (format-time-string current-date-format (current-time)))
       (insert " ")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )


(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))



(defun lawlist-org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
       (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp (point-min) (point)))
             (end (if globalp (point-max)
        (if (eq state 'children)
      (save-excursion (outline-next-heading) (point))
          (org-end-of-subtree t)))))
  (goto-char beg)
  (while (re-search-forward "^.*DEADLINE:.*$\\|^\\*\\* Someday.*$\\|^\\*\\* None.*$\\|^\\*\\* Planning.*$\\|^\\* TASKS.*$" end t)
     (save-excursion
    (beginning-of-line 1)
    (when (looking-at "^.*DEADLINE:.*$\\|^\\*\\* Someday.*$\\|^\\*\\* None.*$\\|^\\*\\* Planning.*$\\|^\\* TASKS.*$")
      (let ((b (match-end 0)))
  (if (re-search-forward
       "^[ \t]*:END:"
       (save-excursion (outline-next-heading) (point)) t)
      (outline-flag-region b (point-at-eol) t)
    (user-error ":END: line missing at position %s" b))))))))))

(defun lispy-parens ()
  "Setup parens display for lisp modes"
  (setq show-paren-delay 0.1)
  (setq show-paren-style 'mixed)
  (make-variable-buffer-local 'show-paren-mode)
  (show-paren-mode 1)
  (set-face-background 'show-paren-match-face (face-background 'default))
  (if (boundp 'font-lock-comment-face)
      (set-face-foreground 'show-paren-match-face 
     			   (face-foreground 'font-lock-comment-face))
    (set-face-foreground 'show-paren-match-face 
     			 (face-foreground 'default)))
  (set-face-attribute 'show-paren-match-face nil :weight 'ultra-bold)) 

(defun stm-create-initial-frame ()
  "Place initial frame on screen and visit *scratch* buffer.

This function can be called from emacsclient to move the created
frame to a convenient place. Example:

emacsclient -c -n -e '(stm-create-initial-frame)'"
  (interactive)
  (when window-system
    (let ((xpos (or (cdr (assq 'left initial-frame-alist)) 0))
          (ypos (or (cdr (assq 'top initial-frame-alist)) 0))
          (rows (or (cdr (assq 'height initial-frame-alist)) 60))
          (cols (or (cdr (assq 'width initial-frame-alist)) 160)))
      (set-frame-position (selected-frame) xpos ypos)
      (set-frame-size (selected-frame) cols rows)
      (switch-to-buffer (get-buffer-create "*scratch*") t)
      (lisp-interaction-mode))))

(require 'cl)

(defvar server-buffers nil)

(defun show-server-buffers ()
  (interactive)
  (setq server-buffers nil)
  (let ((original-buffer (current-buffer)))
    (loop for buf in (buffer-list)
      do
      (progn
        (switch-to-buffer buf)
        (if (and
         server-buffer-clients
         (buffer-live-p buf))
        (add-to-list 'server-buffers buf))))
    (switch-to-buffer original-buffer)
    (message "server-buffers: %s" server-buffers)))
