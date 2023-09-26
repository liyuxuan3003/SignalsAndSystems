#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter05A_01.fig.wls";
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


MySquare[x_,T_,T1_]:=(Sign[Cos[2Pi x/T]-Cos[(2Pi)/(T/T1)]]+1)/2
Plot[MySquare[x,2,0.5],{x,-8,8},Frame->True,AspectRatio->1/3]


Plot[MySquare[x,2,0.5],{x,-8,8},
	AspectRatio->1/3,
	FrameTicks->{
		xTicks[{-8,8,1},{2,1}],
		xTicks[{0.0,1.0,0.5},{2,1}]
	},
	Evaluate@xFigConfig]


TList={4,8,16}
T1=1


fig1=ReleaseHold[Hold[Plot[
	MySquare[t,T,T1],{t,-16,16},
	PlotRange->{-0.5,1.5},
	GridLines->{xGrids[{-16,16,1}],xGrids[{-0.5,1.5,0.1}]},
	AspectRatio->1/3,
	PlotStyle->Black,
	Epilog->{
		Red,
		Arrowheads[{-0.008,0.008}],
		Thickness[0.0015],
		Arrow[{{0,-0.3},{T,-0.3}}],
		Arrow[{{0,1.2},{T1,1.2}}],
		Text[xLaTeX["\\textcolor{red}{T="<>ToString[T]<>"}",0.8],{T/2,-0.2}],
		Text[xLaTeX["\\textcolor{red}{\\omega_0=\\pi/"<>ToString[PaddedForm[T/2,{2,1}]]<>"}",0.8],{-12,-0.25}],
		Text[xLaTeX["\\textcolor{red}{T_1=1}",0.8],{3,1.2}]
	},
	Evaluate@xFigConfig,
	Evaluate@xFigLabel["t","x(t)"],
	Evaluate@xFigTicks[{-16,16,2},{2,1},{0,1,0.5},{2,1}]
]]/.(({T->#}&)/@ TList)]


FourierCoefficient[MySquare[t,4,1],t,3,FourierParameters->{1,-2Pi/4}]


fig2=ReleaseHold[Hold[DiscretePlot[
	T FourierCoefficient[MySquare[t,T,T1],t,n,FourierParameters->{1,-2Pi/T}],
	{n,-3 T,3 T},
	PlotRange->{-1,2.5},
	AspectRatio->1/3,
	Axes->None,
	PlotStyle->{Black},
	FrameTicks->{
		Table[{x,MaTeX[ToString[2x/T]<>"\\pi",Magnification->0.5]},{x,-3T,3T,T}],
		xTicks[{-1,2.5,0.5},{2,1}]
	},
	Epilog->{
		Text[xLaTeX["\\textcolor{red}{\\omega_0=\\pi/"<>ToString[PaddedForm[T/2,{2,1}]]<>"}",0.8],{1 T,1.75}]
	},
	GridLines->{xGrids[{-3T,3T,1}],xGrids[{-1,2.5,0.25}]},
	Evaluate@xFigLabel["\\omega=k\\omega_0","2\\pi (a_k/\\omega_0)"],
	Evaluate@xFigConfig
]]/.(({T->#}&)/@TList)]


fig=Join[fig1,fig2]
figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
