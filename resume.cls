\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]
\LoadClass[11pt]{article}

% disable indent globally
\setlength{\parindent}{0pt}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use xifthen
\RequirePackage{xifthen}
% use fontawesome
\RequirePackage{fontawesome}
% use xcolor for customizing color
\RequirePackage[usenames,dvipsnames]{xcolor}
% loading fonts
\RequirePackage{fontspec}
% Main document font
\setmainfont[
  Path = fonts/Main/ ,
  Extension = .otf ,
  UprightFont = *-regular ,
  BoldFont = *-bold ,
  ItalicFont = *-italic ,
  BoldItalicFont = *-bolditalic ,
  SmallCapsFont = Fontin-SmallCaps
]{texgyretermes}

\RequirePackage[
    a4paper,
    left=0.7in,
    right=0.7in,
    top=0.50in,
    bottom=0.5in,
    nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.5pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.5pc}
\RequirePackage[super]{nth}

\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [\titlerule]                 % Inserts a horizontal line after the heading
\titlespacing*{\section}{0cm}{*1}{*1}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0cm}{*1}{*0.5}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}
\newcommand{\datedline}[2]{%
  {\par #1 \hfill #2 \par}%
}

\newcommand{\name}[1]{
  \centerline{\Huge\scshape{#1}}
  \vspace{1.2ex}
}

\newcommand{\contactInfo}[4]{
  \centerline{\sffamily\large{\ {#1} \textperiodcentered\ \ {#2}}
    \ifthenelse{\isempty{#3}}%
      { } % if {#3} is empty
      {\textperiodcentered\ \ {#3} } % homepage, no space before \text...
    \ifthenelse{\isempty{#4}}%
      { } % if {#3} is empty
      {\textperiodcentered\ \ {#4} }
  }
  \vspace{0.7ex}
}

\newcommand{\role}[2]{
  {\par \textit{#1} ~ #2 \par}
  \vspace{0.5ex}
}

% ==================== 仿Markdown行内代码高亮样式 ====================
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

% 定义\mcode宏
% 参数格式：
%   [可选] #1 - tcolorbox样式覆盖参数（如修改颜色、边距等）
%   {必选}   - 需要高亮显示的技术名词文本
\newtcbox{\mcode}[1][]{
  on line,              % 行内模式（防止自动换行）
  boxsep=1pt,           % 文字与边框的内边距（左右对称）
  top=1pt,              % 顶部补偿间距（解决垂直对齐问题）
  bottom=0.5pt,         % 底部补偿间距
  left=3pt,             % 左侧内边距（控制文字缩进）
  right=3pt,            % 右侧内边距
  colback=gray!5,       % 背景色（5%灰度浅灰）
  colframe=blue!30!black!20,  % 边框色（30%蓝+20%黑的混合色）
  arc=3pt,              % 圆角半径（视觉柔和效果）
  boxrule=0.5pt,        % 边框线粗细（0.5磅细线）
  #1                    % 开放参数覆盖接口
}

% 定义\techlist宏 - 自动生成技术名词列表
% 参数格式：
%   {必选} #1 - 逗号分隔的技术名词字符串（如"Java,Python"）
\RequirePackage{pgffor}
\newcommand{\techlist}[1]{
  \foreach \x in {#1} {\mcode{\x}\,}
}
% ==================== 仿Markdown行内代码高亮样式结束 ====================

% ==================== 照片宏定义 ====================
% 定义 \photo 宏 - 右上角固定位置显示照片
% 参数:
%   {必选} 照片文件路径
%   [可选] 键值参数:
%     width=30mm    - 显示宽度（默认30mm）
%     scale=0.7     - 缩放比例（默认0.7）
\RequirePackage{keyval}
\RequirePackage[absolute]{textpos}
\RequirePackage{graphicx}
\makeatletter
\define@key{photo}{width}{\def\photo@width{#1}}
\define@key{photo}{scale}{\def\photo@scale{#1}}
\newcommand{\photo}[2][]{%
  \setkeys{photo}{width=30mm,scale=0.7,#1}% 设置默认值
  \begin{textblock*}{\photo@width}(170mm,6mm) % 定位右上角
    \includegraphics[width=\photo@width,height=\photo@width,keepaspectratio]{#2}%
  \end{textblock*}%
}
\makeatother
% ==================== 照片宏定义结束 ====================