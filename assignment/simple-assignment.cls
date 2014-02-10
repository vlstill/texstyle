% ib102.sty
% style for homeworks for IB102 Automata, Grammars, and Complexity
% (c) 2013 Vladimír Štill, CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
% (c) 2014 Vladimír Štill modifications for NTNU's TDT4205
% (c) 2014 Vladimír Štill generalized as general purpose template

\ProvidesClass{simple-assignment}[2013/06/29 v 0.1 IB102]
\NeedsTeXFormat{LaTeX2e}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions \relax
\LoadClass{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper, left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{fancyhdr}
\RequirePackage{ifthen}
\RequirePackage{IEEEtrantools}

\RequirePackage{pgf}
\RequirePackage{tikz}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}   %důkazy
\usetikzlibrary{calc,arrows,automata}

\newcommand{\eps}{\varepsilon}
\newcommand{\move}{\rightarrow}
\newcommand{\set}[1]{\ensuremath{\{ #1 \}}}

%% BASIC COMMANDS

\addtolength{\headheight}{1.2cm}
\addtolength{\textheight}{-1.2cm}
\addtolength{\headsep}{-0.4cm}

\def\@student{}
\newcommand{\setstudent}[1]{\def\@student{#1}}

\def\@assignment{0}
\newcommand{\setassignment}[1]{\def\@assignment{#1}}

\def\@course{}
\newcommand{\setcourse}[1]{\def\@course{#1}}

\def\@problemname{Problem set}
\newcommand{\setproblemname}[1]{\def\@problemname{#1}}

%% HEADER
\pagestyle{fancyplain}
\fancyhf{}

\lhead{\large
    \textbf{\@course{} -- \@problemname{} \@assignment{}
        \hfill \@student{}%
    }
}

%% DOCUMENT ENVIRONMENTS

\newcounter{ctProblem}
\newcommand{\prob}{\stepcounter{ctProblem}\thectProblem}

\newenvironment{problem}{%
    \subsection*{Problem \prob}
}{}

\newcounter{ctSubproblem}[ctProblem]
\newcommand{\subprob}{\stepcounter{ctSubproblem}\alph{ctSubproblem}}

\newenvironment{subproblem}{\bigskip\par\noindent%
    {}\subprob{})
}{}

\cfoot{\thepage}


