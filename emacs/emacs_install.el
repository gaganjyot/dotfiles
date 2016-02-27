(require 'package)
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


(setq required-pkgs
      '(auto-complete
        color-theme-solarized zenburn-theme
        go-mode go-eldoc
        clojure-mode js2-mode
        markdown-mode php-mode
        cider idomenu
        neotree
        vala-mode
        web-mode
        browse-kill-ring
        anzu ;; show number of search matches
        ido-vertical-mode
        paredit  jedi
        php+-mode
        python-mode
        python-django
        ac-php ac-python
        ac-html ac-html-bootstrap
        ac-clang ac-c-headers
        cmake-mode
        coffee-mode color-theme-monokai
        color-theme-molokai
        gist glsl-mode
        go-autocomplete
        go-play
        lua-mode
        pomodoro
        smex
        rust-mode
        smartparens
        ssh spotify
        django-mode
        django-snippets
        dpaste undo-tree
        redo+))

;; Installs missing packages
(defun install-missing-packages ()
  "Installs required packages that are missing"
  (interactive)
  (mapc (lambda (package)
          (or (package-installed-p package)
              (package-install package)))
        required-pkgs)
  (message "Installed all missing packages!"))
