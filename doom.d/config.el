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

;; allow avy to jump to all windows in a frame
(setq avy-all-windows t)

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.doom.d/snippets")))
;; allow nesting of yas snippet invocations:
(setq yas-triggers-in-field t)

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

(setq delete-by-moving-to-trash t)

(setq lsp-file-watch-threshold 5000)

;; use rust-analyzer as described in the rust module readme
(setq rustic-lsp-server 'rust-analyzer)

(setq lsp-ui-sideline-delay 0.5)
(setq company-idle-delay 0.5)
(setq which-key-idle-delay 0.5)

(setq evil-snipe-scope 'whole-visible)

;; use dirvish instead of dired:
(map! :leader "." #'dired-jump)
;; Save one key:
(map! :leader :desc "Async cmd in project root" "&" #'projectile-run-async-shell-command-in-root)

;; add SPC w . binding for easier window navigation
(map!
 :leader
 :prefix "w"
 "." #'+hydra/window-nav/body)
