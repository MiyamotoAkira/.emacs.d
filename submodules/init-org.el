;; package --- Summary
;; Org mode setup
;;; Commentary:
;;; Code:

(use-package org
  :defer 2
  :config
  (setq org-startup-truncated nil)
  (setq org-directory "~/org")
  (setq org-agenda-files '("~/org/agendas/"))
  (require 'ox-md nil t)
  ;; (org-startup-indented t)
  ;; (org-special-ctrl-a/e t)
  ;; (org-special-ctrl-k t)
  )

;; (use-package org-contrib
;;   :after org)

(use-package visual-fill-column
  :config
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t))

(defun jgg/org-present-start ()
  (org-present-big)
  (org-display-inline-images)
  (display-line-numbers-mode -1)
  (global-hl-line-mode -1)
  (org-present-read-only)
  ;; we center the document with this two
  (visual-fill-column-mode 1)
  ;; just in case, wrap
  (visual-line-mode 1)
  ;; extra line at the top
  (setq header-line-format " "))

(defun jgg/org-present-end ()
  (org-present-small)
  (org-remove-inline-images)
  (display-line-numbers-mode 1)
  (global-hl-line-mode 1)
  (org-present-read-write)
  ;; we stop centering the document
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (setq header-line-format nil))

(defun jgg/org-present-slide (buffer-name heading)
  ;; Show only top-level headlines
  (org-overview)
  ;; Unfold the current entry
  (org-show-entry)
  ;; Show only direct subheadings of the slide but don't expand them
  (org-show-children))


(use-package org-present
  :after org
  :bind (("C-c o" . org-present))
  :config
  (add-hook 'org-present-mode-hook
            'jgg/org-present-start)
  
  (add-hook 'org-present-mode-quit-hook
            'jgg/org-present-end)
  
  (add-hook 'org-after-navigate-function
            'jgg/org-present-slide))


(use-package ob-elixir
  :after org)

(use-package ob-fsharp
  :after org)

(use-package ob-rust
  :after org)


;; Setting up babel for running code  in org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (elixir . t)
   (clojure . t)
   (shell . t)
   (ruby . t)
   (fsharp . t)
   (js . t)
   (rust . t)
   (plantuml . t)))

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

(use-package org-ref
  :after org)

(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/org/slip-box"))
  (org-roam-dailies-directory "journal/")
  (org-roam-complete-everywhere t)
  (org-roam-db-autosync-mode)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+date: %<%Y-%m-%d>\n")
      :unnarrowed t)
     ("l" "literary notes" plain
      "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Idea: %?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+date: %<%Y-%m-%d>\n#+filetags: LiteraryNote\n")
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" plain
      "\n* %<%H:%M>\n  %?\n"
      :if-new (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n\n")
      :unnarrowed t)
     ("m" "meeting" plain
      "\n* %<%H:%M>\n  Reason: %^{Reason}\n  Participants: %^{Participants}\n  Decisions: %?\n  Improvements:\n"
      :if-new (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n\n")
      :unnarrowed t)
     ("l" "literary entry" plain
      "\n* %<%H:%M>\n  Author: %^{Author}\n  Title: %^{Title}\n  Year: %^{Year}\n  Page Reference:%^{Page Reference}\n\n  %?\n"
      :if-new (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n\n")
      :unnarrowed t)))
  :bind (("C-c z l" . org-roam-buffer-toggle)
         ("C-c z f" . org-roam-node-find)
         ("C-c z i" . org-roam-node-insert)
         ("C-c z r" . org-roam-node-random)
         :map org-mode-map
         (("C-M-i" . completion-at-point)
          ("C-c z t" . org-roam-tag-add)
          ("C-c z a" . org-roam-alias-add)
          ("C-c z I" . org-roam-node-insert-immediate))
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c z d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-setup))

;; Immediate creation of a node without jumping to it
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(provide 'init-org)
;;; init-org.el ends here
