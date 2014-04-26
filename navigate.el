;;; navigate.el --- seamlessly navigate between emacs and tmux

;; Author: Keith Smiley <keithbsmiley@gmail.com>
;; Created: April 25 2014
;; Version 0.1.0
;; Keywords: tmux, evil, vi, vim

;;; Commentary:

;; This package is inspired by vim-tmux-navigator
;; It allows you to navigate splits in evil mode
;; Along with tmux splits with the same commands
;; Include with:
;;
;;    (require 'navigate)
;;

;;; Code:

(defun tmux-navigate (direction)
  (let
    ((cmd (concat "windmove-" direction)))
      (condition-case nil
          (funcall (read cmd))
        (error
          (tmux-command direction)))))

(defun tmux-command (direction)
  (shell-command-to-string
    (concat "tmux select-pane -"
      (tmux-direction direction))))

(defun tmux-direction (direction)
  (upcase
    (substring direction 0 1)))

(define-key evil-normal-state-map
            (kbd "C-h")
            (lambda ()
              (interactive)
              (tmux-navigate "left")))
(define-key evil-normal-state-map
            (kbd "C-j")
            (lambda ()
              (interactive)
              (tmux-navigate "down")))
(define-key evil-normal-state-map
            (kbd "C-k")
            (lambda ()
              (interactive)
              (tmux-navigate "up")))
(define-key evil-normal-state-map
            (kbd "C-l")
            (lambda ()
              (interactive)
              (tmux-navigate "right")))

;;; navigate.el ends here
