%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NASA LaTeX Docs - LaTeX Templates and Build Script
% Author: Wahab Alshahin (NASA | Johnson Space Center)
% Software Release: This code is is governed by NPR 2210.1C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Prepare class file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Package with programming tools geared primarily towards LaTeX class and package authors 
\RequirePackage{etoolbox}  			

% Must indicate that we are using LaTeX2e (LaTeX2e is the latest stable release of LaTeX)
\NeedsTeXFormat{LaTeX2e}

% Define class name, date, and version
\ProvidesClass{nasa-latex-docs}[2016/02/02 v1.0 NASA LaTeX Docs]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Determine the document type option passed to class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Custom function to quickly declare toggles and set document type values 
\newcommand{\parseInputType}[2]{
   \newtoggle{#1}
   \DeclareOption{#1}{\toggletrue{#1}\let\docType=#2}
}

% Define each enumeration value
\def\caseAIAAConference{1}
\def\caseAIAAJournal{2}
\def\caseIEEE{3}
\def\caseTechMemo{4}
\def\caseTechBrief{5} 
\def\caseTechReport{6}

% Define document type variable
\def\docType{\caseTechReport}       

% Declare the possible document types to pass in as true/false toggles (from: etoolbox)
\parseInputType{AIAA-Conference}{\caseAIAAConference}
\parseInputType{AIAA-Journal}{\caseAIAAJournal}
\parseInputType{IEEE}{\caseIEEE}
\parseInputType{Tech-Memo}{\caseTechMemo}
\parseInputType{Tech-Brief}{\caseTechBrief}
\parseInputType{Tech-Report}{\caseTechReport}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Parse all other class options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define font-size
\def\@@ptsize{12pt}
\DeclareOption{9pt}{\def\@@ptsize{9pt}}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}

\newcommand{\parseInput}[1]{
   \newtoggle{#1}
   \DeclareOption{#1}{\toggletrue{#1}}
}

% Define all other options
\parseInput{twocolumns}
\parseInput{times}

% Process the options - they are now 'live' in the class file
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Setup the general options for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Toggle class loading based on \docType enumeration
\ifcase\docType
   \or % matches caseAIAAConference
      \LoadClass[letterpaper,10pt]{article}
   \or % matches caseAIAAJournal
      \LoadClass[letterpaper,10pt,twoside]{article}
      \toggletrue{twocolumns}
   \or % matches caseIEEE
      \LoadClass[letterpaper,10pt]{article}
      \toggletrue{twocolumns}
   \or % matches caseTechMemo
      \LoadClass[letterpaper,\@@ptsize]{article}
   \or % matches caseTechBrief
      \LoadClass[letterpaper,\@@ptsize]{article}
   \or % matches caseTechReport
      \LoadClass[letterpaper,\@@ptsize]{article}
\fi

% Override in order to use Times New Roman font
\iftoggle{times}{
   \RequirePackage{times}
   \RequirePackage{mathptmx}
}

% Define the column separation distance default value
\iftoggle{twocolumns}{
   \setlength{\columnsep}{0.75cm}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{packages.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document command shortcuts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doc-shortcuts.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load document parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{doc-params.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: General formatting definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define graphics inputs
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.ps,.gif,.eps}

% For breaking long underscored words into next line where appropriate
\renewcommand\_{\textunderscore\allowbreak}

% Create the bibliography
% Put this here because you want it at called before the "lastpage" package is loaded
\AtEndDocument{
   \clearpage
   \phantomsection
   \addcontentsline{toc}{section}{References}
   
   {\raggedright \printbibliography}
   
   % Command to reset glossary defs (avoids the need to delete .glsdefs each time)
   \glsresetall
}

% Include the lastpage package
\RequirePackage{lastpage}        % to determine last page of each section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION: Load custom definitions for each document type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Toggle class loading based on \docType enumeration
\ifcase\docType
   \or % matches caseAIAAConference
      \input{aiaa-conference.tex}  
      \geometry{margin=1in,headheight=0.5\baselineskip}    
   \or % matches caseAIAAJournal
      \input{aiaa-journal.tex}
      \geometry{margin=1in,headheight=0.5\baselineskip} 
   \or % matches caseIEEE
      \input{ieee.tex}
      \geometry{margin=1in,top=0.75in,bottom=0.9in,headheight=0.5\baselineskip}  
   \or % matches caseTechMemo
      \input{tech-brief.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}  
   \or % matches caseTechBrief
      \input{tech-memo.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}  
   \or % matches caseTechReport
      \input{tech-report.tex}
      \geometry{head=0.5in,foot=0.25in,top=0.65in,left=1in,right=1in,bottom=0.95in,includeheadfoot}
\fi

\endinput