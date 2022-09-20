;;; init-sly.el --- Sly support for Common Lisp -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'sly)
(push (expand-file-name "contrib" (file-name-directory (locate-library "sly"))) load-path)


;;; Lisp buffers

(with-eval-after-load 'sly
  (setq sly-protocol-version 'ignore)
  (setq sly-net-coding-system 'utf-8-unix)
  (let ((features '(sly-fancy)))
    (sly-setup features)) )


;;; REPL

(defun sanityinc/sly-repl-setup ()
  "Mode setup function for sly REPL."
  (sanityinc/lisp-setup))

(with-eval-after-load 'sly-repl
  ;; Stop SLY's REPL from grabbing DEL, which is annoying when backspacing over a '('
  (with-eval-after-load 'paredit
    (define-key sly-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil))

  ;; Bind TAB to `indent-for-tab-command', as in regular Sly buffers.
  (define-key sly-repl-mode-map (kbd "TAB") 'indent-for-tab-command)

  (add-hook 'sly-repl-mode-hook 'sanityinc/sly-repl-setup))


(provide 'init-sly)
;;; init-sly.el ends here
