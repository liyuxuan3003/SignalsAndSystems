#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter03C_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


fig=ReleaseHold[Hold[DiscretePlot[
	f[k],{k,-5,5},PlotRange->{-0.1,1.1},
	GridLines->Automatic,
	Axes->None,
	ImageSize->Automatic->200,
	Frame->True,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-5,5,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.5]},{x,0,1,0.1}]
	},
	FrameLabel->{MaTeX["k",Magnification->0.8],MaTeX[lab,Magnification->0.8,"Preamble"->{"\\usepackage{upgreek}"}]},
	PlotStyle->Black
]]/.
(
	({f[k]->#[[1]],lab->#[[2]]}&)/@
	{
		{KroneckerDelta[k,0],"\\updelta(k)"},
		{UnitStep[k],"\\varepsilon(k)"}
	}
)]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
