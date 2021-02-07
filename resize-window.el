;;; resize-window.el --- Resize window interactively

;; Copyright (C) Hirose Yuuji and Bob Wiener

;; Author: Hirose Yuuji and Bob Wiener
;; Maintainer: Robert Medeiros <robert@crimeminister.org>
;; Keywords: window border
;; Homepage: https://github.com/crimeminister/move-border

;; This file is not part of GNU Emacs.

;;; Commentary:

;; 2021-02-05: copied from https://www.emacswiki.org/emacs/WindowResize

;;; Code:

(defun resize-window (&optional arg)
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
	(message
	 "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (enlarge-window arg))
	     ((= c ?s) (shrink-window arg))
	     ((= c ?w) (enlarge-window-horizontally arg))
	     ((= c ?n) (shrink-window-horizontally arg))
	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
	     (t (beep)))
	  (error (beep)))))
    (message "Done.")))

(provide 'resize-window)

;;; resize-window.el ends here
