#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter04C_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


MySquare[x_,b_]:=(Sign[Cos[2Pi x]-Cos[(2Pi)/b]]+1)/2
Plot[MySquare[x,6],{x,-2,2}]


fig1=ReleaseHold[Hold[Plot[
	MySquare[t,b],
	{t,-1.5,1.5},
	PlotRange->{-0.25,1.25},
	Frame->True,
	GridLines->All,
	ImageSize->Automatic->200,
	Axes->None,
	PlotStyle->{Black,Thickness[0.005]},
	FrameTicks->{
		Join[
			Table[
				{x,MaTeX[ToString[PaddedForm[x,{2,1}]]<>"\;T",Magnification->0.4]},
				{x,{-1.5,-1,-0.5,0.5,1,1.5}}],
			{{1/b,MaTeX["T_1",Magnification->0.4]},{-1/b,MaTeX["-T_1",Magnification->0.4]}},
			Table[{x,""},{x,-0.5,0.5,0.125}]
		],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.4]},{x,0,1,0.5}]}
]]/.(({b->#}&)/@{4,8,16})]


fig2=ReleaseHold[Hold[DiscretePlot[
	FourierCoefficient[MySquare[t,b],t,n,FourierParameters->{1,-2Pi}],
	{n,-24,24},
	PlotRange->{-0.21,0.61},
	Frame->True,
	GridLines->{Table[x,{x,-24,24,2}],Table[x,{x,-0.2,0.61,0.1}]},
	ImageSize->Automatic->200,
	Axes->None,
	PlotStyle->{Black},
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.4]},{x,-24,24,4}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{2,1}]],Magnification->0.4]},{x,-0.2,0.61,0.1}]}
]]/.(({b->#}&)/@{4,8,16})]


fig=Join[fig1,fig2]
figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
