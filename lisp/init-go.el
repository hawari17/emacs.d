(when (maybe-require-package 'go-mode)
  (require-package 'company-go)
  (require-package 'go-eldoc)
  (require-package 'go-projectile)
  (require-package 'gotest)

  (require 'go-projectile)

  ;; Ignore go test -c output files
  (add-to-list 'completion-ignored-extensions ".test")

  (define-key 'help-command (kbd "G") 'godoc)

  (after-load 'go-mode
    (let ((map go-mode-map))
      (define-key map (kbd "C-c a") 'go-test-current-project) ;; current package, really
      (define-key map (kbd "C-c m") 'go-test-current-file)
      (define-key map (kbd "C-c .") 'go-test-current-test)
      (define-key map (kbd "C-c b") 'go-run)
      (define-key map (kbd "C-h f") 'godoc-at-point))

    ;; go fmt on save
    (add-hook `before-save-hook `gofmt-before-save nil t)

    ;; stop whitespace being highlighted
    (whitespace-toggle-options '(tabs))

    ;; Company mode settings
    (set (make-local-variable 'company-backends) '(company-go))

    ;; El-doc for go
    (go-eldoc-setup)

    ;; CamelCase aware editing operations
    (subword-mode +1)))

(provide 'init-go)
