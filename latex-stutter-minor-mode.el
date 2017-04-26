(load-file "~/.emacsmodes/stutter-mode/stutter-tree.el")
(load-file "~/.emacsmodes/stutter-mode/latex-stutter-expansion-functions.el")

(defvar latex-stutter-character-expansion-tree nil
  "A tree that holds the expansion structure for stutter mode")

(defun create-latex-stutters ()
  (interactive)
  (setq latex-stutter-character-expansion-tree (list (cons 1 #'test-print)))
  (setq latex-stutter-tree-pointer latex-stutter-character-expansion-tree)
  (insert-and-create-stutter ",," #'latex-stutter-expand-inline-math-mode latex-stutter-character-expansion-tree)
  (insert-and-create-stutter ",." #'latex-stutter-expand-section-sub-section latex-stutter-character-expansion-tree)
  (insert-and-create-stutter ";;" #'latex-stutter-expand-begin-align latex-stutter-character-expansion-tree)
  (add-hook 'post-command-hook 'latex-stutter-electric-expand))

(define-minor-mode latex-stutter-mode
  "A minor mode to simplify writing certain environments in
LAteX"
  :lighter "LaTeX stutter"
  :require 'latex-mode
  :version "0.1"
  ;; As every insert is simply a command, binding to post-command-hook
  ;;does the trick
  (add-hook 'post-command-hook 'latex-stutter-electric-expand)
  (create-latex-stutters))

(provide 'latex-stutter-minor-mode)
