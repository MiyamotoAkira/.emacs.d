;;; -*- lexical-binding: t; -*-

;; Less garbage collection to speed up the thing
(setq gc-cons-threshold 10000000)

;; reduce warnings when you start
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

;; https://emacs-lsp.github.io/lsp-mode/page/performance/#use-plists-for-deserialization
(setenv "LSP_USE_PLISTS" "true")

;; eliminate all visual elements external to emacs buffers.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
