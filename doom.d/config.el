;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tom Bärwinkel"
      user-mail-address "tom@baerwinkel.org")

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
(setq doom-font (font-spec :family "Source Code Pro" :size 10.0))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; switch to new window after split
(setq evil-split-window-below t
      evil-vsplit-window-right t)

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

;; use rust-analyzer as described in the rust module readme
(setq rustic-lsp-server 'rust-analyzer)

(setq flycheck-checker-error-threshold 3000)

;; format with yapf on save (currently only black is supported with format)
(add-hook! 'python-mode-hook 'yapf-mode)

;; Custom switch for Checkmks -T option when running pytest
(use-package! python-pytest
  :config
  (transient-define-argument python-pytest:-T ()
    :description "Test type"
    :class 'transient-option
    :key "-T"
    :argument "-T="
    :choices '("unit" "integration"))
  (transient-append-suffix
    'python-pytest-dispatch
    '(-2)  ;; insert after all arguments before the command in run tests
    ["Checkmk"
     (python-pytest:-T)]))

;; Custom Magit switches to push to Gerrit
(use-package! magit
  :config
  (defun magit-push-to-gerrit (target)
    (interactive
     (let ((target (magit-read-local-branch "Target branch")))
       (list target)))
    (magit-git-command-topdir (concat "git push origin HEAD:refs/for/" target)))
  (transient-append-suffix 'magit-push "t"
    '("g" "Push to gerrit" magit-push-to-gerrit)))

;; Sync files in Checkmk
(map! "<f10>" (lambda ()
                (interactive)
                (async-shell-command "WEBPACK_MODE=quick ~/git/zeug_cmk/bin/f12" "*f12*")))
(set-popup-rule! "^\\*f12\\*" :size 10 :quit t) ;; see Dooms popup module for details

;; add SPC w . binding for easier window navigation
(map!
 :leader
 :prefix "w"
 "." #'+hydra/window-nav/body)
