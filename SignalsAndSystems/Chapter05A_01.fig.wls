#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter05A_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


MySquare[x_,T_,T1_]:=(Sign[Cos[2Pi x/T]-Cos[(2Pi)/(T/T1)]]+1)/2
Plot[MySquare[x,2,0.5],{x,-8,8},Frame->True,AspectRatio->1/3]


TList={4,8,16}
T1=1


fig1=ReleaseHold[Hold[Plot[
	MySquare[t,T,T1],{t,-16,16},
	PlotRange->{-0.5,1.5},
	Frame->True,
	GridLines->{Table[x,{x,-16,16,1}],Table[x,{x,-0.5,1.5,0.1}]},
	ImageSize->Automatic->300,
	AspectRatio->1/3,
	PlotStyle->Black,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.3]},{x,-16,16,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{2,1}]],Magnification->0.3]},{x,0.0,1.0,0.5}]
	},
	Epilog->{
		Red,
		Arrowheads[{-0.008,0.008}],
		Thickness[0.0015],
		Arrow[{{0,-0.3},{T,-0.3}}],
		Arrow[{{0,1.2},{T1,1.2}}],
		Text[MaTeX["\\textcolor{red}{T}",Magnification->0.8,"Preamble"->{"\\usepackage{color}"}],{T/2,-0.2}],
		Text[MaTeX["\\textcolor{red}{T_1}",Magnification->0.8,"Preamble"->{"\\usepackage{color}"}],{2,1.2}]
	}
]]/.(({T->#}&)/@ TList)]


FourierCoefficient[MySquare[t,4,1],t,3,FourierParameters->{1,-2Pi/4}]


fig2=ReleaseHold[Hold[DiscretePlot[
	T FourierCoefficient[MySquare[t,T,T1],t,n,FourierParameters->{1,-2Pi/T}],
	{n,-3 T,3 T},
	PlotRange->{-1,2.5},
	GridLines->{Table[x,{x,-3T,3T,1}],Table[x,{x,-1,2.5,0.25}]},
	Frame->True,
	ImageSize->Automatic->300,
	AspectRatio->1/3,
	Axes->None,
	PlotStyle->{Black},
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.3]},{x,-3T,3T,4}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{2,1}]],Magnification->0.3]},{x,-1,2.5,0.5}]
	}
]]/.(({T->#}&)/@TList)]


fig=Join[fig1,fig2]
figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
