(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 列数を表示する
(column-number-mode t)

;; 行数を表示する
(global-linum-mode t)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; カーソル行をハイライトする
(global-hl-line-mode t)

;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;;; dired設定
(require 'dired-x)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)


(el-get-bundle helm)
(el-get-bundle recentf-ext)

;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 500)
;; 最近使ったファイルに加えないファイルを
;; 正規表現で指定する
(setq recentf-exclude
      '("/TAGS$" "/var/tmp/"))
;; recentfをディレクトリにも拡張した上に、
;; 「最近開いたファイル」を「最近使ったファイル」に進化させる
(require 'recentf-ext)
(setq helm-for-files-preferred-list
      '(helm-source-buffers-list
        helm-source-recentf
        helm-source-bookmarks
        helm-source-file-cache
        helm-source-files-in-current-dir
        ;; 必要とあれば
        helm-source-bookmark-set
        helm-source-locate))

;;; (require 'helm-config)
;;; (helm-mode 1)
(define-key global-map (kbd "C-x C-r") 'helm-for-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
;;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
;;; (define-key global-map (kbd "C-x C-r") 'helm-recentf)
;;; (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
;;; (define-key global-map (kbd "C-c i")   'helm-imenu)
;;; (define-key global-map (kbd "C-x b")   'helm-buffers-list)
;;; (define-key global-map (kbd "M-r")     'helm-resume)
;;; (define-key global-map (kbd "C-M-h")   'helm-apropos)
;;; (define-key helm-map (kbd "C-h") 'delete-backward-char)
;;; (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
;;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

;;; migemo
(el-get-bundle migemo)
(when (locate-library "migemo")
  (setq migemo-command "/usr/bin/cmigemo") ; HERE cmigemoバイナリ
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict") ; HERE Migemo辞書
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))

;;; magit
(el-get-bundle magit)

;;; projectile-rails
(el-get-bundle projectile-rails)
;;; (require 'projectile)
(projectile-global-mode)
;;; (require 'projectile-rails)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;;; eshell
;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

(setq eshell-prompt-function
      (lambda ()
        (concat "[yoshio"
                (eshell/pwd)
                (if (= (user-uid) 0) "]\n# " "]\n$ "))))
