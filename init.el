
;; Functions
;;; Edit
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))
(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))
;;; Minor-mode
(define-global-minor-mode my-global-linum-mode linum-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'dired-mode 'slime-repl-mode 'shell-mode 'term-mode 'ansi-term-mode)))
      (linum-mode))))


;; Variable initialisation
;; (toggle-frame-fullscreen)
(toggle-scroll-bar -1)
(display-time-mode 1)
(my-global-linum-mode 1)
(ido-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq flymake-python-pyflakes-executable "flake8")
(setq inhibit-startup-screen t)
(setq org-startup-truncated nil)
(setq make-backup-files nil)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")
			 (name . "\\.el$")
			 ))	       
	       ("dired" (mode . dired-mode))
	       ("latex" (name . "\\.tex$"))
	       ("org" (name . "\\.org$"))
	       ("python" (or
			  (name . "\\.py$")
			  (name . "\\.py.bck$")
			  ))
	       ("terminal" (mode . term-mode))
	       ))))
(setq-default c-basic-offset 4)

;; Package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)			

;; Packages requirements
(setq package-list '(auctex cuda-mode ein deferred auto-complete eshell-git-prompt exwm flycheck flymake-python-pyflakes flymake-easy haskell-mode magic-latex-buffer magit git-commit ghub graphql magit-popup dash markdown-mode memoize minimap multiple-cursors php-mode pkg-info epl polymode popup px py-autopep8 request s skewer-mode js2-mode simple-httpd treepy web-mode web-server websocket with-editor async xelb yaml-mode zenburn-theme))
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Keybindings
;;; Goto-line
(global-set-key (kbd "C-x j") 'goto-line)
;;; Ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;; Linum
(global-set-key (kbd "C-c C-g") 'linum-mode)
;;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
;;; Move-line
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
;;; Shell
(global-set-key (kbd "C-x M-m") 'shell)
;;; Org
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-switchb)
;;; Windmove
(require 'windmove)
(windmove-default-keybindings)
;;; Windmove | Org-Mode compatibility
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(global-unset-key (kbd "C-z"))
;;; Compilation
(global-set-key (kbd "C-c e") 'compile)
;;; Comment block
(global-set-key (kbd "M-;") 'comment-dwim)


;; Theme configuration
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes
   (quote
    ("84890723510d225c45aaff941a7e201606a48b973f0121cb9bcb0b9399be8cba" default)))
 '(package-selected-packages
   (quote
    (gnuplot auctex px exwm minimap magic-latex-buffer ein cuda-mode yaml-mode haskell-mode markdown-mode multiple-cursors magit eshell-git-prompt org neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Hooks
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'ibuffer-mode-hook (lambda () (ibuffer-switch-to-saved-filter-groups "default")))

;; File mode
;;; Web-mode
(autoload 'web-mode "web-mode" "Major mode for editing Web code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
(add-to-list 'auto-mode-alist '("\\.py\.bck\\'" . python-mode))
;;; gnuplot-mode
(add-to-list 'auto-mode-alist '("\\.gp\\'" . gnuplot-mode))
;;; octave-mode
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; Minor-mode

