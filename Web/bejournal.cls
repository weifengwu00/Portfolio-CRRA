%%% LaTeX class for manuscripts submitted to the
%%% Berkeley Electronic Journals (BEPress)
%%%
%%% author: Christopher Carroll
%%% license: LaTeX Project Public License 
%%%
%%% Modified from style itaxpf by Arne Henningsen
%%% version: 1.0 (09 July 2007)
%%% license: LaTeX Project Public License 
%%%
%%% Note: This is an unofficial style file that may not fully comply
%%% with the Formatting Instructions of the BEPress Journals
%%% in every detail.
%%% Further information is available at
%%% http://www.uni-kiel.de/agrarpol/ahenningsen/latex-bibtex.html
%%%
%%% This document class is based on the "scrartcl" class
%%% from the KOMA script bundle.  For documentation, Google KOMA-Script Documentation
%%%
%%% The corresponding BibTeX style file "bejournal.bst" should be used
%%% for the bibliography: \bibliographystyle{bejournal}
%%%
%%% This class provides 2 options:
%%% titlepage = include a title page (with command "\maketitle")
%%% noendfloat = do not move "floats" (tables and figures) to the end
%%%
%%% This document class provides several new commands:
%%% If the titlepage option is invoked:
%%%     \keywords can be used to show keywords below the abstract
%%%     \jelclass can be used to show JEL classifications below the abstract
%%%     \authorAmark to \authorEmark produce a distinguishing footnote mark next to each author's name
%%%     \authorAinfo to \authorEinfo produce detailed contact info for the given author at the bottom of the page (if you have more than 5 authors, you will have to customize this class!)
%%%     \thanks{text of the thank-you footnote} produces a footnote at the bottom of the page containing the text

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bejournal}[2009/07/22 LaTeX class for the Berkeley Electronic Journals, version 1.3]

\RequirePackage{ifthen}

% If unspecified whether pdf output (instead of dvi) is being used, determine that it SHOULD be
\newif\ifdvi\dvitrue
\@ifundefined{pdfoutput}{}{\ifnum\pdfoutput>0 \dvifalse\fi}

% permit double spacing
\RequirePackage{setspace}
%\doublespacing

% option to include a title page
\newcounter{IncludeTitlePage}
\setcounter{IncludeTitlePage}{0}
\DeclareOption{titlepage}{\setcounter{IncludeTitlePage}{1}}

% pass any options on to the scrartcl class and load this class with some options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[fontsize=12pt,english,numbers=noenddot,captions=tableheading,captions=nooneline]{scrartcl}
% pointlessnumbers = do not add final dot after ordinary section numbers
% tablecaptionabove = use \captionabove for captions above rather than below tables
% noonelinecaption = do not treat one-line captions differently

% use new TeX encoding scheme (T1), which contains accented (European) letters,
% to make European hyphenations work
\RequirePackage[T1]{fontenc}

%\RequirePackage{beamerarticle} % Defines theorem and related environments

% use babel package and set language to english
\RequirePackage[english]{babel}

% spacing around formulas
\AtBeginDocument{
\setlength{\abovedisplayshortskip}{6pt}
\setlength{\belowdisplayshortskip}{6pt}
\setlength{\abovedisplayskip}{6pt}
\setlength{\belowdisplayskip}{6pt}
\allowdisplaybreaks
}

% Don't indent the second and later lines of footnotes
\deffootnote[1em]{0.0em}{1em}{\textsuperscript{\thefootnotemark}}

% spacing around captions and floats
\setlength{\abovecaptionskip}{6pt}
\setlength{\belowcaptionskip}{3pt}
\setlength{\floatsep}{0pt}
\setlength{\textfloatsep}{20pt}
\setlength{\intextsep}{15pt}


\RequirePackage{calc}

\newenvironment{Description}
{\begin{list}{}{\let\makelabel\Descriptionlabel
    \setlength\labelwidth{75pt}
    \setlength\labelsep{0pt}
    \setlength\leftmargin{75pt}
    \setlength\itemindent{0pt}
}}
{\end{list}}
\newcommand*\Descriptionlabel[1]{\textbf{#1}\hfil}


\RequirePackage{cancel,verbatim,
amsmath,amssymb,amsfonts,amsthm
,threeparttable,dcolumn,multicol,multirow,booktabs % table environment extensions
,latexsym
,afterpage
,endnotes
,moreverb
,hhline    % Allow double hlines
,tipa      % Define more characters, in particular the \textthorn character
,color
}

\RequirePackage{bejournal}
\RequirePackage[mathscr]{eucal}
\RequirePackage[normalem]{ulem}
\providecommand\bmmax{0} % Prevent boldmath package from using up too much memory
\RequirePackage{bm}      % Allow bold math
\RequirePackage{bbm}     % Blackbord math

% font for URLs
\RequirePackage{url}
\def\UrlFont{\ttfamily}

\usepackage[BE]{optional} % Enable the control of compilation using options passed on startup
\opt{EndFloats}{\RequirePackage[noheads,nolists,tablesfirst,nomarkers]{endfloat}}

% page format, margins
\opt{PrintGeom}{
\RequirePackage{geometry}
\geometry{letterpaper, tmargin=1.4in, bmargin=1.4in, lmargin=1.4in,
  rmargin=1.4in, headheight=0in, headsep=0in, footskip=0.5in }
}

\providecommand{\textSizeDefault}{\normalsize}
\opt{bigWide}{\renewcommand{\textSizeDefault}{\large}}

\providecommand{\abstractSizeDefault}{\small}
\opt{bigWide}{\renewcommand{\abstractSizeDefault}{\normalsize}}

%% formatting section headers
\setkomafont{section}{\normalfont \Large \bfseries}
\setkomafont{subsection}{\normalfont \large}
\setkomafont{subsubsection}{\normalfont \itshape}

% citations and bibliography
\RequirePackage[authoryear]{natbib}
\AtBeginDocument{\renewcommand{\refname}{\clearpage References}
\renewcommand\@makefnmark
  {\mbox{\textsuperscript{\footnotesize\@thefnmark}}} % Restore the usual footnote defn after titlepage
\ifdvi
  \renewcommand{\ushort}{\underline} % ushort seems to not work properly for tex4ht (which compiles using dvi)
\fi
}

% captions of figures and tables
\setcapwidth[c]{\textwidth}
% \setcapindent*{0pt}
\setkomafont{captionlabel}{\centering \bfseries}
\setkomafont{caption}{\centering}
\renewcommand{\captionformat}{~ }

% titlepage with title, author(s), and date
\newcommand{\authorAmark}{\textsuperscript{\tiny 1}\footnoteB{}}
\newcommand{\authorBmark}{\textsuperscript{\tiny 2}\footnoteB{}}
\newcommand{\authorCmark}{\textsuperscript{\tiny 3}\footnoteB{}}
\newcommand{\authorDmark}{\textsuperscript{\tiny 4}\footnoteB{}}
\newcommand{\authorEmark}{\textsuperscript{\tiny 5}\footnoteB{}}

\newcommand{\authorAinfo}[1]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{1}}{#1}}}}
\newcommand{\authorBinfo}[1]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{2}}{#1}}}}
\newcommand{\authorCinfo}[1]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{3}}{#1}}}}
\newcommand{\authorDinfo}[1]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{4}}{#1}}}}
\newcommand{\authorEinfo}[1]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{5}}{#1}}}}

\newcommand{\authorsABinfo}[2]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{1}}{#1}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 2}}{#2}}}}
\newcommand{\authorsABCinfo}[3]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{1}}{#1}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 2}}{#2}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 3}}{#3}}}}
\newcommand{\authorsABCDinfo}[4]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{1}}{#1}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 2}}{#2}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 3}}{#3}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 4}}{#4}}}}
\newcommand{\authorsABCDEinfo}[5]{\footnoteB{\noindent{\makebox[0pt][r]{\textsuperscript{1}}{#1}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 2}}{#2}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 3}}{#3}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 4}}{#4}{~~~~}}{\makebox[0pt][r]{\textsuperscript{\tiny 5}}{#5}}}}

\renewcommand{\maketitle}{
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \let\footnotesize\scriptsize
      \thispagestyle{empty}
      \vspace*{0mm}
      \enlargethispage{0.6in} 
   }{}
   \begin{center}
   \begin{LARGE}
   \begin{spacing}{1.00}
   \textbf{\@title}
   \end{spacing}
   \end{LARGE}\medskip\medskip
   {\normalsize \@date \par}       
   {\tiny{~}\par}
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \vspace*{5mm}
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
   }{}
   \end{center}
}

\newcommand{\maketitleWithForcedDate}[1]{
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \let\footnotesize\scriptsize
      \thispagestyle{empty}
      \vspace*{0mm}
      \enlargethispage{0.6in} 
   }{}
   \begin{center}
   \begin{LARGE}
   \begin{spacing}{1.00}
   \textbf{\@title}
   \end{spacing}
   \end{LARGE}\medskip
   {\normalsize #1 \par}       
   {\tiny{~}\par}
   \ifthenelse{\equal{\theIncludeTitlePage}{1}}{
      \vspace*{5mm}
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
   }{}
   \end{center}
}


% abstract, keywords, JEL classification
\newcommand{\keywords}[1]{\newcommand{\@keywords}{#1}}
\newcommand{\jelclass}[1]{\newcommand{\@jelclass}{#1}}
\newcommand{\aspublished}[1]{\newcommand{\@aspublished}{#1}}

\renewenvironment{abstract}{%
   \begin{spacing}{0.9}
   \noindent {\tiny \phantom{.}} \\ % Trick to get proper spacing in html
   \noindent \hrule height 0.4pt depth 0.0pt width \textwidth \relax
   \vspace*{4mm}
   \abstractSizeDefault
   \noindent \textbf{Abstract}\\
   \indent 
}{%
   \noindent {\tiny \phantom{.}} \\  % Trick to get proper spacing in html
   \noindent \hrule height 0.4pt depth 0.0pt width \textwidth \relax
   \vspace*{3mm}
   \ifthenelse{ \isundefined\@keywords }{
   \ClassWarningNoLine{bejournal}{No keywords specified.
      Please use the command \protect\keywords}
   }{
   }
   \end{spacing}

\begin{quote}
\begin{Description}
\item[\textbf{Keywords~}] \@keywords
\ifthenelse{ \isundefined\@jelclass }{
\ClassWarningNoLine{bejournal}{No JEL classification specified.
   Please use the command \protect\jelclass}
}{
\item[\textbf{JEL codes~}] \@jelclass
}
\ifthenelse{ \isundefined\@aspublished }{
}{
{

\vspace{0.1in}\centerline{\it \@aspublished}}
}
\end{Description}
\end{quote}
}

\setcounter{footnote}{0}%

\medskip

% avoid clubs and widows
\clubpenalty=1000  % penalty for breaking a page with only one sentence; set to 10000 to prohibit
\widowpenalty=10000
% \displaywidowpenalty=10000

\hbadness 3000  % LaTeX default is 1000, which is too finicky - set to 10000 to get rid of complaints

% increase stretchability of the spaces (avoid overfull hboxes)
\setlength{\emergencystretch}{3em}


\pagestyle{plain}
\thispagestyle{empty}

\newcommand{\titlepagefinish}{\newpage 
\renewcommand\@makefnmark
  {\mbox{\textsuperscript{\tiny\@thefnmark}}}
}


\RequirePackage[multiple]{footmisc}
\RequirePackage{manyfoot,perpage}
\DefineFNsymbols{blank}[text]{{} {} {} {} {}}
\setfnsymbol{blank}
\DeclareNewFootnote{B}[fnsymbol]
\MakePerPage{footnoteB}


\renewcommand{\thanks}{\footnoteB}

\hfuzz2pt % Don't bother to report over-full boxes if over-edge is < 2pt

