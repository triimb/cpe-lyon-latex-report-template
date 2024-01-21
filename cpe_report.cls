\PassOptionsToPackage{dvipsnames}{xcolor}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cpe_report}[2024/01/01 - Tristan Imbert - CPE Lyon]
\LoadClass[a4paper]{book}

\RequirePackage{pgfcore}
\RequirePackage{geometry} 
\RequirePackage{bookmark}
\RequirePackage{graphicx}
\RequirePackage{setspace}
\RequirePackage{kantlipsum}
\RequirePackage{fontspec}
\RequirePackage{ragged2e}
\RequirePackage{cellspace, tabularx, booktabs}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}

\newboolean{set_duration}
\newboolean{set_major}
\newboolean{set_address}

\newboolean{abstract}
\newboolean{list_of_tables}
\newboolean{mini_list_of_tables}
\newboolean{list_of_figures}
\newboolean{acknowledgement}
\newboolean{big_chapter_style}
\newboolean{acronyms}
\newboolean{edge_labels}

% New length
\newlength{\logowidth}    \setlength{\logowidth}{70mm}
\newlength{\logopad}      \setlength{\logopad}{17.5mm}
\newlength{\marginleft}   \setlength{\marginleft}{3cm}   % Minimum margins are 2cm
\newlength{\marginright}  \setlength{\marginright}{3cm} 
\newlength{\margintop}    \setlength{\margintop}{3cm}
\newlength{\marginbottom} \setlength{\marginbottom}{3cm}  
\newlength{\marginhead}   \setlength{\marginhead}{1cm}
\newlength{\marginfoot}   \setlength{\marginfoot}{0.8cm}
\geometry{a4paper, top=\margintop, left=\marginleft, right=\marginright, bottom=\marginbottom, headsep=\marginhead, footskip=\marginfoot, nomarginpar}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

\makeatletter
\def\input@path{{chapters/}}
\makeatother

\RequirePackage[printonlyused]{acronym}
\RequirePackage{minitoc}
\RequirePackage{polyglossia}


% Setup Macros
\makeatletter
\def\langage#1{\gdef\@langage{#1}}
\def\maintitle#1{\gdef\@maintitle{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\schoolyear#1{\gdef\@schoolyear{#1}}
\def\duration#1#2{\gdef\@start_date{#1}\gdef\@end_date{#2}}
\def\major#1{\gdef\@major{#1}}
\def\address#1{\gdef\@address{#1}}

\def\maketitle{
\ifthenelse{\equal{\@langage}{fr}}
{
    \setdefaultlanguage{french}
    \newcommand{\fromVar}{Du}
    \newcommand{\toVar}{au}
    \newcommand{\authorVar}{Rédigé par}
    \newcommand{\supervisedVar}{Encadré par}
    \newcommand{\doatVar}{Fait à}
}{
    \setdefaultlanguage{english}
    \newcommand{\fromVar}{From}
    \newcommand{\toVar}{to}
    \newcommand{\authorVar}{Written by}
    \newcommand{\supervisedVar}{Supervised by}
    \newcommand{\doatVar}{Written at}
}

  \begin{titlepage}
    \hypertarget{TitlePage}{}
    \bookmark[dest=TitlePage,level=-1]{Front matter}
	\phantomsection \pdfbookmark[section]{Title page}{title}
    \pgfdeclareimage[width=\logowidth]{cpe-lyon-logo}{cpe-lyon-logo}
    \pgftext[at=\pgfpoint{-\marginleft+\logopad}{\margintop+\parskip-\logopad}, top, left]{\pgfuseimage{cpe-lyon-logo}}

    \begin{center}
	  \vspace*{\fill}
    \vskip 2cm
      \line(1,0){440}
      \vskip 0.5mm
      \openup 1em
      {\huge  \textsc\@maintitle} 
      \line(1,0){440}\\
      \vskip 1cm
      {\Large \textsc \@subtitle}
      \vskip 1cm
      \authorVar\\[2mm]
      {\large \textsc \@author}\\[1mm]
      \vskip 1cm
      \supervisedVar\\[2mm]
      {\large \textsc \@supervisor}\\[1mm]
      \vskip 1.0cm \
      \ifthenelse{\boolean{set_duration}}{
        \large \textit {\fromVar~\@start_date \toVar~\@end_date}\
      }{}
      \vskip 1.0cm
      \Large \textsc {
        \@schoolyear  
        \ifthenelse{\boolean{set_major}}{
        - \@major
        }{}
         - CPE Lyon
      }
      
      \vspace*{\fill}
      \RaggedLeft
      %\normalsize \textit{ \doatVar \@address}
      \ifthenelse{\boolean{set_address}}{
        \normalsize \textit{ \doatVar \@address}
      }{}
    \end{center}
  \end{titlepage}
  
  \pagenumbering{arabic}
  \setcounter{page}{2} % ensure no number on title page, numbers on other pages match those in the PDF
}
\makeatother

\RequirePackage{silence}
\WarningsOff[everypage]
\RequirePackage[contents={},opacity=1,scale=1,color=black]{background}
\WarningsOn[everypage]

\RequirePackage{xpatch}
\makeatletter
\xpatchcmd{\chapter}{\thispagestyle{plain}}
                    {\thispagestyle{empty}\stepcounter{counter}}
                    {}{}
\makeatother

\RequirePackage{tikzpagenodes}
\RequirePackage{totcount}

\regtotcounter{counter}
\newcounter{counter}

\usetikzlibrary{calc}
\usetikzlibrary{shapes.symbols} 
\usetikzlibrary{shapes.misc} 

\RequirePackage{fancyhdr}

\definecolor{MainColor}{RGB}{6,146,206}

\setlength{\headheight}{21pt}
\fancypagestyle{fancy}{
\fancyhead{}
\fancyfoot{}
\fancyhead[RE]{\color{MainColor}\leftmark}
\fancyhead[LE]{\color{MainColor}\thepage}
\fancyhead[RO]{\color{MainColor}\thepage}
\fancyhead[LO]{\color{MainColor}\rightmark}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{MainColor}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[LE]{\color{MainColor}\thepage}
  \fancyhead[RO]{\color{MainColor}\thepage}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{MainColor}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrulewidth}{0pt}
  \Materialfalse
  \afterpage{\Materialtrue}%
}
\fancypagestyle{empty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0.0pt}%
  \Materialfalse
  \afterpage{\Materialtrue}%
}

\newif\ifMaterial
\newlength\LabelSize
\setlength\LabelSize{1.5cm}

\AtBeginDocument{%
  \setlength\LabelSize{\dimexpr\textheight/\totvalue{counter}\relax}%
  \ifdim\LabelSize>1.5cm\relax
  \global\setlength\LabelSize{1.5cm}%
  \fi

  \RequirePackage{titlesec}
  \ifthenelse{\boolean{big_chapter_style}}{
  \titleformat{\chapter}[display]
   {\normalfont\fontsize{60}{62}\raggedleft\bfseries\color{MainColor}}{\ \thechapter}{-40pt}{\Huge\raggedleft\color{MainColor}}
  \titlespacing*{\chapter}{0pt}{-70pt}{20pt}
  }{
  \titleformat{\chapter}[hang]
    {\normalfont\fontsize{40}{42}\raggedleft\bfseries\color{MainColor}}{\thechapter}{20pt}{\Huge\color{MainColor}}
    \titlespacing*{\chapter}{0pt}{-70pt}{20pt}
  }

}
\makeatletter
\newcommand\AddLabels{%
  \Materialtrue
  \AddEverypageHook{%
    \ifMaterial
    \ifodd\value{page}%
    \backgroundsetup{
      angle=0,
      position={current page.east|-current page text area.north east},
      vshift=0pt-(\thecounter-2)*45pt,
      hshift=-15,
      contents={%
        \tikz\node[cho label] {\thechapter};
      }%
    }%
    \else
    \backgroundsetup{
      angle=0,
      position={current page.west|-current page text area.north west},
      vshift=0pt-(\thecounter-2)*45pt,
      hshift=15,
      contents={%
        \tikz\node[che label] {\thechapter};
      }%
    }%
    \fi
    \BgMaterial
    \else\relax\fi
  }%
}
\makeatother
\tikzset{
  che label/.style={fill,rounded rectangle, fill=MainColor,anchor=west,text width=\LabelSize, align=right,text height=30pt,text depth=15pt,text=white,font=\sffamily\fontsize{25pt}{0pt}\selectfont},
}
\tikzset{
  cho label/.style={fill,rounded rectangle, fill=MainColor,anchor=west,text width=\LabelSize, align=left,text height=30pt,text depth=15pt,text=white,font=\sffamily\fontsize{25pt}{0pt}\selectfont},
}

\newcommand\RemoveLabels{\Materialfalse}


\makeatletter
\def\preamble{
\ifthenelse{\equal{\@langage}{fr}}
{
    \newcommand{\listOfAcronyms}{Liste des Acronymes}
    \newcommand{\acknowledgments}{Remerciements}
    \renewcommand*\listfigurename{Liste des figures}
    \renewcommand*\contentsname{Table des matières}
}{
    \newcommand{\listOfAcronyms}{List of Acronyms}
    \newcommand{\acknowledgments}{Acknowledgments}
}


\let\cleardoublepage\clearpage % Do not change - Only if blank page is needed between parts

\dominitoc % Do not change - required
\maketitle % Do not change - required

\pagestyle{empty} % Do not change - required
\frontmatter % Do not change - required
\doublespacing % Do not change - required

\pagestyle{plain} % Do not change - required

\ifthenelse{\boolean{abstract}}{
\phantomsection
\addcontentsline{toc}{chapter}{Abstract}\mtcaddchapter 
\chapter*{Abstract}
\addtocounter{counter}{-1}
\input{Abstract.tex} % Do not remove
}{}

\ifthenelse{\boolean{acknowledgement}}{
\phantomsection
\addcontentsline{toc}{chapter}{\acknowledgments}\mtcaddchapter 
\chapter*{\acknowledgments}
\addtocounter{counter}{-1}
\input{Acknowledgement.tex} % OPTIONAL CAN BE REMOVED
}{}

\ifthenelse{\boolean{acronyms}}{
\phantomsection
\addcontentsline{toc}{chapter}{\listOfAcronyms}\mtcaddchapter 
\chapter*{\listOfAcronyms}
\addtocounter{counter}{-1}
\input{chapters/ListAcronyms.tex} % OPTIONAL CAN BE REMOVED
}{}

\ifthenelse{\boolean{list_of_figures}}{
\phantomsection
\addcontentsline{toc}{chapter}{\listfigurename}\mtcaddchapter
\listoffigures % Optional
\addtocounter{counter}{-1}
}{}

\ifthenelse{\boolean{list_of_tables}}{
\phantomsection
\addcontentsline{toc}{chapter}
{\listtablename}\mtcaddchapter
\singlespacing % Do not change - required
\tableofcontents % Do not change - required
\addtocounter{counter}{-1}
}{} % OPTIONAL CAN BE ADDED

\doublespacing % Do not change - required

\mainmatter % Do not change - required
\bookmarksetup{startatroot}
\pagestyle{fancy} % Do not change - required
\ifthenelse{\boolean{edge_labels}}{
\AddLabels % Do not change - required
}{}
}
\makeatother


\def\conclusions{
\RemoveLabels % Do not change - required
\phantomsection
\addcontentsline{toc}{chapter}{Conclusion}\mtcaddchapter 
\chapter*{Conclusion}
\markboth{{CONCLUSIONS}}{CONCLUSIONS}
\addtocounter{counter}{-1}
% Edit the content of these files 
\input{Conclusions} % Do not remove
\ifthenelse{\boolean{edge_labels}}{
\AddLabels % Do not change - required
}{}
}