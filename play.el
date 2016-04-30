;; func call

(defvar run-my-tests nil)

(defun hash-test () 
  (setq h (make-hash-table))
  (puthash 'hi 'there h)
  (puthash 'me 'good h)
  (assert (equal 'there (gethash 'hi h)))
  (assert (equal 'good (gethash 'me h))))





(eval-when-compile
  (setq run-my-tests t))

(when run-my-tests
  (hash-test))

(byte-compile-file "~/.emacs.d/play.el")
