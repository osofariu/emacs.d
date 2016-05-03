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

(require 'epa-file)
(setq epa-file-cache-passphrase-for-symmetric-encryption 't)
(setq epa-file-encrypt-to: "ovi@sofariu.com")

;; setup files ending in “.gpg” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . org-mode))

;; scheme and gradle modes for files:
(add-to-list 'auto-mode-alist '("\\.gradle" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.rkt" . scheme-mode))

;; geiser
(setq geiser-active-implementations '(racket))

;; flyspell
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq ispell-silently-savep t)

(dolist (hook '(org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; evil mode
(setq evil-emacs-state-cursor '(box "green")
      evil-normal-state-cursor '(box "yellow"))


(evil-mode)
(global-evil-leader-mode)
;(require 'evil-org)

;; powerline
(require 'powerline)
(require 'powerline-evil)

;(powerline-default-theme)
;(powerline-center-theme)
(powerline-center-evil-theme)
;(powerline-nano-theme)
;(powerline-vim-theme)

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
           ; (add-hook (make-local-variable 'after-save-hook)
           ;           (lambda ()
           ;             (if (not (string-prefix-p "/Users/ovi/.emacs.d" (file-name-directory load-file-name)))
           ;                 (byte-force-recompile default-directory)
           ;               nil)))
            (define-key emacs-lisp-mode-map
              "\r" 'reindent-then-newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode) ;; Requires Ispell
