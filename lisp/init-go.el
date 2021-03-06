(when (maybe-require-package 'go-mode)
  (require-package 'company-go)
  (require-package 'go-eldoc)
  (require-package 'go-projectile)
  (require-package 'gotest)
  (require-package 'go-autocomplete)

  (require 'go-projectile)

  ;; Ignore go test -c output files
  (add-to-list 'completion-ignored-extensions ".test")

  (define-key 'help-command (kbd "G") 'godoc)

  (after-load 'go-mode
    (defun init-go-mode-defaults ()
      ;; Add to default go-mode key bindings
      (let ((map go-mode-map))
        (define-key map (kbd "C-c a") 'go-test-current-project) ;; current package, really
        (define-key map (kbd "C-c m") 'go-test-current-file)
        (define-key map (kbd "C-c .") 'go-test-current-test)
        (define-key map (kbd "C-c b") 'go-run)
        (define-key map (kbd "C-h f") 'godoc-at-point))

      ;; Prefer goimports to gofmt if installed
      (let ((goimports (executable-find "goimports")))
        (when goimports
          (setq gofmt-command goimports)))

      ;; go fmt on save
      (add-hook `before-save-hook `gofmt-before-save nil t)

      ;; stop whitespace being highlighted
      ;; (whitespace-toggle-options '(tabs spaces))

      ;; Company mode settings
      (set (make-local-variable 'company-backends) '(company-go))

      ;; El-doc for go
      (go-eldoc-setup)

      ;; CamelCase aware editing operations
      (subword-mode +1))

    (setq custom-go-mode-hook 'init-go-mode-defaults)

    (add-hook 'go-mode-hook (lambda ()
                              (run-hooks 'custom-go-mode-hook)))

    (add-hook 'go-mode-hook 'sanityinc/no-trailing-whitespace)))

(provide 'init-go)
