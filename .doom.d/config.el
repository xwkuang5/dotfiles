;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Louis Kuang"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; which-key pop-up delay
(setq which-key-idle-delay 0.3)

;; use #{{{ and #}}} for folding
(after! folding
  (folding-add-to-marks-list 'emacs-lisp-mode ";; #{{{" ";; #}}}"))

;; #{{{ ORG MODE RELATED
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(after! org
  (setq org-directory "~/Google\sDrive/org")

  (setq org-agenda-files `(,(concat org-directory "/work.org")
                           ,(concat org-directory "/life.org")
                           ,(concat org-directory "/notes")))

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)

  (setq org-capture-templates `(("t" "Todo [inbox]" entry
                                 (file+headline ,(concat org-directory "/inbox.org") "Tasks")
                                 "* TODO %i%?")
                                ("n" "Note" entry
                                 (file+headline ,(concat org-directory "/inbox.org") "Notes")
                                 "* %i%?")
                                ("j" "Journal" entry
                                 (file+datetree ,(concat org-directory "/journal.org"))
                                 "* %?"
                                 :empty-lines 1)))

  (setq org-archive-mark-done nil)
  (setq org-archive-location "%s_archive::* Archive"))
;; #}}}

;; #{{{ HELM RELATED

(use-package! helm
  :config
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-unset-key (kbd "C-x c"))
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ;; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ;; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ;; list actions using C-z
)

(use-package! helm-files
  :config
  (dolist (keymap (list helm-find-files-map helm-read-file-map))
    ;; use c-l and c-h to go left and right in directory
    (define-key keymap (kbd "C-l")
      'helm-execute-persistent-action)
    (define-key keymap (kbd "C-h")
      'helm-find-files-up-one-level)))

;; #}}}

;; #{{{ C/C++ mode

;; Create c style for PostgreSQL
(defconst postgresql-c-style
  '((indent-tabs-mode . t)
    (tab-width . 4)
    (c-basic-offset . 4)
    (c-tab-always-indent        . t)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "PostgreSQL C Programming Style")

(c-add-style "postgresql" postgresql-c-style)
;; #}}
