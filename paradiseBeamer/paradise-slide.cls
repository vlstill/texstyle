% paradise-slide.sty
% (c) 2014 Vladimír Štill ParaDiSe slides

\ProvidesClass{paradise-slide}[2014/09/12 v 0.2 ParaDiSe]
\NeedsTeXFormat{LaTeX2e}

\newif\if@bw\@bwfalse
\DeclareOption{bw}{\@bwtrue}

\newif\if@nologo\@nologofalse
\DeclareOption{nologo}{\@nologotrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions \relax
\LoadClass{beamer}

\ifxetex
  \RequirePackage{fontspec,xltxtra,xunicode}
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
  \newcommand{\euro}{€}
\else
  \ifluatex
    \RequirePackage{fontspec}
    \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
    \newcommand{\euro}{€}
  \else
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \usepackage{eurosym}

    % this is hard decision, lmodern has weird ď and I'm not sure about other
    % czech letters, but computer modern lacks bold typewriter version, which is
    % needed for code typesetting. To make it worse lmodern lacks bold smallcaps,
    % but those are barely ever needed
    \RequirePackage{lmodern}
  \fi
\fi

\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\RequirePackage{IEEEtrantools}

\RequirePackage{listings}
\RequirePackage[oldenum,olditem]{paralist}
\RequirePackage{tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}

\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}   %důkazy
\RequirePackage{textcomp} % extra non-math fonts
\usetikzlibrary{calc,arrows,automata,positioning,shapes}

\tikzset{onslide/.code args={<#1>#2}{%
          \only<#1>{\pgfkeysalso{#2}} % \pgfkeysalso doesn't change the path
}}

\RequirePackage{listings}
\sbox0{\ttfamily A}
\edef\ttbasewidth{\the\wd0 }
\lstset{ keepspaces = true
       , columns = fixed
       , basicstyle = \ttfamily
       , belowskip = \medskipamount
       , aboveskip = \medskipamount
       , breaklines = true
       , basewidth = \ttbasewidth
       , showstringspaces = false
       , breakatwhitespace = true
       , literate =
            % UTF-8 european
            {á}{{\'a}}1 {é}{{\'e}}1 {í}{{\'i}}1 {ó}{{\'o}}1 {ú}{{\'u}}1
            {Á}{{\'A}}1 {É}{{\'E}}1 {Í}{{\'I}}1 {Ó}{{\'O}}1 {Ú}{{\'U}}1
            {à}{{\`a}}1 {è}{{\`e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
            {À}{{\`A}}1 {È}{{\'E}}1 {Ì}{{\`I}}1 {Ò}{{\`O}}1 {Ù}{{\`U}}1
            {ä}{{\"a}}1 {ë}{{\"e}}1 {ï}{{\"i}}1 {ö}{{\"o}}1 {ü}{{\"u}}1
            {Ä}{{\"A}}1 {Ë}{{\"E}}1 {Ï}{{\"I}}1 {Ö}{{\"O}}1 {Ü}{{\"U}}1
            {â}{{\^a}}1 {ê}{{\^e}}1 {î}{{\^i}}1 {ô}{{\^o}}1 {û}{{\^u}}1
            {Â}{{\^A}}1 {Ê}{{\^E}}1 {Î}{{\^I}}1 {Ô}{{\^O}}1 {Û}{{\^U}}1
            {œ}{{\oe}}1 {Œ}{{\OE}}1 {æ}{{\ae}}1 {Æ}{{\AE}}1 {ß}{{\ss}}1
            {ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1 {å}{{\r a}}1 {Å}{{\r A}}1
            {€}{{\EUR}}1 {£}{{\pounds}}1
            {č}{{\v{c}}}1 {ď}{{\v{d}}}1 {ň}{{\v{n}}}1 {ř}{{\v{r}}}1
            {š}{{\v{s}}}1 {ť}{{\v{t}}}1 {ž}{{\v{z}}}1 {ů}{{\r{u}}}1
            {Č}{{\v{C}}}1 {Ď}{{\v{D}}}1 {Ň}{{\v{N}}}1 {Ř}{{\v{R}}}1
            {Š}{{\v{S}}}1 {Ť}{{\v{T}}}1 {Ž}{{\v{Z}}}1 {Ů}{{\r{U}}}1
            {ě}{{\v{e}}}1 {Ě}{{\v{E}}}1 {ý}{{\'{y}}}1 {Ý}{{\'{Y}}}1
            % code literals
            {~>}{{$\leadsto$}}2 {~>*}{{$\leadsto^*$}}2
            {`}{{\textasciigrave}}1
}

\newcommand{\eps}{\varepsilon}
\newcommand{\move}{\rightarrow}
\newcommand{\set}[1]{\ensuremath{\{ #1 \}}}

% theme

\useinnertheme{rectangles}

\definecolor{fiyellow}{HTML}{F5DD35}
\definecolor{filight}{HTML}{F7F0BE}

\definecolor{paradisegreen}{HTML}{45A931} % {3FB050} % {45A931}

% on black and white save some ink/toner
\if@bw
    \definecolor{fiyellow}{HTML}{FFFFFF}
    \definecolor{filight}{HTML}{FFFFFF}
    \colorlet{paradisegreen}{black!20}
\fi

\setbeamercolor{alerted text}{fg=red} % ??
\setbeamercolor{background canvas}{bg=white}

\setbeamercolor{block body alerted}{use={block body}, bg=block body.bg}
\setbeamercolor{block body}{use={background canvas}, bg=background canvas.bg}
\setbeamercolor{block body example}{use={block body}, bg=block body.bg}

\setbeamercolor{block title alerted}{use={normal text},fg=title.fg, bg=structure.bg}
\setbeamercolor{block title}{use={normal text}, bg=structure.bg, fg=title.fg}
\setbeamercolor{block title example}{use={normal text},fg=title.fg, bg=structure.bg}

\setbeamercolor{fine separation line}{}
\setbeamercolor{item projected}{fg=white, bg=paradisegreen!85!black}
\setbeamercolor{normal text}{bg=white,fg=black}

\setbeamercolor{palette sidebar primary}{use=normal text,fg=normal text.fg}
\setbeamercolor{palette sidebar quaternary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar secondary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar tertiary}{use=normal text,fg=normal text.fg}
\setbeamercolor{section in sidebar}{fg=black}
\setbeamercolor{section in sidebar shaded}{fg=paradisegreen}
\setbeamercolor{separation line}{}
\setbeamercolor{sidebar}{bg=white}
\setbeamercolor{sidebar}{parent=palette primary}
\setbeamercolor{structure}{bg=paradisegreen!85!black, fg=paradisegreen!85!black}
\setbeamercolor{subsection in sidebar}{fg=black}
\setbeamercolor{subsection in sidebar shaded}{fg=paradisegreen}
\setbeamercolor{title}{fg=normal text.fg, bg=normal text.bg}
\setbeamercolor{titlelike}{fg=title.fg, bg=title.bg}

\setbeamercolor{author in foot}{fg=black, bg=paradisegreen}
\setbeamercolor{title in foot}{fg=black, bg=paradisegreen!80}
\setbeamercolor{date in foot}{fg=black, bg=paradisegreen}
\setbeamercolor{slide number in foot}{bg=normal text.bg, fg=black}

\setbeamercolor{frametitle}{bg=normal text.bg, fg=normal text.fg}
\setbeamercolor{framesubtitle}{bg=normal text.bg, fg=normal text.fg}

\setbeamerfont{institute}{size=\small}
\setbeamerfont{date}{size=\footnotesize}

\setbeamertemplate{footline}
{
\leavevmode%
\hbox{%
    \begin{beamercolorbox}[wd=\paperwidth,ht=2.25ex,dp=1ex%
                          , right, rightskip=1em]% align right
                          {slide number in foot}%
        \usebeamerfont{slide number in foot}\hfill
        \insertframenumber{} / \inserttotalframenumber
\end{beamercolorbox}}%
\vskip0pt%
}

\newlength\skip@length

\setbeamertemplate{frametitle}{%
    \nointerlineskip%
    \global\skip@length=1ex
    \usebeamerfont{frametitle}
    \begin{beamercolorbox}[wd=\paperwidth, dp=1ex, ht=2.5ex%
                          , leftskip=\skip@length, rightskip=\skip@length]%
                          {frametitle}
        \insertframetitle
        \if@nologo{}\else{\hfill\includegraphics[height=1em, trim={0 0 13em 0}, clip]{paradise.pdf}}\fi
    \end{beamercolorbox}%
    \par%
    \ifx\insertframesubtitle\empty%
    \else
        \nointerlineskip
        \begin{beamercolorbox}[ht=0.05em, wd=\paperwidth]{structure}%
        \end{beamercolorbox} %
        \vskip-0.1\skip@length
        \usebeamerfont{framesubtitle}
        \begin{beamercolorbox}[wd=\paperwidth, dp=1ex, ht=2.25ex%
                              , leftskip=\skip@length, rightskip=\skip@length]%
                              {framesubtitle}
            \textbf{\insertframesubtitle}
        \end{beamercolorbox}%
    \fi%
    \nointerlineskip
    \vspace*{-0.3ex}%
    \begin{beamercolorbox}[ht=0.1em, wd=\paperwidth]{structure}%
    \end{beamercolorbox} %
}

\def\block@begin#1{
    \vspace{0.5ex}%
    {\usebeamerfont*{block #1 title}
    \begin{beamercolorbox}[colsep*=.75ex, ht=-1.2ex]{block title}%
    \end{beamercolorbox}
        \vspace{0.25ex}\insertblocktitle\\[-2.3ex]
    \begin{beamercolorbox}[colsep*=.75ex, ht=-1.3ex]{block title}%
    \end{beamercolorbox}}%
    \usebeamerfont{block #1 body}%
    \begin{beamercolorbox}{block #1 body}%
    \vspace{-1ex}%
}

\setbeamertemplate{block begin}{\block@begin{}}
\setbeamertemplate{block example begin}{\block@begin{example}}
\setbeamertemplate{block alerted begin}{\block@begin{alerted}}

\def\block@end{
    \end{beamercolorbox}%
    \smallskip%
    \nointerlineskip%
    \begin{beamercolorbox}[colsep*=.75ex, ht=-1.2ex]{block title}%
    \end{beamercolorbox}
}
\newlength\block@rule@size
\setbeamertemplate{block end}{\block@end}
\setbeamertemplate{block example end}{\block@end}
\setbeamertemplate{block alerted end}{\block@end}

% copy of +- default title page
\setbeamertemplate{title page}{
    \vbox{}
    \vfill
    \begingroup
    \centering
    \begin{beamercolorbox}[sep=8pt,center]{title}
        \usebeamerfont{title}\inserttitle\par%
        \ifx\insertsubtitle\@empty%
        \else%
        \vskip0.25em%
        {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\insertsubtitle\par}%
        \fi%
    \end{beamercolorbox}%
    \nointerlineskip%
    \begin{beamercolorbox}[sep=8pt,center,ht=0.1em]{structure}%
    \end{beamercolorbox}%
    %
    \vskip1.5em\par
    \begin{beamercolorbox}[sep=8pt,center]{author}
        \usebeamerfont{author}\insertauthor
    \end{beamercolorbox}
    %
    \begin{beamercolorbox}[sep=8pt,center]{institute}
        \usebeamerfont{institute}\insertinstitute
    \end{beamercolorbox}
    \vskip.5em
    %
    \begin{beamercolorbox}[sep=8pt,center]{date}
        \usebeamerfont{date}\insertdate
    \end{beamercolorbox}\vskip0.5em
    %
    {\usebeamercolor[fg]{titlegraphic}\inserttitlegraphic\par}
    \endgroup
    \vfill
}

%remove navigation symbols
\setbeamertemplate{navigation symbols}{}

% fit PDF in viewer
\hypersetup{pdfstartview={Fit}}

% for markdown generators
\newenvironment{latex}{}{}

% defaults
\institute[ParaDiSe]{%
    \newlength\sc@em%
    {\scriptsize \global\sc@em=1em}%
    \if@nologo{%
       \\\vspace{.4\sc@em}%
       \textbf{ParaDiSe Laboratory}%
    }\else{%
        \includegraphics[height=4\sc@em]{paradise.pdf}%
    }\fi%
    \\\vspace{.4\sc@em}%
    % Faculty of Informatics%
    \iflanguage{czech}{Masarykova univerzita}{Masaryk University}%
    \\\vspace{.4\sc@em}%
    Brno, \iflanguage{czech}{Česká republika}{Czech Republic}%
}
