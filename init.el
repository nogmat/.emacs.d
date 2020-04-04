(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
;; (toggle-frame-fullscreen)
(display-time-mode 1)

;; Package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)			

;; Required packages
(setq package-list '(auctex cuda-mode ein deferred auto-complete eshell-git-prompt exwm flycheck flymake-python-pyflakes flymake-easy haskell-mode magic-latex-buffer magit git-commit ghub graphql magit-popup dash markdown-mode memoize minimap multiple-cursors php-mode pkg-info epl polymode popup px py-autopep8 request s skewer-mode js2-mode simple-httpd treepy web-mode web-server websocket with-editor async xelb yaml-mode zenburn-theme))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Keybindings
(global-set-key (kbd "C-x j") 'goto-line)
;;; EXWM
;; (require 'exwm)
;;(require 'exwm-config)
;;(exwm-config-default)
;;; Ido
(ido-mode 1)
;;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
;;; Shell
(global-set-key (kbd "C-x M-m") 'shell)
;;; Org
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-switchb)
;; Windmove | Org-Mode compatibility
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(global-unset-key (kbd "C-z"))
;; Compilation
(global-set-key (kbd "C-c e") 'compile)

(require 'windmove)
(windmove-default-keybindings)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(package-selected-packages
   (quote
    (auctex px exwm minimap magic-latex-buffer ein cuda-mode yaml-mode haskell-mode markdown-mode multiple-cursors magit eshell-git-prompt org neotree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "flake8")
;; Comment block
(global-set-key (kbd "M-;") 'comment-dwim)
(require 'linum)
(global-linum-mode 1)
(global-set-key (kbd "M-µ") 'linum-mode)

;; Enable PHP-Mode
;;(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
;;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
;;(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; Enable Web-mode
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

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
