% \divine{}
% Vladimír Štill
% 5. října 2015

---
subtitle: Tree Compression (SEFM 2015),\newline
    Weak-Memory as LLVM-2-LLVM (MEMICS 2015)
header-includes:
    - \usepackage{divine}
lang: czech
...


## Cíle přednášky

1.  představení \divine
2.  stromová komprese (SEFM 2015)
3.  weak memory jako \llvm{} $\rightarrow$ \llvm{} transformace\newline (MEMICS 2015)
4.  pohled do budoucnosti

# Představení DIVINE

## DIVINE

\divine{} je

*   explicitní model checker pro programy bez vstupů

*   schopný verifikovat mnoho formátů
    *   C/C++ (pomocí \llvm), DVE, Uppaal časové automaty,…

*   s podporou safety a \ltl{} vlastností

*   používá paralelní a distribuované algoritmy pro verifikaci

. . .

*   poslední vývoj především v oblasti verifikace C/C++

## Relaxované paměťové modely: příklad {.fragile}

\begin{latex}
\begin{lstlisting}[belowskip=0pt]
int x = 0, y = 0;
\end{lstlisting}

\begin{minipage}[t]{0.45\textwidth}
\begin{lstlisting}[numbers=left,aboveskip=0pt]
void thread0() {
    y = 1;
    cout << "x = " << x;
  }
\end{lstlisting}
\end{minipage}%
\hfill%
\begin{minipage}[t]{0.45\textwidth}
\begin{lstlisting}[numbers=left,aboveskip=0pt]
void thread1() {
    x = 1;
    cout << "y = " << y;
}
\end{lstlisting}
\end{minipage}
\end{latex}

TSO lze simulovat pomocí store bufferů:

\begin{tikzpicture}[ ->, >=stealth', shorten >=1pt, auto, node distance=3cm
                   , semithick
                   , scale=0.65
                   ]
  \draw [-] (-10,0) -- (-6,0) -- (-6,-2) -- (-10,-2) -- (-10,0);
  \draw [-] (-10,-1) -- (-6,-1);
  \draw [-] (-8,0) -- (-8,-2);
  \node () [anchor=west] at (-10,0.5) {main memory};
  \node () [anchor=west] at (-10,-0.5)  {\texttt{0x04}};
  \node () [anchor=west] at (-8,-0.5)  {\texttt{0x08}};
  \node () [anchor=west] at (-10,-1.5)  {\texttt{x = 0}};
  \node () [anchor=west] at (-8,-1.5)  {\texttt{y = 0}};

  \node () [anchor=west] at (-10,-3.5) {store buffer for thread 0};
  \node () [anchor=west] at (0,-3.5) {store buffer for thread 1};

  \draw [-] (-10,-4) -- (-4, -4) -- (-4,-5) -- (-10,-5) -- (-10,-4);
  \draw [-] (0,-4) -- (6, -4) -- (6,-5) -- (0,-5) -- (0,-4);
  \draw [-] (-8,-4) -- (-8,-5);
  \draw [-] (-6,-4) -- (-6,-5);
  \draw [-] (2,-4) -- (2,-5);
  \draw [-] (4,-4) -- (4,-5);

  \node<2-> () [anchor=west] at (-10,-4.5)  {\texttt{0x08}};
  \node<2-> () [anchor=west] at (-8,-4.5)  {\texttt{1}};
  \node<2-> () [anchor=west] at (-6,-4.5)  {\texttt{32}};

  \node<4-> () [anchor=west] at (0,-4.5)  {\texttt{0x04}};
  \node<4-> () [anchor=west] at (2,-4.5)  {\texttt{1}};
  \node<4-> () [anchor=west] at (4,-4.5)  {\texttt{32}};

  \node () [] at (-4, 0.5) {thread 0};
  \draw [->] (-4,0) -- (-4,-2);
  \node () [anchor=west, onslide={<2> font=\bf, color=red}] at (-3.5, -0.5) {\texttt{store y 1;}};
  \node () [anchor=west, onslide={<3> font=\bf, color=red}] at (-3.5, -1.5) {\texttt{load x;}};

  \node () [] at (2, 0.5) {thread 1};
  \draw [->] (2,0) -- (2,-2);
  \node () [anchor=west, onslide={<4> font=\bf, color=red}] at (2.5, -0.5) {\texttt{store x 1;}};
  \node () [anchor=west, onslide={<5> font=\bf, color=red}] at (2.5, -1.5) {\texttt{load y;}};

  \draw<2-> [->, dashed] (-0.5,-0.5) to[in=0, out=0] (-4,-4.5);
  \draw<3-> [->, dashed] (-9,-2) to[in=0, out=-90, out looseness=0.7] (-1.3,-1.5);
  \draw<4-> [->, dashed] (5.5,-0.5) to[in=0, out=0] (6,-4.5);
  \draw<5-> [->, dashed] (-7,-2) to[in=0, out=-90, out looseness=0.5] (4.7,-1.5);

\end{tikzpicture}
