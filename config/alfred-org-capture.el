(fset 'jump-to-last-entry
   [?\C-x ?\] ?\C-s ?\C-r ?M ?I ?T return down])

(fset 'jump-to-last
   [S-tab S-tab S-tab])

;;; Code:
(defun make-orgcapture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "remember") (width . 80) (height . 32)
                (top . 400) (left . 300)
                (font . "-apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
                ))
  (select-frame-by-name "remember")
  (org-capture))

;;; alfred-org-capture.el ends here
(defun make-capture-frame ()
     "Create a new frame and run org-capture."
     (interactive)
     (make-frame '((name . "capture")))
     (select-frame-by-name "capture")
     (delete-other-windows)
     (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
       (org-capture))
     (org-capture-finalize)
     (make-frame '((name . "journal")))
     (select-frame-by-name "journal")
     (find-file "~/Dropbox/notes/journal.org")
     (execute-kbd-macro (symbol-function 'jump-to-last-entry))
     )
