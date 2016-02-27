(require 'package)
(package-initialize)

;; No Splash Screen
(setq inhibit-splash-screen t)

;; Deactivate menu-bar, tool-bar and scroll-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(set-fringe-mode 0)

;; Indentation
(setq-default tab-width 4)
(global-set-key (kbd "RET") 'newline-and-indent)

;; delete selected text
(delete-selection-mode t)

;; Lines and columns
(global-linum-mode t)
(column-number-mode t)
(show-paren-mode t)
(size-indication-mode t)

;; Uniquify filenames
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Enable ido mode
(ido-mode t)
(setq ido-enable-flex-matching t)

;; use ido vertical
(ido-vertical-mode t)

(require 'smex)
(smex-initialize)

;; my theme
(load-theme 'molokai t)
(setq linum-format "%4i\u2502")

;; Enable Auto-Complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(auto-complete-mode t)

;; neotree keybinding
(require 'neotree)
(global-set-key (kbd "C-x t") 'neotree-toggle)

;; y/n is easier than yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; redo+ keybinding
(require 'redo+)
(global-set-key (kbd "C-?") 'redo)

;; highlight current line
(global-hl-line-mode)
(set-face-background hl-line-face "#393939")

;; Enabel recent files and disable backup and autosave file
(recentf-mode t)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; C++ Mode
(c-set-offset 'access-label '-2)
(c-set-offset 'inclass '4)
(setq-default c-basic-offset 4
      tab-width 4
      c-default-style "k&r"
      indent-tabs-mode t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


(autoload 'rust-mode "rust-mode.el" "Major mode for editing Rust code." t)
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))

(autoload 'php-mode "php-mode.el" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(autoload 'web-mode "web-mode.el" "HTML mode." t)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))

(autoload 'js2-mode "js2-mode" t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Python Mode
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; One line at a time
(setq mouse-wheel-progressive-speed nil)            ;; Don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; Scroll window under mouse
(setq scroll-step 1)                                ;; Keyboard scroll one line at a time
(setq scroll-margin 4)                              ;; Always 4 lines above/below cursor


;; highlight TODO|FIXME|BUG in comments
(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

;; better defaults (?)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Go fullscreen!
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (global-set-key (kbd "<f11>") 'toggle-fullscreen))))

;; Fix all indentation (I love this so much)
(defun fix-indentation ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save))
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!"))))

(defun paste-from-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active"))
    (insert (shell-command-to-string "xsel -o -b"))))

;; copy/paste from clipboard in emacs -nw
(global-set-key [f8] 'copy-to-clipboard)
(global-set-key [f9] 'paste-from-clipboard)

;; Some shortcuts
(global-set-key (kbd "<f12>") 'delete-trailing-whitespace)
(global-set-key (kbd "<f10>") 'fix-indentation)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Clear the eshell
(defun clear-eshell ()
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun eshell/clear ()
  (clear-eshell))

(define-minor-mode eshell-cust-mode
  "Get your foos in the right places."
  :lighter " cust"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c l") 'clear-eshell)
            map))

(add-hook 'eshell (lambda ()
                    (eshell-cust-mode)))


;; Use C-tab and C-S-tab to switch buffers
(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-iso-lefttab] (lambda() ; use C-S-iso-lefttab because thats what emacs wants.
                                    (interactive)
                                    (other-window -1)))

;; set font for all windows
;;(add-to-list 'default-frame-alist '(font . "Monaco-10"))
;;(add-to-list 'default-frame-alist '(font . "Meslo LG S-10"))


;; Add ELPA package repository
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
