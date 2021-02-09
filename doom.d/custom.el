(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((grep-find-ignored-directories ".git" ".venv" "node_modules" ".mypy_cache" ".pytest_cache" "SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}")
     (grep-find-ignored-files "*.min.js" "*.standalone.js" "*.map" "*.gz" ".#*" "*.o" "*~" "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl" "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class" "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl" "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl" "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl" "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo" "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr" "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo")
     (eval add-to-list 'grep-find-ignored-directories ".pytest_cache")
     (eval add-to-list 'grep-find-ignored-directories ".mypy_cache")
     (eval add-to-list 'grep-find-ignored-directories "node_modules")
     (eval add-to-list 'grep-find-ignored-directories ".venv")
     (eval add-to-list 'grep-find-ignored-directories ".git")
     (eval add-to-list 'grep-find-ignored-files "*.gz")
     (eval add-to-list 'grep-find-ignored-files "*js.map")
     (eval add-to-list 'grep-find-ignored-files "*standalone.js")
     (eval add-to-list 'grep-find-ignored-files "*min.js")
     (py-indent-offset . 4)
     (encoding . utf-8)
     (eval setq flycheck-python-mypy-executable
           (concat
            (projectile-locate-dominating-file default-directory dir-locals-file)
            "tests/static/run_mypy"))
     (eval setq flycheck-sass/scss-sass-lint-executable
           (concat
            (projectile-locate-dominating-file default-directory dir-locals-file)
            "node_modules/.bin/sass-lint"))
     (eval eval-after-load "yapfify"
           '(defun yapfify-call-bin
                (input-buffer output-buffer start-line end-line)
              "Call process yapf on INPUT-BUFFER saving the output to OUTPUT-BUFFER.

Return the exit code.  START-LINE and END-LINE specify region to
format."
              (with-current-buffer input-buffer
                (call-process-region
                 (point-min)
                 (point-max)
                 (concat
                  (projectile-locate-dominating-file default-directory dir-locals-file)
                  "scripts/run-pipenv")
                 nil output-buffer nil "run" "yapf" "-l"
                 (concat
                  (number-to-string start-line)
                  "-"
                  (number-to-string end-line))))))
     (eval setq flycheck-python-pylint-executable
           (concat
            (projectile-locate-dominating-file default-directory dir-locals-file)
            "scripts/run-pylint"))
     (eval setq flycheck-python-mypy-executable
           (concat
            (projectile-locate-dominating-file default-directory dir-locals-file)
            "scripts/run-mypy")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
