#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter05C_02.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


xLaTeX=(MaTeX[
	#1,Magnification->#2,
	"Preamble"->{"\\usepackage{siunitx}","\\usepackage{physics}","\\usepackage{upgreek}","\\usepackage{color}"}])&;


xLabelFont={FontColor->Black,FontFamily->"Latin Modern",FontSize->5}


xFigConfig={
	Frame->True,GridLines->Automatic,ImageSize->Automatic->300,
	FrameStyle->BlackFrame,PlotStyle->ColorData[10],BaseStyle->xLabelFont};
xFigTicks=(FrameTicks->{
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}],
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#4[[1]],#4[[2]]}]],0.5]},{x,#3[[1]],#3[[2]],#3[[3]]}]})&;
xFigLabel=(FrameLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8]})&;


xTicks=(Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksDif=(Table[{x,xLaTeX[#2[x],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog=(Table[{10^x,xLaTeX["10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog1=(Table[{10^x,xLaTeX["1\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog2=(Table[{2 10^x,xLaTeX["2\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog5=(Table[{5 10^x,xLaTeX["5\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;


xGrids=(Table[x,{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xGridsLog=(Flatten[Table[Table[{If[#2[[1]]<=(n 10^x)<=#2[[2]],(n 10^x),{}]},{n,1,9,1}],{x,#1[[1]],#1[[2]],#1[[3]]}]])&;


rect=Function[t,Piecewise[{{1/2,Abs[t]<1},{0,Abs[t]>1}}]]
sinc=Function[t,Piecewise[{{Sin[t]/t,t!=0},{1,t==0}}]]


fig1=Plot[rect[t],{t,-2Pi,2Pi},PlotRange->{-0.75,3.75},PlotStyle->Red,
	Prolog->{
		Thin,Dashed,
		Line[{{-2Pi,0.5},{2Pi,0.5}}],
		Text[xLaTeX["(1/2)",0.7],{4.5,0.65}]
	},
	Epilog->{Text[xLaTeX["\\textcolor{red}{\\textrm{rect}(t)}",0.85],{0,3.35}]},
	Evaluate@xFigLabel["t","f(t)=\\textrm{rect}(t)"],
	Evaluate@xFigTicks[{-6,6,1},{1,0},{0,3.5,0.5},{2,1}],
	GridLines->{xGrids[{-6.0,6.0,0.5}],xGrids[{-0.5,3.5,0.5}]},
	Evaluate@xFigConfig]
fig2=Plot[sinc[w],{w,-2Pi,2Pi},PlotRange->{-0.75,3.75},PlotStyle->Blue,
	Prolog->{
		Thin,Dashed,
		Line[{{-2Pi,-0.75},{-2Pi,3.75}}],
		Line[{{-1Pi,-0.75},{-1Pi,3.75}}],
		Line[{{+1Pi,-0.75},{+1Pi,3.75}}],
		Line[{{+2Pi,-0.75},{+2Pi,3.75}}],
		Text[xLaTeX["-2\\pi",0.7],{-2Pi+0.5,3.25}],
		Text[xLaTeX["-1\\pi",0.7],{-1Pi+0.5,3.25}],
		Text[xLaTeX["+1\\pi",0.7],{+1Pi-0.5,3.25}],
		Text[xLaTeX["+2\\pi",0.7],{+2Pi-0.5,3.25}]
	},
	Epilog->{Point[Table[{x,sinc[x]},{x,-2Pi,2Pi,Pi}]],
		Text[xLaTeX["\\textcolor{blue}{\\textrm{sinc}(\\omega)}",0.85],{0,3.35}]},
	Evaluate@xFigLabel["\\omega","F(\\textrm{j}\\omega)=\\textrm{sinc}(\\omega)"],
	Evaluate@xFigTicks[{-6,6,1},{1,0},{0,3.5,0.5},{2,1}],
	GridLines->{xGrids[{-6.0,6.0,0.5}],xGrids[{-0.5,3.5,0.5}]},
	Evaluate@xFigConfig]
fig3=Plot[sinc[t],{t,-2Pi,2Pi},PlotRange->{-0.75,3.75},PlotStyle->Red,
	Prolog->{
		Thin,Dashed,
		Line[{{-2Pi,-0.75},{-2Pi,3.75}}],
		Line[{{-1Pi,-0.75},{-1Pi,3.75}}],
		Line[{{+1Pi,-0.75},{+1Pi,3.75}}],
		Line[{{+2Pi,-0.75},{+2Pi,3.75}}],
		Text[xLaTeX["-2\\pi",0.7],{-2Pi+0.5,3.25}],
		Text[xLaTeX["-1\\pi",0.7],{-1Pi+0.5,3.25}],
		Text[xLaTeX["+1\\pi",0.7],{+1Pi-0.5,3.25}],
		Text[xLaTeX["+2\\pi",0.7],{+2Pi-0.5,3.25}]
	},
	Epilog->{Point[Table[{x,sinc[x]},{x,-2Pi,2Pi,Pi}]],
		Text[xLaTeX["\\textcolor{red}{\\textrm{sinc}(t)}",0.85],{0,3.35}]},
	Evaluate@xFigLabel["t","f(t)=\\textrm{sinc}(t)"],
	Evaluate@xFigTicks[{-6,6,1},{1,0},{0,3.5,0.5},{2,1}],
	GridLines->{xGrids[{-6.0,6.0,0.5}],xGrids[{-0.5,3.5,0.5}]},
	Evaluate@xFigConfig]
fig4=Plot[2Pi rect[w],{w,-2Pi,2Pi},PlotRange->{-0.75,3.75},PlotStyle->Blue,
	Prolog->{
		Thin,Dashed,
		Line[{{-2Pi,Pi},{2Pi,Pi}}],
		Text[xLaTeX["2\\pi(1/2)",0.7],{4.5,Pi+0.15}],
	},
	Epilog->{Text[xLaTeX["\\textcolor{blue}{2\\pi\\textrm{rect}(\\omega)}",0.85],{0,3.35}]},
	Evaluate@xFigLabel["\\omega","F(\\textrm{j}\\omega)=2\\pi\\textrm{rect}(\\omega)"],
	Evaluate@xFigTicks[{-6,6,1},{1,0},{0,3.5,0.5},{2,1}],
	GridLines->{xGrids[{-6.0,6.0,0.5}],xGrids[{-0.5,3.5,0.5}]},
	Evaluate@xFigConfig]


fig={fig1,fig2,fig3,fig4}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]


(*-*)
