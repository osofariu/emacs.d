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
(setq smooth-scroll/hscroll-step-size 2)
(setq smooth-scroll/vscroll-step-size 2)

;; ido mode for managing buffers
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always) ;; Control-b creates buffers automatically
(setq ido-file-extensions-order '(".org" ".txt"  ".emacs" ".xml" ".el" ".ini" ".h" ".c"))

;; for git to auto-sync files
(setq global-auto-revert-mode t)

;; markdown mode
(load "markdown-mode.el")
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'epa-file)
(epa-file-enable)

(setq epa-file-cache-passphrase-for-symmetric-encryption 't)
(setq epa-file-encrypt-to: "ovi@sofariu.com")
;(setq epa-file-encrypt-to: nil)
;(setq epa-file-select-keys nil)

;; setup files ending in “.gpg” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . org-mode))

;; javascript
 (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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
      evil-normal-state-cursor '(box "red"))


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

(use-package ensime
             :pin melpa-stable)

;(setq debug-on-error t)
(require 'ensime)
