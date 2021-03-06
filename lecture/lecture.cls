% slidy.sty
% (c) 2014 Vladimír Štill template for PB173 slides
% (c) 2016–2020 Vladimír Štill generic slides for FI MU

\ProvidesClass{slides}[2020/05/17 v 0.3.1 slides]
\NeedsTeXFormat{LaTeX2e}

\newif\if@bw\@bwfalse
\DeclareOption{bw}{\@bwtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions \relax
\LoadClass{beamer}

\ifxetex
  \RequirePackage{fontspec,xltxtra,xunicode}
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
  \newcommand{\euro}{€}
  \setmainfont{Latin Modern Roman}
\else
  \ifluatex
    \RequirePackage{fontspec}
    \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
    \newcommand{\euro}{€}
    \setmainfont{Latin Modern Roman}
  \else
    \RequirePackage{etex}
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

\RequirePackage[shortlabels]{enumitem}
\newlist{compactitem}{itemize}{4}
\setlist[compactitem]{nosep}
\setlist[compactitem,1]{label=\textbullet}
\setlist[compactitem,2]{label={\normalfont\bfseries \textendash}}
\setlist[compactitem,3]{label=\textasteriskcentered}
\setlist[compactitem,4]{label=\textperiodcentered}
\newlist{compactenum}{enumerate}{3}
\setlist[compactenum]{nosep}
\setlist[compactenum,1]{a)} \setlist[enumerate,1]{a)}
\setlist[compactenum,2]{i.} \setlist[enumerate,2]{i.}
\setlist[compactenum,3]{1.} \setlist[enumerate,3]{1.}

\RequirePackage{tabularx}
\newcolumntype{C}{>{\centering\arraybackslash}X}

\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{tikz-qtree}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}   %důkazy
\RequirePackage{textcomp} % extra non-math fonts
\usetikzlibrary{calc,arrows,automata,positioning,shapes}

\let\compactitem\itemize
\let\endcompactitem\enditemize

\tikzset{onslide/.code args={<#1>#2}{%
          \only<#1>{\pgfkeysalso{#2}} % \pgfkeysalso doesn't change the path
}}

\RequirePackage{textcomp}
\RequirePackage[space=true]{accsupp}
\newcommand{\lecture@pdfactualhex}[3]{%
\newcommand{#1}{\BeginAccSupp{method=hex,ActualText=#2}#3\EndAccSupp{}}}
\lecture@pdfactualhex{\lecture@space}{2020}{\ \ }
\lecture@pdfactualhex{\lecture@btick}{60}{\textasciigrave}

\RequirePackage{listings}
{\ttfamily
\sbox0{A}
\edef\ttbasewidth@{\the\wd0 }

\def\dim@convertto#1#2{\strip@pt\dimexpr #2*65536/\number\dimexpr 1#1}
\global\edef\ttbasewidth{\dim@convertto{em}{\ttbasewidth@}em}
}
\lstset{ language = C++
       , keepspaces = true
       , columns = fixed
       , basicstyle = \ttfamily
       , belowskip = \smallskipamount
       , aboveskip = \smallskipamount
       , breaklines = true
       , basewidth = \ttbasewidth
       , showstringspaces = false
       , breakatwhitespace = true
       , morekeywords={nullptr,decltype,static_assert,override,final,constexpr,noexcept}
       , upquote=true
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
            {===}{$\equiv$}1 {~}{{$\sim$}}1
            {~>}{{$\leadsto$}}2 {~>*}{{$\leadsto^*$}}2
            {`}{{\textasciigrave}}1
            {λ}{$\lambda$}1
            {`}{\lecture@btick}1 {\ \ }{\lecture@space}2
}

\newcommand{\eps}{\varepsilon}
\newcommand{\move}{\rightarrow}
\newcommand{\set}[1]{\ensuremath{\{ #1 \}}}

% for correct PDF metadata encoding
\hypersetup{pdfencoding=auto}

% theme

\useinnertheme{rectangles}

\definecolor{fiyellow}{HTML}{F5DD35}
\definecolor{filight}{HTML}{F7F0BE}

\definecolor{paradisegreen}{HTML}{45A931} % {3FB050} % {45A931}
% on black and white save some ink/toner
\if@bw
    \definecolor{fiyellow}{HTML}{FFFFFF}
    \definecolor{filight}{HTML}{FFFFFF}
\fi

\setbeamercolor{alerted text}{fg=red} % ??
\setbeamercolor{background canvas}{bg=white}

\setbeamercolor{block body alerted}{use={block body}, bg=block body.bg}
\setbeamercolor{block body}{use={background canvas}, bg=background canvas.bg}
\setbeamercolor{block body example}{use={block body}, bg=block body.bg}

\setbeamercolor{block title alerted}{use={normal text},fg=normal text.fg, bg=fiyellow}
\setbeamercolor{block title}{use={normal text}, bg=fiyellow, fg=normal text.fg}
\setbeamercolor{block title example}{use={normal text},fg=normal text.fg, bg=fiyellow}

\setbeamercolor{fine separation line}{}
\setbeamercolor{frametitle}{fg=black}
\setbeamercolor{item projected}{fg=black}
\setbeamercolor{normal text}{bg=white,fg=black}

\setbeamercolor{palette sidebar primary}{use=normal text,fg=normal text.fg}
\setbeamercolor{palette sidebar quaternary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar secondary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar tertiary}{use=normal text,fg=normal text.fg}
\setbeamercolor{section in sidebar}{fg=black}
\setbeamercolor{section in sidebar shaded}{fg=fiyellow}
\setbeamercolor{separation line}{}
\setbeamercolor{sidebar}{bg=white}
\setbeamercolor{sidebar}{parent=palette primary}
\setbeamercolor{structure}{bg=fiyellow, fg=fiyellow}
\setbeamercolor{subsection in sidebar}{fg=black}
\setbeamercolor{subsection in sidebar shaded}{fg=fiyellow}
\setbeamercolor{title}{fg=black}
\setbeamercolor{titlelike}{fg=black}

\setbeamercolor{description item}{bg=fiyellow, fg=black}

\setbeamercolor{author in head/foot}{fg=darkgray, bg=filight}
\setbeamercolor{date in head/foot}{fg=darkgray, bg=filight}
\setbeamercolor{title in head/foot}{fg=darkgray, bg=filight}

\def\@semester{PLEASE SET SEMESTER}
\newcommand{\semester}[1]{\def\@semester{#1}\date{#1}}


\setbeamertemplate{footline}
{
\leavevmode%
\hbox{%
%    \begin{beamercolorbox}[wd=.5\paperwidth,ht=2.25ex,dp=1ex]{author in head/foot}%
%        \usebeamerfont{author in head/foot}~\insertshortauthor~~\beamer@ifempty{\insertshortinstitute}{}{(\insertshortinstitute)}
%    \end{beamercolorbox}%
%
    \begin{beamercolorbox}[wd=.7\paperwidth,ht=2.25ex,dp=1ex]{title in head/foot}%
        \usebeamerfont{title in head/foot}~\ifx\insertsubtitle\empty\insertshorttitle\else\insertshortsubtitle: \insertshorttitle\fi
    \end{beamercolorbox}%
%
    \begin{beamercolorbox}[wd=.3\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
        \usebeamerfont{date in head/foot}\insertshortdate{}\hspace*{2em}
        \insertframenumber{} / \inserttotalframenumber\hspace*{2ex} 
\end{beamercolorbox}}%
\vskip0pt%
}

%remove navigation symbols
\setbeamertemplate{navigation symbols}{}

\def\block@end{
    \end{beamercolorbox}%
    \nointerlineskip%
    \block@rule@size=\textwidth%
    \addtolength\block@rule@size{1.5ex}%
    \vspace{0.25ex}%
    \hbox{\hspace*{-0.75ex}\textcolor{fiyellow}{\rule{\block@rule@size}{0.1em}}}%
}
\newlength\block@rule@size
\setbeamertemplate{block end}{\block@end}
\setbeamertemplate{block example end}{\block@end}
\setbeamertemplate{block alerted end}{\block@end}

\newenvironment{poznamka}[1][\@empty]{%
    \footnotesize{}\textit{\ifx#1\@empty Poznámka\else #1\fi}: %
}{}

% fit PDF in viewer
\hypersetup{pdfstartview={Fit}}

% for markdown generators
\newenvironment{latex}{}{}

% \subtitle[PB173]{PB173 Programování v C++11}
% \author[Štill, Weiser]{Vladimír Štill, Jiří Weiser}
\institute[FI MU]{\iflanguage{czech}{Fakulta Informatiky, Masarykova Univerzita}{Faculty of Informatics, Masaryk University}}
