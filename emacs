; *** elisp ***

;; convenience
;; (normal-erase-is-backspace-mode)

(setq emacs22up (>= emacs-major-version 22))
(setq emacs21up (>= emacs-major-version 21))
(setq emacs20up (>= emacs-major-version 20))
(setq emacs19up (>= emacs-major-version 19))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Window Font, Size and Position
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-frame-alist '( (left . -1) (top . 0) (width . 90)  (height . 50) )) 
(setq initial-frame-alist '( (left . 0)  (top . 0) (width . 110) (height . 60) ))

; To get the font name from a dialog, execute (in *scratch* buffer):
;	  (insert (prin1-to-string (w32-select-font)))	 ; Emacs 20
; To see the complete list of fonts:
;	  (insert (prin1-to-string (x-list-fonts "*")))
;
;(set-default-font "-*-Andale Mono-normal-r-*-*-13-*-*-*-c-*-iso8859-1")
;(set-default-font "-adobe-courier-medium-r-normal--12-120-*-*-m-*-iso8859-1")
;(set-default-font "fixed")
; (set-default-font "-*-bitstream vera sans mono bold-bold-r-normal--*-132-*-*-m-*-*-*")

(setq myfont "-apple-bitstream vera sans mono-medium-r-normal--0-0-0-0-m-0-iso10646-1")
; (setq myfont "Bitstream Vera Sans Mono-9")
(if emacs22up 
      (progn 
	(set-default-font myfont)
	(add-to-list 'default-frame-alist (cons 'font myfont))
	(setq completion-ignore-case t)         ;; Don't worry about case for filenames
	)
      ;;; else
      (set-default-font "fixed")
)

; fix the clipboard
;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Set Paths
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq load-path
      (append load-path (list
	(expand-file-name "~/.emacs.d")
	(expand-file-name "~/pub/site-lisp")
	(expand-file-name "/usr/local/site-lisp")
	(expand-file-name "/sw/share/emacs/site-lisp/")
	(expand-file-name "~/.emacs.d/flip-custom")
	(expand-file-name "~/.emacs.d/yaml-mode")
	(expand-file-name "/sw/share/emacs/site-lisp/rails")
	;; (expand-file-name "~/.emacs.d/ruby")
	;; (expand-file-name "~/.emacs.d/nxml")
	;; (expand-file-name "~/.emacs.d/rails")
	;; (expand-file-name "~/.emacs.d/rinari")
	;; (expand-file-name "~/.emacs.d/rinari/rhtml")
	;; (expand-file-name "~/.emacs.d/predictive")
	;; (expand-file-name "~/.emacs.d/predictive/html")
	;; (expand-file-name "~/.emacs.d/cedet/common")
	;; (expand-file-name "~/.emacs.d/cedet")
	;; (expand-file-name "~/.emacs.d/ecb")
	)))

(require 'info)
(setq Info-directory-list
      (append Info-directory-list (list
	(expand-file-name "/usr/info")
	(expand-file-name "/usr/local/info")
	(expand-file-name "/usr/share/info")
	(expand-file-name "/usr/share/doc/python-docs-2.2.1/info/")
	(expand-file-name "~/pub/info")
	)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; remote file access
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'tramp)
(setq tramp-default-method "scp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Collection of Emacs Dev Tools
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (locate-library "filecache")	(require 'filecache))
(when (and (locate-library "cedet") emacs22up)
      (require 'snippet)
      ;;(load "~/.emacs.d/nxml/autostart.el")
      ;;(require  'rinari)
      )

;; (when (and (locate-library "cedet") emacs22up)
;;   (progn
;;     (require 'cedet)
;;     (require 'ecb-autoloads)
;;     ;; Enabling various SEMANTIC minor modes. See semantic/INSTALL for more ideas. Select one of the following
;;     ;; (semantic-load-enable-code-helpers)
;;     (semantic-load-enable-gaudy-code-helpers)
;;     ;; (semantic-load-enable-excessive-code-helpers)
;;     ;; Enable this if you develop in semantic, or develop grammars
;;     ;; (semantic-load-enable-semantic-debugging-helpers)
;;     (custom-set-variables
;;      '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
;;      '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
;;      '(global-semantic-idle-summary-mode t nil (semantic-idle))
;;      '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
;;      '(semantic-imenu-bucketize-type-members nil)
;;      '(semantic-stickyfunc-indent-string        "   ")
;;      '(semanticdb-default-save-directory        "/home/flip/.emacs.d/flip-custom/semanticdb")
;;      '(semanticdb-default-system-save-directory "/home/flip/.emacs.d/flip-custom/semanticdb")
;;      '(semanticdb-global-mode t nil (semanticdb))
;;      '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
;;      '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
;;      '(global-semantic-idle-summary-mode t nil (semantic-idle))
;;      '(global-semantic-stickyfunc-mode t nil (semantic-util-modes))
;;      '(semantic-imenu-bucketize-type-members nil)
;;      '(semantic-stickyfunc-indent-string "   ")
;;      )
;;     (autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
;;     (autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
;;     (define-key-after (lookup-key global-map [menu-bar tools])
;;       [speedbar] '("Speedbar" . speedbar-frame-mode) [calendar])
;;     (global-set-key [(f3)] 'speedbar-get-focus)
;;     ;; (require 'nxmlautostart)
;;     ;; Texinfo fancy chapter tags
;;     (add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;;     ;; HTML fancy chapter tags
;;     (add-hook 'html-mode-hook (lambda ()    (require 'sb-html)))
;;     ))

;; (Defun try-complete-abbrev (old) (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
	try-complete-file-name
	try-expand-dabbrev))


(when (and (locate-library "predictive") emacs22up)
  (progn
    (require 'predictive)
    (set-default 'predictive-auto-add-to-dict t)
    (autoload    'predictive-setup-html "predictive-html.el" "predictive html dictionary" t)    ;; html
    (setq 
	  predictive-auto-learn t
	  predictive-add-to-dict-ask nil
	  predictive-use-auto-learn-cache nil
	  predictive-which-dict t)
    ))



;; (defun imw-find-file ()
;;  "Prompt for a `name' and scan the `lib' and `spec' directories in the IMW root directory ($IMW_ROOT) and open the first file matching `name.rb'"
;;  (interactive)
;;  (let* ((name (read-from-minibuffer "IMW File: "))
;;                 (files (split-string
;;                                 (concat
;;                                  (shell-command-to-string "find $IMW_ROOT/lib")
;;                                  (shell-command-to-string "find $IMW_ROOT/spec"))
;;                                 "\n")))
;;        (find-file (catch 'break
;;                                 (dolist (file files)
;;                                   (if (string-match (concat "/" name "\\.rb$") file)
;;                                           (throw 'break file)))))))
;; (define-key ruby-mode-map "\C-cf" 'imw-find-file)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Set miscellaneous emacs prefs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(if emacs21up
    (progn 
      ;; Turn off blinking cursor
      (blink-cursor-mode -1)
) nil)

(if emacs20up
    (progn
      ;; Fancy-pants buffer menus
      (require 'msb)
      (msb-mode 1)

      ;; Enable the mouse wheel
      (require 'mwheel)
      (mouse-wheel-mode 1)
      ;; How much to scroll when normal or when shift held down.
      (setq mouse-wheel-scroll-amount 
	    '(4				  ;; lines with no mod
	      ((shift) . 1)		  ;; lines with shift
	      ((control) . nil)		  ;; lines with control
	      ))

      ;; Uniquify buffer names. This makes identical buffer names unique via its
      ;; directory path.
      (require 'uniquify)
      (setq uniquify-buffer-name-style 'post-forward-angle-brackets)

      ;; Display column number on mode line
      (column-number-mode t)

      (custom-set-variables
       ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
       ;; Your init file should contain only one such instance.
       '(case-fold-search t)
       '(current-language-environment "Latin-1")
       '(default-input-method "latin-1-prefix")
       '(mark-even-if-inactive t)
       '(show-paren-mode t nil (paren))
       '(transient-mark-mode t))
) nil) 


;; Several mysterious but important customizations.
(set-input-mode t nil t)
(put 'eval-expression	 'disabled nil)
(put 'narrow-to-region	 'disabled nil)
(put 'upcase-region	 'disabled nil)
(put 'downcase-region	 'disabled nil)
;; prompt for it on save
(setq require-final-newline	 t)
;; flash instead of that annoying bell
(setq visible-bell		 t)

;;; If you ever have to load a file and see the ^M's exec this line
;(set-variable inhibit-eol-conversion t)   ;; see  ^M's
;(set-variable inhibit-eol-conversion nil) ;; hide ^M's

;; Highlight selected regions
(setq transient-mark-mode	 t)
;; But don't go killing mark, it's not nice.
(setq mark-even-if-inactive	 t)
;; Chop display of long lines instead of wrapping to next line.
(setq default-truncate-lines	 t)

;; Put all the backup files in one directory,
;; instead of leaving ~ turds all over the place.
(setq backup-directory-alist
      (list (cons "." (expand-file-name "~/.emacs.d/auto-backups/"))))

;; Prepare Desktop; load with F5, save with C-F5
;; (load-library "desktop")
;; (desktop-load-default)

;; Display "[buffer] in Frame, filename" in title
(setq frame-title-format "[%b] in %F, %f")
;; But just buffer name for icon.
(setq icon-title-format "%b")

;; Initialize sunrise/sunset settings. Capitol dome coordinates.
(setq calendar-latitude	 [30 16 north])
(setq calendar-longitude [97 44 west ])
(setq calendar-location-name "Austin, TX")

;;Occasionally useful:
;; Add Line numbers when printing (GREAT when printing out code)
;;(setq ps-line-number t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Hiliting  (should be before modes)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if emacs20up
    (progn

      ;; Colorized fonts
      ;; Turn on font-lock in all modes that support it
      (global-font-lock-mode t)
      ;; Maximum colors
      (setq font-lock-maximum-decoration t)
      ;; (setq font-lock-support-mode	 'lazy-lock-mode)	    ;;
      ;; (setq lazy-lock-defer-time	 2)			    ;;
      ;; (setq lazy-lock-stealth-time	 5)			    ;;

      ;; used (describe-key-briefly "\C-l") to discover what ^L is bound to,
      ;; namely recenter
      ;; done right, this would not rely on that fact.
      (global-set-key	(kbd "C-l")	 'font-lock-and-redraw)
      (defun font-lock-and-redraw ()
	"Force a font-lock-fontify-buffer and then do the redraw"
	(interactive)
	(font-lock-fontify-buffer)
	(recenter)
	)

      (custom-set-faces
       ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
       ;; Your init file should contain only one such instance.
       '(font-lock-builtin-face ((((class color) (background light)) (:foreground "DarkSlateBlue"))))
       '(font-lock-comment-face ((((class color) (background light)) (:foreground "#004000"))))
       '(font-lock-keyword-face ((((class color) (background light)) (:foreground "DodgerBlue3"))))
       '(font-lock-string-face ((((class color) (background light)) (:foreground "Tan4"))))
       '(font-lock-type-face ((((class color) (background light)) (:foreground "DarkSlateBlue"))))
       '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "Gray30"))))
       '(isearch ((((class color) (background light)) (:background "burlywood" :foreground "Black"))))
       '(isearch-lazy-highlight-face ((((class color) (background light)) (:background "Beige" :foreground "FireBrick"))))
       '(region ((((class color) (background light)) (:background "honeydew2"))))
       '(secondary-selection ((t (:background "lavender"))))
       '(show-paren-match-face ((t (:background "bisque" :foreground "firebrick"))))
       '(trailing-whitespace ((((class color) (background light)) (:background "cornsilk2")))))
) nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Indentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; http://www.jwz.org/doc/tabs-vs-spaces.html
;; In Emacs, to set the mod-N indentation used when you hit the TAB
;; key, do this:
;;	(setq c-basic-indent 2)
;; To cause the TAB file-character to be interpreted as mod-N
;; indentation, do this:
;;	(setq tab-width 4)
;; To cause TAB characters to not be used in the file for compression,
;; and for only spaces to be used, do this:
(setq indent-tabs-mode nil)

(defun indent-buffer ()
  "Indent the current buffer."
  (interactive)
  (indent-region (point-min) (point-max) nil)
)

(defun right-justify-line ()
  "Justify the current line to the right"
  (interactive)
  (justify-current-line 'right)
)

(defun indent-line-or-region-rigidly   (b e n) "indent-rigidly by arg tab-widths"
  (interactive "r\np")
  (save-excursion
    (let (deactivate-mark)
      (if (or (= b e) (not mark-active))
	  (progn
	    (end-of-line)
	    (let ((eol (point)))
	      (beginning-of-line)
	      (indent-rigidly (point) eol (* tab-width n))))
	(indent-rigidly b e (* tab-width n))))))
(defun unindent-line-or-region-rigidly (b e n) "(un)indent-rigidly by -arg tab-widths"
  (interactive "r\np")
  (indent-line-or-region-rigidly b e (* -1 n)))


;;; Bug: kills line and newline. o wells
(defun delete-line () "deletes the line forward"
  (interactive "")
  (save-excursion
    (delete-region (point) (progn (forward-visible-line 1) (point))) ))
(defun delete-next-word () "deletes (without copying) the next word"
  (interactive "")
  (save-excursion
    (delete-region (point) (progn (forward-word) (point))) ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set Modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;
;; ------------------ Magic for Rails Mode ----------------
;;

;; 
(if emacs22up (require  'rails))
 
;;
;; ------------------ Magic for Ruby Mode ----------------
;;

;; If you have Emacs 19.2x or older, use rubydb2x
;; (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
;; uncomment the next line if you want syntax highlighting

(defun rails-add-proj-to-file-cache (dir)
  "Adds all the ruby and rhtml files recursively in the current directory to the file-cache"
  (interactive "DAdd directory: ")
    (file-cache-clear-cache)
    (file-cache-add-directory-recursively dir (regexp-opt (list ".rb" ".rhtml" ".html.erb" ".xml" ".xml.erb" ".js" ".js.erb" ".yml" ".yaml" ".yml.erb" ".yaml.erb")))
    (file-cache-delete-file-regexp "\\.svn")
    (file-cache-delete-file-regexp "\\.DS_Store")
    (file-cache-delete-file-regexp "\\.Icon.")
    )

(defun ruby-eval-buffer () (interactive)
   "Evaluate the buffer with ruby."
   (shell-command-on-region (point-min) (point-max) "ruby"))

(add-hook 'ruby-mode-hook
	  (lambda()
	    (add-hook 'local-write-file-hooks
		      '(lambda()
			 (save-excursion
			   (untabify (point-min) (point-max))
			   (delete-trailing-whitespace)
			   )))
	    (set (make-local-variable 'indent-tabs-mode) 'nil)
	    (imenu-add-to-menubar "IMENU")
	    (require 'ruby-electric)
	    (ruby-electric-mode t)
	    (inf-ruby-keys)
	    (rails-minor-mode)
	    ))

;; (add-hook 'ruby-mode-hook 'turn-on-font-lock)



;;
;; ------------------ Magic for Text Mode ----------------
;;
(setq default-major-mode 'text-mode)
(setq text-mode-hook
      '(lambda ()
	 (setq fill-column 80)
	 (text-mode-hook-identify)
	 ))
;;	 (turn-on-auto-fill)

;;
;; ------------------ Magic for Makefile Mode ----------------
;;
;; Compilation mode
(setq compile-command "cd . ; make -j4 -k")

;;
;; ------------------ Magic for C Mode ----------------------
;;

(defconst my-c-style
  '((c-basic-offset . 2)
    (c-comment-only-line-offset . (0 . 0))
    (c-offsets-alist . ((statement-block-intro . +)
			(knr-argdecl-intro . 4)
			(substatement-open . +)
			(label . 0)
			(statement-case-open . +)
			(statement-cont . +)
			(arglist-intro . c-lineup-arglist-intro-after-paren)
			(arglist-close . c-lineup-arglist)
			(inline-open . 0)
			(brace-list-open . +)
			))
    (c-special-indent-hook . c-gnu-impose-minimum)
    (c-block-comment-prefix . "")
    (c-tab-always-indent    . nil)		   ; Tab, midline, gives actual tab?
    (c-cleanup-list	    . (brace-else-brace))  ; fix "} else {"
    (c-hanging-braces-alist . ((brace-list-open)
			       (brace-entry-open)
			       (substatement-open after)
			       (block-close . c-snug-do-while)))
    ;; Be verbose
    (c-echo-syntactic-information-p . t)
    )
  "Flip's C Programming Style")

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; adds and sets my-c-style
  (c-add-style "personal" my-c-style t)
  ;; other customizations
  (setq tab-width 8  indent-tabs-mode nil)
  (c-toggle-hungry-state -1)
  (c-toggle-auto-state	 -1)
  (define-key c-mode-base-map "\C-m"	'c-context-line-break)
  (define-key c-mode-base-map "\M-q"	'indent-region)
  (define-key c-mode-base-map "\M-\C-q" 'c-fill-paragraph)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; javascript mode
(add-hook 'javascript-mode-hook
      '(lambda ()
         (setq tab-width 8 indent-tabs-mode nil)
         ))

;; nxhtml mode
(add-hook 'nxml-mode-hook
      '(lambda ()
         (setq tab-width 8 indent-tabs-mode nil)
         (set-variable 'nxml-child-indent 2)
         (set-variable 'nxml-attribute-indent 2)
         ))
    


;; ------------------ Magic for Shell Mode ----------------
(set-variable 'comint-scroll-to-bottom-on-input t)

;;
;; ------------------ Handy functions --------------
;;

;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")
  ;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0)) (goto-char beginning)
  ;;; 2. Run the while loop.
      (while (and (< (point) end) (re-search-forward "\\w+\\W*" end t)) (setq count (1+ count)))
  ;;; 3. Send a message to the user.
      (cond ((zerop count)   (message "The region does NOT have any words."))
	    ((= 1 count)     (message "The region has 1 word."))
	    (t		     (message "The region has %d words." count))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   Set keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The new user-option `normal-erase-is-backspace' can be set to
;; determine the effect of the Delete and Backspace function keys.

;; On window systems, the default value of this option is chosen
;; according to the keyboard used.  If the keyboard has both a
;; Backspace key and a Delete key, and both are mapped to their usual
;; meanings, the option's default value is set to t, so that Backspace
;; can be used to delete backward, and Delete can be used to delete
;; forward.  On keyboards which either have only one key (usually
;; labeled DEL), or two keys DEL and BS which produce the same effect,
;; the option's value is set to nil, and these keys delete backward.

;; If not running under a window system, setting this option
;; accomplishes a similar effect by mapping C-h, which is usually
;; generated by the Backspace key, to DEL, and by mapping DEL to C-d
;; via `keyboard-translate'.  The former functionality of C-h is
;; available on the F1 key.  You should probably not use this setting
;; on a text-only terminal if you don't have both Backspace, Delete
;; and F1 keys.

(normal-erase-is-backspace-mode)
(global-set-key	  [delete]	    'delete-char)
;(global-set-key   [backspace]	     'backward-delete-char)

(global-set-key	  [C-delete]	    'kill-word)
(global-set-key	  [C-backspace]	    'backward-kill-word)

(global-set-key	  (kbd "C-s-.")	    'overwrite-mode)
(global-set-key   (kbd "C-c w")     'delete-trailing-whitespace)   ;; http://bsdaemon.blogspot.com/2006/01/handling-eol-whitespace-in-emacs.html
(global-set-key	  (kbd "C-m")	    'newline-and-indent)

(global-set-key	  [home]	    'beginning-of-line)
(global-set-key	  [M-left]	    'beginning-of-line)
(global-set-key	  [end]		    'end-of-line)
(global-set-key	  [M-right]	    'end-of-line)

(global-set-key	  [C-left]	    'backward-word)
(global-set-key	  [s-left]	    'backward-word)
(global-set-key	  [C-kp-left]	    'backward-word)
(global-set-key	  [s-kp-left]	    'backward-word)
(global-set-key	  [C-kp-4]	    'backward-word)
(global-set-key	  [s-kp-4]	    'backward-word)
(global-set-key   (kbd "\e[1;5D")   'backward-word)

(global-set-key	  [C-right]	    'forward-word)
(global-set-key	  [s-right]	    'forward-word)
(global-set-key	  [C-kp-right]	    'forward-word)
(global-set-key	  [s-kp-right]	    'forward-word)
(global-set-key	  [C-kp-6]	    'forward-word)
(global-set-key	  [s-kp-6]	    'forward-word)
(global-set-key   (kbd "\e[1;5C")   'forward-word)

(global-set-key	  [s-up]	    'backward-paragraph)
(global-set-key	  [C-kp-up]	    'backward-paragraph)
(global-set-key	  [s-kp-up]	    'backward-paragraph)
(global-set-key	  [s-kp-8]	    'backward-paragraph)
(global-set-key   (kbd "\e[1;5B")   'backward-paragraph)

(global-set-key	  [s-down]	    'forward-paragraph)
(global-set-key	  [C-kp-down]	    'forward-paragraph)
(global-set-key	  [s-kp-down]	    'forward-paragraph)
(global-set-key	  [s-kp-2]	    'forward-paragraph)
(global-set-key   (kbd "\e[1;5A")   'forward-paragraph)

(global-set-key	  [C-prior]	    'beginning-of-buffer)
(global-set-key	  [C-kp-prior]	    'beginning-of-buffer)
(global-set-key	  [C-kp-9]	    'beginning-of-buffer)
(global-set-key	  [C-next]	    'end-of-buffer)
(global-set-key	  [C-kp-next]	    'end-of-buffer)
(global-set-key	  [C-kp-3]	    'end-of-buffer)

(global-set-key   (kbd "M-s-<up>") 	'backward-up-list)
(global-set-key   (kbd "M-s-<down>") 	'down-list)
(global-set-key   (kbd "M-s-<left>") 	'backward-sexp)
(global-set-key   (kbd "M-s-<right>")  	'forward-sexp)
(global-set-key   (kbd "M-s-S-<left>")  'backward-list)
(global-set-key   (kbd "M-s-S-<right>") 'forward-list)

(global-set-key	  [S-delete]	    'kill-region)
(global-set-key	  [C-insert]	    'copy-region-as-kill)
(global-set-key	  [S-insert]	    'yank)
(global-set-key	  [C-S-insert]	    'yank-pop)
(global-set-key	  [C-Delete]	    'kill-word)
(global-set-key	  (kbd "C-z")	    'undo)
(global-set-key	  (kbd "C-v")	    'yank)
(global-set-key	  (kbd "M-v")	    'yank)
(global-set-key	  (kbd "M-c")	    'copy-region-as-kill)
(global-set-key	  (kbd "M-C-c")	    'capitalize-word)

; see below for "\C-l"
(global-set-key	  (kbd "M-g")	    'goto-line)
(global-set-key	  (kbd "M-r")	    'query-replace-regexp)
(global-set-key	  (kbd "C-M-r")	    'query-replace)

;; (global-unset-key (kbd "C-M-3")	    )
(global-set-key	  (kbd "C-M-3")	    'comment-region)
(global-set-key	  (kbd "C-M-#")	    'comment-region)
(global-set-key	  (kbd "C-s-3")	    'uncomment-region)	;;; this is C-<option>-3
(global-set-key	  (kbd "C-s-#")	    'uncomment-region)	;;; this is C-S-<option>-3
(global-set-key	  (kbd "M-m")	    'set-mark-command)

(global-set-key	  (kbd "C-x C-u")   'undo)
(global-set-key	  (kbd "C-x C-i")   'insert-buffer)
(global-set-key	  (kbd "C-x f")	    'find-file)	       ;Overrides C-x f as set-fill-column
(global-set-key	  (kbd "C-x C-r")   'insert-file)

(global-set-key	  [C-f9]	    'compile)
(global-set-key	  [C-find]	    'compile)
(global-set-key	  (kbd "M-s")	    'tags-search)

(global-set-key	  (kbd "C-x C-n")   'next-error)
(global-set-key	  [find]	    'next-error)
(global-set-key	  [f9]		    'next-error)

(global-set-key	  (kbd "<f4>")	    'repeat-complex-command)
(global-set-key	  (kbd "<C-f4>")    'repeat)

(global-set-key	  (kbd "<f5>")	    'desktop-read)
(global-set-key	  (kbd "<C-f5>")    'desktop-save)
(global-set-key	  (kbd "<C-M-f5>")  'desktop-clear)

(defun fixnewlines  () "Turn ^M into ^J."  (interactive) (replace-string "\C-M" "\C-j"))
(global-set-key	  (kbd "C-M-^")	    'fixnewlines)

;; Fix the annoying accelerator issue on Mac
(global-set-key	  (kbd "C-M-x")	    'execute-extended-command)
(global-set-key	  (kbd "C-M-q")	    'fill-paragraph)
(global-set-key	  (kbd "C-M-,")	    'tags-loop-continue)
(global-set-key	  (kbd "M-n")	    'make-frame-command)
(global-set-key	  (kbd "M-z")	    'undo)

;; make S-<key> do the delete equivalent of M-<key> for kills
(global-set-key   (kbd "s-w")       'delete-region)
(global-set-key   (kbd "s-k")       'delete-line)
(global-set-key   (kbd "s-d")       'delete-next-word)


(defun set-tab-width-4 () "Sets tab width to 4" (interactive) (setq tab-width 4) (font-lock-and-redraw))
(defun set-tab-width-2 () "Sets tab width to 4" (interactive) (setq tab-width 4) (font-lock-and-redraw))
(defun set-tab-width-8 () "Sets tab width to 8" (interactive) (setq tab-width 8) (font-lock-and-redraw))
(global-set-key (kbd "C-x C-2")	  'set-tab-width-4)
(global-set-key (kbd "C-x C-4")	  'set-tab-width-4)
(global-set-key (kbd "C-x C-8")	  'set-tab-width-8)

(global-set-key (kbd "<S-tab>")	  'unindent-line-or-region-rigidly)
(global-set-key (kbd "<C-tab>")	    'indent-line-or-region-rigidly)

(global-set-key (kbd "C-c C-e")	  'ecb-activate)
(global-set-key [C-f1]   	  'customize-apropos)

(global-set-key [f8]    	  'kmacro-end-and-call-macro)

(global-set-key (kbd "C->") 'nxml-finish-element)
(global-set-key (kbd "C-/") 'nxml-complete)

(global-set-key (kbd "C-x C-z") 'undo)


(add-hook 'nxhtml-mode-hook
  '(lambda ()
     '(define-key 	  nxhtml-mode-map (kbd "C-/") 'nxml-complete)
     '(define-key 	  nxhtml-mode-map (kbd "C->") 'nxml-finish-element)
     ;; '(define-key nxhtml-mode-map "C-<" ')
     ))

(defun Buffer-menu-sort-by-path () "Sort buffer menu by pathname"  (interactive) (Buffer-menu-sort 5))
(global-set-key (kbd "C-c C-s") 'Buffer-menu-sort-by-path)
;; ;; can't get this to work.
;; (add-hook 'buffer-menu-mode-hook
;;   '(lambda ()
;;      '(define-key 	  Buffer-menu-mode-map (kbd "C-c C-d") 'Buffer-menu-sort-by-path)
;;      ))
	 

;;
;; ------------------ Python-mode ----------------
;;

;; Make with the flymake for python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "emacs-pylint.py" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))

;;
;; ------------------ Mode-specific keys ----------------
;;

(setq python-mode-hook 
      '(lambda ()
	 (define-key py-mode-map		[C-f9]		'execute-extended-command)
	 (define-key py-mode-map		[C-f8]		'fill-paragraph)
	 (define-key py-mode-map		(kbd "C-M-,")	'tags-loop-continue)
	 (define-key py-mode-map	   	(kbd "C-M-x")	'execute-extended-command)
	 ))
(setq lisp-mode-hook 
      '(lambda ()
	 (define-key lisp-mode-shared-map	[C-f9]		'execute-extended-command)
	 (define-key lisp-mode-shared-map	[C-f8]		'fill-paragraph)
	 (define-key lisp-mode-shared-map	(kbd "C-M-,")	'tags-loop-continue)
	 (define-key lisp-mode-map      	(kbd "C-M-x")	'execute-extended-command)
	 ))
(setq emacs-lisp-mode-hook 
      '(lambda ()
	 (define-key emacs-lisp-mode-map	[C-f9]		'execute-extended-command)
	 (define-key emacs-lisp-mode-map	[C-f8]		'fill-paragraph)
	 (define-key emacs-lisp-mode-map	(kbd "C-M-,")	'tags-loop-continue)
	 (define-key emacs-lisp-mode-map	(kbd "C-M-x")	'execute-extended-command)
	 ))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (set (make-local-variable 'indent-tabs-mode) 'nil)
	     (set (make-local-variable 'indent-tabs-mode) 'nil)
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)
	     ))



;;
;; ------------------ Add extensions to Mode list ----------------
;;

(autoload 'actionscript-mode	"actionscript-mode.el"	"Major mode for Flex/Actionscript .as files." t)
(autoload 'longlines-mode	"longlines.el"		"Minor mode for automatically wrapping long lines." t)
(autoload 'nxml-mode		"nxml-mode.el"		"Major mode for XML files." t)
(autoload 'css-mode		"css-mode.el"		"Major mode for CSS files." t)
;; (autoload 'matlab-mode		"matlab-mode"		"Enter Matlab mode." t)
(autoload 'python-mode		"python-mode"		"Mode for editing python files." t)
(autoload 'yaml-mode		"yaml-mode"		"Mode for editing YAML files." t)
(autoload 'ruby-mode		"ruby-mode"		"Ruby editing mode." t)
(autoload 'run-ruby 		"inf-ruby"		"Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys 	"inf-ruby"		"Set local key defs for inf-ruby in ruby-mode" t)
(autoload 'sass-mode            "sass-mode"             "Mode for SASS (CSS done right)" t)
(autoload 'haml-mode            "haml-mode"             "Mode for HAML" t)
;;(autoload 'taskpaper-mode       "taskpaper"             "Mode for tracking tasks" t)
;;;            (setq auto-mode-alist (copy-alist auto-mode-alist))
;;;          (set-alist-slot 'auto-mode-alist regexp function nil 'assoc))

;; To see the auto-mode-list type "auto-mode-alist" into *scratch*
;; and hit C-x-e, C-j...
(setq auto-mode-alist (append (list
    '("\\.as\\'"			. actionscript-mode)
    '("\\.m\\'"				. matlab-mode)
    '("\\.py.?\\'"			. python-mode)
    '("\\.ya?ml\\'"			. yaml-mode)
    '("\\([cC]ap\\|[Rr]ake\\)file\\'"	. ruby-mode)
    '("\\.\\(i|xs\\)\\'"		. c-mode)
    '("\\.\\(pl|pm|PL|PM\\)\\'"		. cperl-mode)
    '("\\.js\\(\\.erb\\)?\\'"		. javascript-mode)
    '("\\.css\\(\\.erb\\)?\\'"		. css-mode)
    '("\\.[rsx]html?\\(\\.erb\\)?\\'"	. nxhtml-mode)
    '("\\(M\\|m\\|GNUm\\)akefile\\([.-].*\\)?\\'" . makefile-mode)
    '("\\.\\(xml\\|xsl\\|xsd\\|kml\\|rng\\|mxml\\)\\(\\.erb\\)?\\'" . nxml-mode)
    '("\\.sass\\'"			. sass-mode)
    '("\\.haml\\'"			. haml-mode)
    ;; add more modes here
    ) auto-mode-alist))

(modify-coding-system-alist 'file "\\.\\(rb|py|pl|pm|PM|PL|js|as|xs\\)$"    'utf-8)
(modify-coding-system-alist 'file "\\.[rs]html\\(\\.erb\\)?$" 'utf-8)
(modify-coding-system-alist 'file "\\.\\(xml\\|xsl\\|xsd\\|kml\\|rng\\|[rsx]html?\\|mxml\\)\\(\\.erb\\)?$" 'utf-8 )

;;
;; ------------------ Magic for new shebangs ----------------
;;
;;; This alist applies to files whose first line starts with `#!'
(setq interpreter-mode-alist
      (append
       '(("python"  . python-mode))
       '(("python2" . python-mode))
       '(("ruby"    . ruby-mode))
       '(("perl"    . cperl-mode))
       interpreter-mode-alist))
;; if it's a shebang script, make is exemacutable
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;
;; ------------------ End of .emacs ----------------
;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote browse-url-firefox))
 '(browse-url-firefox-new-window-is-tab t)
 '(browse-url-mozilla-new-window-is-tab t)
 '(browse-url-mozilla-program "firefox")
 '(browse-url-save-file t)
 '(browse-url-xterm-program "mrxvt")
 '(case-fold-search t)
 '(comment-column 48)
 '(comment-empty-lines (quote (quote eol)))
 '(comment-multi-line nil)
 '(comment-style (quote indent))
 '(cperl-break-one-line-blocks-when-indent nil)
 '(cperl-comment-column 48)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-comment-at-column-0 t)
 '(cperl-indent-left-aligned-comments t)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-invalid-face nil)
 '(cperl-tab-always-indent nil)
 '(css-indent-offset 2)
 '(current-language-environment "UTF-8")
 '(default-input-method "latin-1-prefix")
 '(develock-max-column-plist (quote (emacs-lisp-mode nil lisp-interaction-mode nil change-log-mode nil texinfo-mode nil c-mode nil c++-mode nil java-mode nil jde-mode nil html-mode nil html-helper-mode nil cperl-mode nil perl-mode nil mail-mode nil message-mode nil cmail-mail-mode nil tcl-mode nil ruby-mode nil)))
 '(ecb-compile-window-height 7)
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-layout-name "left3")
 '(ecb-options-version "2.32")
 '(ecb-process-non-semantic-files nil)
 '(ecb-source-path (quote (("/Volumes/work/infochimp/vic" "vic") ("/home/flip/infochimp" "infochimp") ("/home/flip/now/vizsage" "vizsage") ("/home/flip" "flip"))))
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-height 0.2)
 '(ecb-windows-width 25)
 '(even-window-heights nil)
 '(fill-column 80)
 '(hippie-expand-dabbrev-skip-space t)
 '(html-site-list (quote (("mrflip" "~/www/mrflip.com/mrflip" "" "" "" "" "" nil "" "" "" "" "" "http://mrflip.com" "" ""))))
 '(indent-region-mode nil)
 '(inhibit-startup-screen t)
 '(javascript-indent-level 2)
 '(mac-option-modifier (quote super))
 '(mark-even-if-inactive t)
 '(mumamo-global-mode t)
 '(nxhtml-default-encoding (quote utf-8))
 '(nxhtml-global-minor-mode t)
 '(nxhtml-script-completion-pattern "\\.\\(?:js\\|js\\.erb\\)$")
 '(nxhtml-skip-welcome t)
 '(nxhtml-validation-header-if-mumamo t)
 '(nxml-attribute-indent 8)
 '(nxml-auto-insert-xml-declaration-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(perl-indent-continued-arguments 4)
 '(predictive-mode t)
 '(quickurl-url-file "~/.emacs.d/flip-custom/quickurls")
 '(rails-api-root "doc")
 '(read-file-name-completion-ignore-case t)
 '(rngalt-validation-header-bgcolor "#eeeeee")
 '(ruby-deep-indent-paren nil)
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(tab-always-indent nil)
 '(transient-mark-mode t)
 '(x-select-enable-clipboard t)
 '(yaml-indent-offset 4))

 ;;'(default ((t (:stipple nil :background "#f2f2f2" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :family "bitstream vera sans mono"))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(compilation-warning ((((class color) (min-colors 16)) (:foreground "#b86833" :weight bold))))
 '(cperl-array-face ((((class color) (background light)) (:foreground "#662288" :weight bold))))
 '(cperl-hash-face ((((class color) (background light)) (:foreground "#882266" :slant italic :weight bold))))
 '(cperl-nonoverridable-face ((((class color) (background light)) (:foreground "#660044"))))
 '(custom-changed ((((min-colors 88) (class color)) (:background "#2222dd" :foreground "#cccccc"))))
 '(custom-group-tag ((((min-colors 88) (class color) (background light)) (:inherit variable-pitch :foreground "blue1" :weight bold :height 1.2))))
 '(custom-group-tag-1 ((((min-colors 88) (class color) (background light)) (:inherit variable-pitch :foreground "#aa0000" :weight bold :height 1.2))))
 '(develock-bad-manner-face ((t (:background "#e8e8e8" :foreground "#805010" :weight bold))))
 '(develock-lonely-parentheses-face ((t (:background "white" :foreground "#202050"))))
 '(develock-long-line-face-1 ((t (:foreground "#330000"))))
 '(develock-long-line-face-2 ((t (:background "#ececb0" :foreground "#330000"))))
 '(develock-upper-case-attribute-face ((t (:background "#d0f0d0" :foreground "#004000"))))
 '(develock-upper-case-tag-face ((t (:background "#f0f0f0" :foreground "#400000"))))
 '(develock-whitespace-face-1 ((t (:background "white"))))
 '(develock-whitespace-face-2 ((t (:background "white"))))
 '(develock-whitespace-face-3 ((t (:background "white"))))
 '(font-lock-builtin-face ((((class color) (background light)) (:foreground "DarkSlateBlue"))))
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "#004000"))))
 '(font-lock-constant-face ((((class color) (background light)) (:foreground "#772828"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :foreground "#8888aa"))))
 '(font-lock-function-name-face ((((class color) (background light)) (:foreground "#501070"))))
 '(font-lock-keyword-face ((((class color) (background light)) (:foreground "DodgerBlue3"))))
 '(font-lock-negation-char-face ((t (:background "#f0e8e8"))))
 '(font-lock-string-face ((((class color) (background light)) (:foreground "Tan4"))))
 '(font-lock-type-face ((((class color) (background light)) (:foreground "DarkSlateBlue"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "Gray30"))))
 '(font-lock-warning-face ((t (:foreground "#a02020" :weight bold))))
 '(isearch ((((class color) (background light)) (:background "burlywood" :foreground "Black"))))
 '(lazy-highlight ((((class color) (background light)) (:background "Beige" :foreground "FireBrick"))))
 '(link ((((class color) (min-colors 88) (background light)) (:foreground "#000088" :underline t))))
 '(mode-line ((((class color) (min-colors 88)) (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button) :height 1.1 :family "Helvetica"))))
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background light)) (:background "#fffdfd"))))
 '(mumamo-background-chunk-submode ((((class color) (min-colors 88) (background light)) (:background "e0f05ff"))))
 '(nxml-attribute-prefix-face ((t (:inherit nxml-name-face :foreground "#222222"))))
 '(nxml-comment-content-face ((t (:foreground "#115522"))))
 '(nxml-delimited-data-face ((((class color) (background light)) (:foreground "#7b3A3A"))))
 '(nxml-name-face ((((class color) (background light)) (:foreground "#25257A"))))
 '(region ((((class color) (background light)) (:background "honeydew2"))))
 '(rng-error-face ((t (:underline "#eecccc"))))
 '(secondary-selection ((t (:background "lavender"))))
 '(sh-quoted-exec ((((class color) (background light)) (:foreground "#70002c"))))
 '(show-paren-match ((t (:background "bisque" :foreground "firebrick"))))
 '(show-paren-mismatch ((((class color)) (:background "#e08090" :foreground "white"))))
 '(speedbar-directory-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "blue4"))))
 '(speedbar-file-face ((((class color) (background light)) (:foreground "#083308" :height 1.4 :family "Helvetica"))))
 '(speedbar-highlight-face ((((class color) (background light)) (:background "#aaffaa"))))
 '(speedbar-selected-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "#992222" :underline t :weight bold))))
 '(speedbar-separator-face ((((class color) (background light)) (:inherit speedbar-file-face :background "#ddddff" :foreground "#222222" :overline "gray" :slant italic :height 0.85))))
 '(speedbar-tag-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "brown"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "cornsilk2"))))
 '(vhdl-speedbar-architecture-face ((((min-colors 88) (class color) (background light)) (:inherit speedbar-file-face :foreground "#000088"))))
 '(vhdl-speedbar-architecture-selected-face ((((min-colors 88) (class color) (background light)) (:inherit speedbar-file-face :foreground "#002277" :underline t))))
 '(vhdl-speedbar-configuration-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "#995500"))))
 '(vhdl-speedbar-configuration-selected-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "#995500" :underline t))))
 '(vhdl-speedbar-entity-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "ForestGreen"))))
 '(vhdl-speedbar-entity-selected-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "ForestGreen" :underline t))))
 '(vhdl-speedbar-instantiation-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "Brown"))))
 '(vhdl-speedbar-instantiation-selected-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "Brown" :underline t))))
 '(vhdl-speedbar-library-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "#660088"))))
 '(vhdl-speedbar-package-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "#222222"))))
 '(vhdl-speedbar-package-selected-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "Grey50" :underline t))))
 '(vhdl-speedbar-subprogram-face ((((class color) (background light)) (:inherit speedbar-file-face :foreground "Orchid4")))))

;; time display is last because during .emacs debugging if .emacs file is OK
;; then time will display, otherwise I know that entire .emacs file was not read
;; Display time in the mode line
(display-time)
