;; init.el

;; Load package system and use-package
(load (expand-file-name "config/packages.el" user-emacs-directory))

;; Load appearance settings
(load (expand-file-name "config/appearance.el" user-emacs-directory))

;; Load Org settings
(load (expand-file-name "config/org.el" user-emacs-directory))

;; Load Org Present settings
(load (expand-file-name "config/org-present.el" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
