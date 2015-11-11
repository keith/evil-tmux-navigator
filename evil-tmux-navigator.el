;;; evil-tmux-navigator.el --- Seamlessly navigate between Emacs and tmux

;; Author:   Keith Smiley <keithbsmiley@gmail.com>
;; Created:  April 25 2014
;; Version:  0.1.5
;; Keywords: tmux, evil, vi, vim
;; Package-Requires: ((evil "1.2.8"))

;;; Commentary:

;; This package is inspired by vim-tmux-navigator.
;; It allows you to navigate splits in evil mode
;; Along with tmux splits with the same commands
;; Include with:
;;
;;    (require 'evil-tmux-navigator)
;;
;; Call evil-tmux-navigator-bind-keys to apply the
;; default bindings or the ones you have set by
;; changing the variables defined in "evil-tmux-navigator"
;; customize group.
;;
;; You can also directly bind the
;; tmux-navigate-{left|down|up|right} functions.

;;; Code:

(require 'evil)

(defgroup evil-tmux-navigator nil
  "seamlessly evil-tmux-navigator between Emacs and tmux"
  :prefix "evil-tmux-navigator-"
  :group 'evil)

(defcustom evil-tmux-navigator-bind-on-evil-window-map nil
  "If nill, bind evil-tmux-navigator keys on evil-normal-map and
evil-motion-state-map. Else, bind on evil-window-map."
  :type 'boolean
  :group 'evil-tmux-navigator)
(defcustom evil-tmux-navigator-pane-left-key (kbd "C-h")
  "Key binding used by evil-tmux-navigator to switch to the split on the left"
  :type 'string
  :group 'evil-tmux-navigator)
(defcustom evil-tmux-navigator-pane-down-key (kbd "C-j")
  "Key binding used by evil-tmux-navigator to switch to the split below"
  :type 'string
  :group 'evil-tmux-navigator)
(defcustom evil-tmux-navigator-pane-up-key (kbd "C-k")
  "Key binding used by evil-tmux-navigator to switch to the split above"
  :type 'string
  :group 'evil-tmux-navigator)
(defcustom evil-tmux-navigator-pane-right-key (kbd "C-l")
  "Key binding used by evil-tmux-navigator to switch to the split on the right"
  :type 'string
  :group 'evil-tmux-navigator)

(setq-local bindings (list
                      evil-tmux-navigator-pane-left-key
                      evil-tmux-navigator-pane-down-key
                      evil-tmux-navigator-pane-up-key
                      evil-tmux-navigator-pane-right-key))

;; This requires windmove commands
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;; Interactive commands
(defun tmux-navigate-left ()
  "Navigate to the emacs split or tmux pane on the left"
  (interactive)
  (tmux-navigate "left"))
(defun tmux-navigate-down ()
  "Navigate to the emacs split or tmux pane below"
  (interactive)
  (tmux-navigate "down"))
(defun tmux-navigate-up ()
  "Navigate to the emacs split or tmux pane above"
  (interactive)
  (tmux-navigate "up"))
(defun tmux-navigate-right ()
  "Navigate to the emacs split or tmux pane on the right"
  (interactive)
  (tmux-navigate "right"))

(defun tmux-navigate (direction)
  (let
      ((cmd (concat "windmove-" direction)))
    (condition-case nil
        (funcall (read cmd))
      (error
       (tmux-select-pane direction)))))

(defun tmux-select-pane (direction)
  (shell-command-to-string
   (concat "tmux select-pane -"
           (tmux-direction direction))))

(defun tmux-direction (direction)
  (upcase
   (substring direction 0 1)))

(defun evil-tmux-navigator-bind-keys ()
  "Bind keys according to the variables in evil-tmux-navigator's customize
group"
  (if evil-tmux-navigator-bind-on-evil-window-map
      (progn
        (define-key evil-window-map
          evil-tmux-navigator-pane-left-key
          'tmux-navigate-left)
        (define-key evil-window-map
          evil-tmux-navigator-pane-down-key
          'tmux-navigate-down)
        (define-key evil-window-map
          evil-tmux-navigator-pane-up-key
          'tmux-navigate-up)
        (define-key evil-window-map
          evil-tmux-navigator-pane-right-key
          'tmux-navigate-right))
    (progn
      ;; Unset key-bindings to avoid conflicts
      (dolist (key bindings)
        (progn (print key)(global-unset-key key)))

      (define-key evil-normal-state-map
        evil-tmux-navigator-pane-left-key
        'tmux-navigate-left)
      (define-key evil-normal-state-map
        evil-tmux-navigator-pane-down-key
        'tmux-navigate-down)
      (define-key evil-normal-state-map
        evil-tmux-navigator-pane-up-key
        'tmux-navigate-up)
      (define-key evil-normal-state-map
        evil-tmux-navigator-pane-right-key
        'tmux-navigate-right)
      
      (define-key evil-motion-state-map
        evil-tmux-navigator-pane-left-key
        'tmux-navigate-left)
      (define-key evil-motion-state-map
        evil-tmux-navigator-pane-down-key
        'tmux-navigate-down)
      (define-key evil-motion-state-map
        evil-tmux-navigator-pane-up-key
        'tmux-navigate-up)
      (define-key evil-motion-state-map
        evil-tmux-navigator-pane-right-key
        'tmux-navigate-right)
      )))

(provide 'evil-tmux-navigator)

;;; evil-tmux-navigator.el ends here
