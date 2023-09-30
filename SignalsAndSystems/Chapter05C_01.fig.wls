#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter05C_01.fig.wls";
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


xExpS=Exp[-a t]UnitStep[t]
xExpD1=Exp[-a Abs[t]]
xExpD2=Exp[-a Abs[t]]Sign[t]
xDCV=1
xSGN=Sign[t]
xExpSFT=FourierTransform[xExpS,t,w,FourierParameters->{1, -1}]
xExpD1FT=FourierTransform[xExpD1,t,w,FourierParameters->{1, -1}]
xExpD2FT=FourierTransform[xExpD2,t,w,FourierParameters->{1, -1}]
xDCVFT=FourierTransform[xDCV,t,w,FourierParameters->{1, -1}]
xSGNFT=FourierTransform[xSGN,t,w,FourierParameters->{1, -1}]


xFigStyleA={
	ExclusionsStyle->Dashing[Small],
	PlotRange->{-2.4,2.4},
	PlotStyle->Black,
	Evaluate@xFigTicks[{-5,5,1},{1,0},{-2,2,0.5},{2,1}],
	Evaluate@xFigLabel[#1,#2],
	Evaluate@xFigConfig}&;
xFigStyleAt=xFigStyleA["x","x(t)"];
xFigStyleAwAbs=xFigStyleA["\\omega","\\mathrm{Abs}[X(\\mathrm{j}\\omega)]"];
xFigStyleAwArg={
	PlotRange->{-Pi,Pi},
	PlotStyle->Black,
	FrameTicks->{xTicks[{-5,5,1},{1,0}],Table[{x Pi,xLaTeX[ToString[NumberForm[x,{2,1}]]<>"\\pi",0.5]},{x,-1,1,0.5}]},
	Evaluate@xFigLabel["\\omega","\\mathrm{Arg}[X(\\mathrm{j}\\omega)]"],
	Evaluate@xFigConfig};
xFigStyleAwRe=xFigStyleA["\\omega","\\Re[X(\\mathrm{j}\\omega)]"];
xFigStyleAwIm=xFigStyleA["\\omega","\\Im[X(\\mathrm{j}\\omega)]"];


fig1a=Plot[xExpS/.{a->1},{t,-5,5},Exclusions->{0},Evaluate@xFigStyleAt]
fig1b=Plot[Abs[xExpSFT]/.{a->1},{w,-5,5},
	Epilog->{
		Dashed,Gray,
		Line[{{-4,1},{4,1}}],
		Text[xLaTeX["\\textcolor[rgb]{0.5,0.5,0.5}{1/a}",0.8],{4.3,1}]},
	Evaluate@xFigStyleAwAbs]
fig1c=Plot[Arg[xExpSFT]/.{a->1},{w,-5,5},Evaluate@xFigStyleAwArg]


fig2a=Plot[xExpD1/.{a->1},{t,-5,5},Exclusions->{0},Evaluate@xFigStyleAt]
fig2b=Plot[Re[xExpD1FT]/.{a->1},{w,-5,5},
	Epilog->{
		Dashed,Gray,
		Line[{{-4,+2},{4,+2}}],
		Text[xLaTeX["\\textcolor[rgb]{0.5,0.5,0.5}{2/a}",0.8],{4.3,+2}]},
	Evaluate@xFigStyleAwRe]


fig3a=Plot[xExpD2/.{a->1},{t,-5,5},Exclusions->{0},Evaluate@xFigStyleAt]
fig3b=Plot[xExpD2FT/I/.{a->1},{w,-5,5},
	Epilog->{
		Dashed,Gray,
		Line[{{-4,+1},{4,+1}}],
		Line[{{-4,-1},{4,-1}}],
		Text[xLaTeX["\\textcolor[rgb]{0.5,0.5,0.5}{+1/a}",0.8],{4.4,+1}],
		Text[xLaTeX["\\textcolor[rgb]{0.5,0.5,0.5}{-1/a}",0.8],{4.4,-1}]},
	Evaluate@xFigStyleAwIm]


aList={a->Table[1/2^x,{x,0,5,1}]};
xFigLegendB={PlotLegends->Placed[LineLegend[
	Table[xLaTeX["a=1/"<>ToString[2^a],0.6],{a,0,5,1}],
	LegendFunction->"Panel",
	LegendLayout -> {"Column",2}],{Right,Bottom}]}
xFigStyleBt={
	ExclusionsStyle->Dashing[Small],
	PlotRange->{-1.1,1.1},
	Evaluate@xFigLegendB,
	Evaluate@xFigTicks[{-5,5,1},{1,0},{-1,1,0.5},{2,1}],
	Evaluate@xFigLabel["t","x(t)"],
	Evaluate@xFigConfig};
xFigStyleBw={
	ExclusionsStyle->Dashing[Small],
	PlotRange->{-11,11},
	PlotPoints->100,
	Evaluate@xFigLegendB,
	Evaluate@xFigTicks[{-5,5,1},{1,0},{-10,10,5},{2,0}],
	Evaluate@xFigLabel["w",#],
	Evaluate@xFigConfig}&;
xFigStyleBwRe=xFigStyleBw["\\Re[X(\\mathrm{j}\\omega)]"];
xFigStyleBwIm=xFigStyleBw["\\Im[X(\\mathrm{j}\\omega)]"];


fig4a=Plot[Evaluate[xExpD1/.aList],{t,-5,5},Evaluate@xFigStyleBt]
fig4b=Plot[Evaluate[xExpD2/.aList],{t,-5,5},Evaluate@xFigStyleBt]
fig4c=Plot[Evaluate[Re[xExpD1FT]/.aList],{w,-5,5},Evaluate@xFigStyleBwRe]
fig4d=Plot[Evaluate[Im[xExpD2FT]/.aList],{w,-5,5},Evaluate@xFigStyleBwIm]


fig={fig1a,fig1b,fig1c,fig2a,fig2b,fig3a,fig3b,fig4a,fig4b,fig4c,fig4d}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]


(*-*)
