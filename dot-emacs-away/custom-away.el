lsp-docker
'(safe-local-variable-values
   '((eval lexical-let
           ((project-directory
             (car
              (dir-locals-find-file default-directory))))
           (set
            (make-local-variable 'flycheck-javascript-eslint-executable)
            (concat project-directory ".yarn/sdks/eslint/bin/eslint.js"))
           (eval-after-load 'lsp-javascript
             '(progn
                (plist-put lsp-deps-providers :local
                           (list :path
                                 (lambda
                                   (path)
                                   (concat project-directory ".yarn/sdks/" path))))
                (lsp-dependency 'typescript-language-server
                                '(:local "typescript-language-server/lib/cli.js"))
                (lsp-dependency 'typescript
                                '(:local "typescript/bin/tsserver")))))
     (lsp-enabled-clients ts-ls eslint)
     (whitespace-line-column . 80)
     (lexical-binding . t)))
 '(tide-completion-detailed t)
 '(tide-completion-ignore-case t)
