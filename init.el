;;; package --- Summary
;;; Commentary:
;;; This is my configuration of Emacs.

;;; Code:

;; The whole let doesn't seem to be needed anymore?
;; Normally file-name-handler-alist is set to

;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;;  ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;;  ("\\`/:" . file-name-non-special))

;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
;; (let ((file-name-handler-alist nil)))


(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; we want custom setup on a separate file. This is set because all the variables
;; that appear there are set on the different .el setup files I have


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; This is to move setup into an org file.
;; Org must come from ELPA before `org-babel-load-file' pulls in the built-in
;; version -- otherwise a later Org install is byte-compiled against the older
;; built-in Org and every startup warns "Org version mismatch".
(require 'package)
(unless (assq 'org package-alist)
  (unless package-archive-contents (package-refresh-contents))
  (let ((package-install-upgrade-built-in t))
    (package-install 'org)))

(require 'org)
(org-babel-load-file (expand-file-name "README.org" user-emacs-directory))

(setq read-process-output-max (* 512 1024))
;;; init.el ends here

