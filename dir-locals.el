;; copy to .dir-locals.el in the root of the project
((nil . ((latex-build-command . "make")
         (TeX-master . "p")
         (TeX-command-list .
                           (("LatexMk" "latexmk %(-PDF)%S%(mode) %(file-line-error) %(extraopts) %t" TeX-run-latexmk nil
                             (plain-tex-mode latex-mode doctex-mode)
                             :help "Run LatexMk")
                            ("TeX" "%(PDF)%(tex) %(file-line-error) %`%(extraopts) %S%(PDFout)%(mode)%' %(output-dir) %t" TeX-run-TeX nil
                             (plain-tex-mode ams-tex-mode texinfo-mode)
                             :help "Run plain TeX")
                            ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
                             (latex-mode doctex-mode)
                             :help "Run LaTeX")
                            ("Makeinfo" "makeinfo %(extraopts) %(o-dir) %t" TeX-run-compile nil
                             (texinfo-mode)
                             :help "Run Makeinfo with Info output")
                            ("Makeinfo HTML" "makeinfo %(extraopts) %(o-dir) --html %t" TeX-run-compile nil
                             (texinfo-mode)
                             :help "Run Makeinfo with HTML output")
                            ("AmSTeX" "amstex %(PDFout) %`%(extraopts) %S%(mode)%' %(output-dir) %t" TeX-run-TeX nil
                             (ams-tex-mode)
                             :help "Run AMSTeX")
                            ("ConTeXt" "%(cntxcom) --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
                             (context-mode)
                             :help "Run ConTeXt once")
                            ("ConTeXt Full" "%(cntxcom) %(extraopts) %(execopts)%t" TeX-run-TeX nil
                             (context-mode)
                             :help "Run ConTeXt until completion")
                            ("BibTeX" "bibtex %(O?aux)" TeX-run-BibTeX nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode context-mode)
                             :help "Run BibTeX")
                            ("Biber" "biber %s %(output-dir)" TeX-run-Biber nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Run Biber")
                            ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
                            ("Print" "%p" TeX-run-command t t :help "Print the file")
                            ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
                            ("File" "%(o?)dvips %d -o %f " TeX-run-dvips t
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Generate PostScript file")
                            ("Dvips" "%(o?)dvips %d -o %f " TeX-run-dvips nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Convert DVI file to PostScript")
                            ("Dvipdfmx" "dvipdfmx %d -o %(O?pdf)" TeX-run-dvipdfmx nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Convert DVI file to PDF with dvipdfmx")
                            ("Ps2pdf" "ps2pdf %f %(O?pdf)" TeX-run-ps2pdf nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Convert PostScript file to PDF")
                            ("Glossaries" "makeglossaries %(O?aux)" TeX-run-command nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Run makeglossaries to create glossary file")
                            ("Index" "makeindex %(O?idx)" TeX-run-index nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Run makeindex to create index file")
                            ("upMendex" "upmendex %(O?idx)" TeX-run-index t
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Run upmendex to create index file")
                            ("Xindy" "texindy %s" TeX-run-command nil
                             (plain-tex-mode latex-mode doctex-mode ams-tex-mode texinfo-mode)
                             :help "Run xindy to create index file")
                            ("Check" "lacheck %s" TeX-run-compile nil
                             (latex-mode)
                             :help "Check LaTeX file for correctness")
                            ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
                             (latex-mode)
                             :help "Check LaTeX file for common mistakes")
                            ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
                            ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
                            ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
                            ("Other" "" TeX-run-command t t :help "Run an arbitrary command")
                            ("make" "make" TeX-run-command t t :help "Run make")
                            ("make-artifact" "make artifact" TeX-run-command t t :help "Run maka artifact")
                            )))))
