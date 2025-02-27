$pdf_mode = 1;
$bibtex        = 'bibtex -min-crossrefs=99';

$ENV{'TEXINPUTS'}='./sty//:' . $ENV{'TEXINPUTS'};

# set_tex_cmds( '--shell-escape %O %S' ); # for minted version < 3 texlive < 2024
add_cus_dep( 'tex', 'aux', 0, 'makeexternaldocument' );

sub makeexternaldocument {
    if (!($root_filename eq $_[0]))
    {
        # FOR PDFLATEX
        system( "latexmk -cd -pdf \"$_[0]\"" );
        ## shell-escape for minted version < 3 texlive < 2024
        # system( "latexmk -cd -pdf -shell-escape \"$_[0]\"" );

        # FOR LATEX+DVIPDF
        # system( "latexmk -cd \"$_[0]\"" );

        # FOR XELATEX
        # system( "latexmk -cd -xelatex \"$_[0]\"" );

        # FOR LUALATEX
        # system( "latexmk -cd -lualatex \"$_[0]\"" );
   }
}
