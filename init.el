;; ── Configuración de paquetes ──────────────────────────────────────────────
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Instalar use-package si no está instalado
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ── Interfaz limpia ────────────────────────────────────────────────────────
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode t)
(column-number-mode t)

;; ── Fuente ─────────────────────────────────────────────────────────────────
;; instalacion: https://devblog.jpcaparas.com/manually-install-the-jetbrains-mono-font-on-linux-with-a-few-commands-608a13dcdeff 
(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height 120)

;; ── Tema Catppuccin ────────────────────────────────────────────────────────
(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm))

;; ── Modeline moderno ───────────────────────────────────────────────────────
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))

;; ── Iconos para el modeline ────────────────────────────────────────────────
(use-package all-the-icons
  :if (display-graphic-p)
  :config
  ;; Solo necesitas esto una vez para instalar los iconos
  (unless (file-directory-p "~/.local/share/fonts")
    (all-the-icons-install-fonts t)))

;; ── Mejoras de navegación ──────────────────────────────────────────────────
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; ── Línea de estado al estilo Doom ─────────────────────────────────────────
(setq display-time-format "%H:%M")
(display-time-mode 1)

;; ── Smooth scrolling ───────────────────────────────────────────────────────
(setq scroll-conservatively 101
      scroll-margin 5
      scroll-step 1)

;; ── Buenas prácticas ───────────────────────────────────────────────────────
(setq make-backup-files nil)
(setq auto-save-default nil)
(save-place-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1)
