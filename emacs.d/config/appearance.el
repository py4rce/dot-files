;; config/appearance.el

;; UI mínimo
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Transparencia
(set-frame-parameter (selected-frame) 'alpha '(97 . 100))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Tema
(use-package doom-themes
  :config
  (load-theme 'doom-palenight t))

;; Fuentes
(defvar my/fixed-width-font "JetBrains Mono")
(defvar my/variable-width-font "Iosevka Aile")

(set-face-attribute 'default nil :font my/fixed-width-font :weight 'light :height 180)
(set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'light :height 190)
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 1.3)

