;;; package --- Summary
;;;Additional tools for  Emacs

;;; Commentary:

;;; Code:
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package monky
  :ensure t
  :bind (("C-x C-g" . monky-status)))

(use-package ag
  :ensure t)

(use-package command-log-mode
  :ensure t
  :custom
  (command-log-mode-key-binding-open-log "C-c C-o"))

(use-package projectile
  :ensure t)

(use-package neotree
  :ensure t
  :bind (([f8] . neotree-toggle)))

(use-package floobits
  :ensure t)

(use-package shut-up
  :ensure t)

(use-package org
  :defer t
  :ensure t)

(use-package org-plus-contrib
  :defer t
  :ensure t)

(use-package org-present
  :defer t
  :ensure t
  :config
  (add-hook 'org-present-mode-hook
            (lambda ()
              (org-present-big)
              (org-display-inline-images)
              (global-linum-mode -1)
              (global-hl-line-mode -1)))
  (add-hook 'org-present-mode-quit-hook
            (lambda ()
              (org-present-small)
              (org-remove-inline-images)
              (global-linum-mode)
              (global-hl-line-mode 1))))

(use-package ob-elixir
  :ensure t
  :defer t)

(use-package ob-fsharp
  :ensure t
  :defer t)

;; Setting up babel for running code  in org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (elixir . t)
   (clojure . t)
   (shell . t)
   (ruby . t)
   (fsharp . t)))

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(use-package undo-tree
  :ensure t
  :defer t)

(use-package goto-chg
  :ensure t
  :defer t)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(provide 'init-tools)
;;; init-tools.el ends here
