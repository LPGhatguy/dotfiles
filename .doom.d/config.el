;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lucien Greathouse"
      user-mail-address "me@lpghatguy.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one
      doom-font "Hack-12")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Inform Projectile where projects are
(setq projectile-project-search-path '("~/projects"))

;; Unmap the normal Vim undo keybind and change it to U
(map! :n "C-r" nil)
(map! :n "U" #'evil-redo)

;; Unmap C-r ("search backward")
(map! "C-r" nil)

;; Horizontal window split to complement <leader> w s
(map! :leader "w S" #'split-window-horizontally)

;; Change evil-snipe to snipe rest of buffer
(setq evil-snipe-scope 'buffer)

;; Add LSP "glance" keybind
(map! :leader "c g" #'lsp-ui-doc-glance)

;; Set the window to open maximized by default
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Use rust-analyzer instead of racer as Rust LSP
(setq lsp-rust-server 'rust-analyzer)

;; Turn on 80 column ruler in programming languages
(add-hook 'prog-mode-hook (lambda () (display-fill-column-indicator-mode 1)))

;; Attempt to make Lua indentation make sense
(setq-default lua-indent-level 4)
(add-hook 'lua-mode-hook
          (lambda ()
                (setq indent-tabs-mode t)
                (modify-syntax-entry ?_ "w")))

;; Ryan's Lua indentation fix
(with-eval-after-load "lua-mode"
  (defun rysco-lua-at-most-one-indent (old-function &rest arguments)
    (let ((old-res (apply old-function arguments)))
      (min old-res tab-width)))

  (defun rysco-lua-no-left-shifting ()
    t)

  (advice-add #'lua-calculate-indentation-block-modifier :around #'rysco-lua-at-most-one-indent)
  (advice-add #'lua-point-is-after-left-shifter-p :override #'rysco-lua-no-left-shifting))

;; HaxHelper's Selene integration for Flycheck
(flycheck-def-config-file-var flycheck-selene-toml lua-selene "selene.toml")
(flycheck-define-checker lua-selene
  "A lua syntax checker using selene.

See URL `https://github.com/kampfkarren/selene'."
  :command ("selene" source
            "--display-style=quiet"
            (config-file "--config" flycheck-selene-toml))
  :error-patterns
  ((warning line-start (file-name)
            ":" line ":" column ": warning"
            (message) line-end)
   (error line-start (file-name)
          ":" line ":" column ": error"
          (message) line-end))
  :working-directory (lambda (_checker)
               (locate-dominating-file
                buffer-file-name
                flycheck-selene-toml))
  :modes lua-mode)
(add-to-list 'flycheck-checkers 'lua-selene)

;; The 'word' motion should include underscores in Rust
(add-hook 'rustic-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

;; Configuration for glsl-mode
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
