(require 'package)

(add-to-list 'package-archives 
           '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(defvar my-packages '(starter-kit 
  starter-kit-lisp 
  starter-kit-bindings
  starter-kit-eshell
  rainbow-delimiters
  color-theme
  auto-complete
  popup
  color-theme-solarized
  moe-theme
  buffer-move
  sublime-themes
  noctilux-theme
  ace-jump-mode
  ace-jump-buffer
  jump-char
  anything
  deft
  bookmark+
  zen-and-art-theme
  cider
  clojure-mode
  smartparens
  zoom-frm)
    
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;; Rainbow delimiters
;;(require 'rainbow-delimiters)
;;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(global-rainbow-delimiters-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 105 :width normal))))
 '(hi-blue ((t (:background "sky blue"))))
 '(hl-line ((t (:background "khaki1"))))
 '(idle-highlight ((t (:background "gray" :foreground "black"))))
 '(minibuffer-prompt ((t (:background "purple3" :foreground "white smoke"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark magenta"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark violet"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "dark red"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "dark blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "dark magenta"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "dark blue"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "midnight blue"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "maroon"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "firebrick"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "orange red"))))
 '(show-paren-match ((t (:background "gray" :foreground "coral1" :inverse-video nil :underline nil :slant normal :weight bold))))
 '(show-paren-mismatch ((t (:background "gray" :foreground "dark red" :inverse-video nil :underline nil :slant normal :weight bold)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(tool-bar-mode nil))

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop
                              ; completion

;;;;; theme
;;(load-theme 'solarized-light t)
;;(load-theme 'solarized-dark t)
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(load-theme 'moe-dark t)
(load-theme 'moe-light t)

;; switch buffers
(global-set-key (kbd "C-<tab>") 'next-buffer)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-buffer)

;;;;;
(show-paren-mode t)
;;(setq show-paren-style 'expression)
(setq show-paren-style 'mixed)

;;; window size
(global-set-key (kbd "<C-x-down>")  'shrink-window)
(global-set-key (kbd "<C-x-up>")    'enlarge-window)
(global-set-key (kbd "<C-x-left>")  'shrink-window-horizontally)
(global-set-key (kbd "<C-x-right>") 'enlarge-window-horizontally)

;;; buffer swap
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;;; set inconsolata font, install before using it
;;(set-default-font "Inconsolatazi4-12")
;;(set-default-font "Consolas-11")
;;(set-default-font " DejaVu Sans Mono")
;;;; copy-line with variable arugments
(defun copy-line (&optional arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line(s) copied" arg ))

(global-set-key "\C-c\C-k" 'copy-line)

;;;;;;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;;;;Ace Jump Mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
 
;; enable a more powerful jump back function from ace jump mode
(autoload   'ace-jump-mode-pop-mark  "ace-jump-mode"  "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;;;; Ace Jump Buffer
(define-key global-map (kbd "C-c b SPC") 'ace-jump-buffer)

;;; Open Lines
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;;;; Rebind goto-line line
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(global-set-key [remap goto-line] 'goto-line-with-feedback)

;;;;Join Line
(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))

;; Auto refresh buffers
(global-auto-revert-mode 0)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;;;; Jump Char
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)
;;   <char>   :: move to the next match in the current direction.
;;   ;        :: next match forward (towards end of buffer)
;;   ,        :: next match backward (towards beginning of buffer)
;;   C-c C-c  :: invoke ace-jump-mode if available (also <M-/>)

;;;; Paredit-wrap-round-from-behind
(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round)
  (insert " ")
  (forward-char -1))

;;(define-key paredit-mode-map (kbd "M-)")  'paredit-wrap-round-from-behind)
;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pretty print xml in region

(defun nxml-pretty-print-region (begin end)
  "Pretty format XML markup in region. The function inserts linebreaks to
    separate tags that have  nothing but whitespace between them.
    It then indents the markup by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    ;; split  or , but not 
    (goto-char begin)
    (while (search-forward-regexp ">[ \t]*<[^/]" end t)
      (backward-char 2) (insert "\n") (incf end))
    ;; split  and 
    (goto-char begin)
    (while (search-forward-regexp "<.*?/.*?>[ \t]*<" end t)
      (backward-char) (insert "\n") (incf end))
    ;; put xml namespace decls on newline
    (goto-char begin)
    (while (search-forward-regexp "\\(<\\([a-zA-Z][-:A-Za-z0-9]*\\)\\|['\"]\\) \\(xmlns[=:]\\)" end t)
      (goto-char (match-end 0))
      (backward-char 6) (insert "\n") (incf end))
    (indent-region begin end nil)
    (normal-mode))
  (message "All indented!"))


(defun nxml-pretty-print-buffer ()
  "pretty print the XML in a buffer."
  (interactive)
  (nxml-pretty-print-region (point-min) (point-max)))

(defun nxml-kill-tag-contents ()
  "Copy the contents between two tags"
;  (interactive "*p\ncCopy tag contents: ") ; this expects arguments input
  (interactive)
  (nxml-backward-up-element)
  (kill-region
    (progn (search-forward ">")
      (point))
    (progn (nxml-backward-up-element)
      (nxml-forward-element)
      (search-backward "</")
      (point))))

(defun nxml-copy-tag-contents ()
  "Copy the contents between two tags"
;  (interactive "*p\ncCopy tag contents: ") ; this expects arguments input
  (interactive)
  (nxml-backward-up-element)
  (copy-region-as-kill
   (progn (search-forward ">") (point))
   (progn (nxml-backward-up-element)
     (nxml-forward-element)
     (search-backward "</")
     (point))))

;;;; org-mode setup
(setq org-replace-disputed-keys t)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.txt$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)
(setq org-directory "~/notes/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-include-all-todo t)
(setq org-agenda-include-diary t)
;(setq org-agenda-ndays 7)
(setq org-agenda-show-all-dates t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-start-on-weekday nil)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)
(setq org-todo-keywords 
       '((sequence "TODO" 
                   "IN-PROGRESS"
                   "PENDING"
                   "CANCELLED"
                   "DONE")))

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)


(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cj" 'org-journal-entry)
(define-key global-map "\C-cc" 'org-capture)

;;;;;; Default Browser
(setq browse-url-browser-function 'browse-url-generic)
;;(add-to-list 'exec-path "/cygdrive/c/Documents and Settings/sk46584/Local Settings/Application Data/Google/Chrome/Application")
;;(setq browse-url-generic-program "Chrome")

;;;; Web Jump
(global-set-key (kbd "C-x g") 'webjump)

;;;; Deft

(when (require 'deft nil 'noerror) 
   (setq
      deft-extension "org"
      deft-directory "~/notes/"
      deft-text-mode 'org-mode)
   (global-set-key (kbd "<f9>") 'deft))

;;;;;; Cider

;;Enable eldoc in Clojure buffers:
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;;You can hide the *nrepl-connection* and *nrepl-server* buffers from
;;appearing in some buffer switching commands like switch-to-buffer(C-x b) like this:
(setq nrepl-hide-special-buffers t)

;;When using switch-to-buffer, pressing SPC after the command will make the hidden buffers visible.
;;They'll always be visible in list-buffers (C-x C-b).

(setq cider-repl-tab-command 'indent-for-tab-command)

;;Prevent the auto-display of the REPL buffer in a separate window after connection is established:
(setq cider-repl-pop-to-buffer-on-connect nil)

;;Stop the error buffer from popping up while working in buffers other than the REPL:
;(setq cider-popup-stacktraces nil)

;;Enable error buffer popping also in the REPL:
;(setq cider-repl-popup-stacktraces t)

;;To auto-select the error buffer when it's displayed:
(setq cider-auto-select-error-buffer t)

;;The REPL buffer name has the format *cider-repl project-name*.
;;Change the separator from space to something else by overriding nrepl-buffer-name-separator.
(setq nrepl-buffer-name-separator "-")

;;The REPL buffer name can also display the port on which the nREPL
;;server is running. 
;;Buffer name will look like cider-repl project-name:port.
(setq nrepl-buffer-name-show-port t)

;;Make C-c C-z switch to the CIDER REPL buffer in the current window:
(setq cider-repl-display-in-current-window t)

;;Limit the number of items of each collection the printer will print to 100:
(setq cider-repl-print-length 100) ; the default is nil, no limit

;;Prevent C-c C-k from prompting to save the file corresponding to the buffer being loaded, if it's modified:
;(setq cider-prompt-save-file-on-load nil)

;;Change the result prefix for REPL evaluation (by default there's no prefix):
;(set cider-repl-result-prefix ";; => ")

;;And here's the result of that change:
;;user> (+ 1 2)
;; ;; => 3

;;Change the result prefix for interactive evaluation (by default it's =>):
;(set cider-interactive-eval-result-prefix ";; => ")
;;To remove the prefix altogether just set it to an empty string("").

;;Normally code you input in the REPL is font-locked with cider-repl-input-face (after you press RET) and results are font-locked with cider-repl-output-face.
;;If you want them to be font-locked as in clojure-mode use the following:
;(setq cider-repl-use-clojure-font-lock t)

;;You can control the C-c C-z key behavior of switching to the REPL buffer with the cider-switch-to-repl-command variable.
;;While the default command cider-switch-to-relevant-repl-buffer should be an adequate choice for most users,
;;cider-switch-to-current-repl-buffer offers a simpler alternative where CIDER will not attempt to match the
;;correct REPL buffer based on underlying project directories:
;(setq cider-switch-to-repl-command 'cider-switch-to-current-repl-buffer)

;;REPL History
;;To make the REPL history wrap around when its end is reached:
(setq cider-repl-wrap-history t)

;;To adjust the maximum number of items kept in the REPL history:
(setq cider-repl-history-size 1000) ; the default is 500

;;To store the REPL history in a file:
(setq cider-repl-history-file "./cider-repl-history.txt")

;;Note that the history is written to the file when you kill the REPL buffer (which includes invoking cider-quit) or you quit Emacs.

;;;;;; cider end 

;;;;; smartparens

(smartparens-global-mode t)
;; highlights matching pairs
(show-smartparens-global-mode t)
(paredit-mode 0)

;;; bookmark+
