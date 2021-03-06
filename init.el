;; Don't show scroll bar
(toggle-scroll-bar -1)
;; Don't load the startup screen
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
;; Highlight matching paren
(show-paren-mode 1)
;; function name at point in mode line
(which-function-mode t)
;; Highlight selection between point and mark
(transient-mark-mode t)
;; Automatically close opening characters
(electric-pair-mode t)
;; Syntax highlighting
(global-font-lock-mode t)
;; Move by camelCase words
(global-subword-mode t)
;; Don't insert instructions in the *scratch* buffer
(setq initial-scratch-message nil)
;; Show line-number
(line-number-mode 1)
;; "yes/no" === "y/n"
(fset 'yes-or-no-p 'y-or-n-p)
;; Hide toolbar (OSX)
(menu-bar-showhide-tool-bar-menu-customize-disable)

;; Compile When Init.el Modified
(defun autocompile nil
  (interactive)
  (require 'bytecomp)
  (let ((initemacs (expand-file-name "~/.emacs.d/init.el")))
    (if (string= (buffer-file-name) (file-chase-links initemacs))
        (byte-compile-file initemacs))))
(add-hook 'after-save-hook 'autocompile)

;; Smooth-scrolling Fix
(setq scroll-conservatively 101)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

;; MELPA
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; El-Get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.org/packages/"))
  (package-refresh-contents)
  (package-initialize)
  (package-install 'el-get)
  (require 'el-get))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; Install Use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Get Packages
(require 'use-package)
(use-package clojure-mode :ensure clojure-mode)
(use-package color-theme :ensure color-theme)
(use-package projectile :ensure projectile)
(use-package helm :ensure helm)
(use-package helm-projectile :ensure helm-projectile)
(use-package paredit :ensure paredit)
(use-package undo-tree :ensure undo-tree)
(use-package highlight-parentheses :ensure highlight-parentheses)
(use-package lispy :ensure lispy)
(use-package sublime-themes :ensure sublime-themes)
(use-package js2-mode :ensure js2-mode)
(use-package js2-refactor :ensure js2-refactor)
(use-package expand-region :ensure expand-region)
(use-package web-mode :ensure web-mode)
(use-package css-mode :ensure css-mode)
(use-package auto-complete :ensure auto-complete)
(use-package bind-key :ensure bind-key)
(use-package haskell-mode  :ensure haskell-mode)
(use-package clj-refactor :ensure clj-refactor)
(use-package lua-mode :ensure lua-mode)
(use-package scss-mode :ensure scss-mode)
(use-package flycheck :ensure flycheck :init (global-flycheck-mode))

;; Theme Config
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (granger)))
 '(custom-safe-themes
   (quote
    ("72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages
   (quote
    (pdf-tools web-mode use-package undo-tree sublime-themes solarized-theme scss-mode lua-mode lispy js2-refactor highlight-parentheses helm-projectile haskell-mode flycheck-rust expand-region color-theme clj-refactor cargo auto-complete)))
 '(tool-bar-mode nil))

;; PATH Variables
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; Undo-tree
(global-undo-tree-mode)

;; Lispy
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))

;; SuperCollider
(add-to-list 'load-path "~/Code/SuperCollider/editors/scel/el")
(require 'sclang)

;; Tidal
(setq load-path (cons "~/tidal/" load-path))
(setq tidal-interpreter "/usr/local/bin/ghci")
(require 'tidal)

;; Js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

;; Js2-refactor
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; Expand Region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(setq web-mode-style-padding 2)
(setq web-mode-script-padding 2)
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

;; Css-mode
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(autoload 'css-mode "css-mode" nil t)

;; Indentation
(defun my-setup-indent (n)
  (setq javascript-indent-level n)
  (setq js-indent-level n)
  (setq js2-basic-offset n)
  (setq web-mode-markup-indent-offset n)
  (setq web-mode-css-indent-offset n)
  (setq web-mode-code-indent-offset n)
  (setq css-indent-offset n)
  (setq indent-tabs-mode nil)
  (setq-default indent-tabs-mode nil)
  )
(my-setup-indent 2)

;; Text-mode Indentation (2 spaces)
(add-hook 'text-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 2)))

;; Highlight Parens
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda () (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Helm
(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)
(global-set-key (kbd "M-p") 'ace-window)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x c o") 'helm-occur)
(global-set-key (kbd "C-c f") 'helm-recentf)
(setq helm-truncate-lines 1)

;; Projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-switch-project-action 'helm-projectile)

;; HideShow
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c C-h") 'hs-hide-all)
(global-set-key (kbd "C-c C-s") 'hs-show-all)

;; Clj-refactor
(require 'clj-refactor)
(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))
(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; Recompile
;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
