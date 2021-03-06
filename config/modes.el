;; Global
(global-visual-line-mode 1)
(column-number-mode)

;(lispy-parens)
;(show-paren-mode 1)
;(setq show-paren-style 'mixed)

;; text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
  '(lambda() (set-fill-column 110)))

;; ido mode for managing buffers
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always) ;; Control-j creates buffers automatically
(setq ido-file-extensions-order '(".org" ".txt"  ".emacs" ".xml" ".el" ".ini" ".h" ".c"))

;; for git to auto-sync files
(setq global-auto-revert-mode t)

;; markdown mode
(load "markdown-mode.el")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'epa-file)
;(epa-file-enable)

(setq epa-file-cache-passphrase-for-symmetric-encryption 't)
(setq epa-file-encrypt-to: "ovi@sofariu.com")
(setq epa-file-encrypt-to: nil)
(setq epa-file-select-keys nil)

;; setup files ending in “.gpg” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . org-mode))

;; javascript
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; scheme and gradle modes for files:
(add-to-list 'auto-mode-alist '("\\.gradle" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.rkt" . scheme-mode))

;; geiser
;(setq geiser-active-implementations '(racket))

;; flyspell
(setq ispell-program-name "/usr/local/bin/ispell")
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq ispell-silently-savep t)

(dolist (hook '(org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; evilmode
(setq evil-disable-insert-state-bindings 't) 
(setq evil-emacs-state-cursor '(box "green")
      evil-normal-state-cursor '(box "red"))

(setq evil-want-C-u-scroll t)

(evil-mode)
(global-evil-leader-mode)

;; re-map scroll keys:
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))
;; powerline
;(require 'powerline)
;(require 'powerline-evil)

;(powerline-default-theme)
;(powerline-center-theme)
;(powerline-center-evil-theme)
;(powerline-nano-theme)
;(powerline-vim-theme)

(require 'noflet)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (require 'ert-expectations)
            ;; Use spaces, not tabs.
            (setq indent-tabs-mode nil)
            ;; Keep M-TAB for `completion-at-point'
            (define-key flyspell-mode-map "\M-\t" nil)
            ;; Pretty-print eval'd expressions.
            (define-key emacs-lisp-mode-map
              "\C-x\C-e" 'pp-eval-last-sexp)
            ;; Recompile if .elc exists.
     ;;       (add-hook (make-local-variable 'after-save-hook)
     ;;                 (lambda ()
     ;;                   (if (not (string-prefix-p "/Users/ovi/.emacs.d" (file-name-directory buffer-file-name)))
     ;;                       (byte-force-recompile default-directory)
     ;;                     nil)))
            (define-key emacs-lisp-mode-map
              "\r" 'reindent-then-newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode) ;; Requires Ispell

;(use-package ensime
;             :pin melpa-stable)

;(setq debug-on-error t)
;(require 'ensime)
;;Exit insert mode by pressing j and then j quickly

;; jj fast for escape to command mode
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)
