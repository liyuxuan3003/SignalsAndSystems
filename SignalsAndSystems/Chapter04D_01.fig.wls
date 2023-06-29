#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter04D_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


fig=ReleaseHold[Hold[Plot[
	{Evaluate@FourierTrigSeries[SquareWave[t+0.25],t,n,FourierParameters->{1,2Pi}],SquareWave[t+0.25]},
	{t,-1,1},
	PlotRange->{-1.5,1.5},
	Frame->True,
	GridLines->All,
	Axes->None,
	ImageSize->Automatic->200,
	ExclusionsStyle->{{Dashed,Red,Thin}},
	PlotPoints->4000,
	PlotStyle->{{Black,Thickness[0.004]},{Red,Thin}},
	FrameLabel->{MaTeX["n="<>ToString[n],Magnification->0.8,ContentPadding->False],None},
	FrameTicks->{
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.4]},{x,-1,1,0.5}],
		Table[{Chop[x],MaTeX[ToString[PaddedForm[Chop[x],{2,1}]],Magnification->0.4]},{x,-1.4,1.4,0.2}]
	}]]/.(({n->#[[1]]}&)/@{{3},{5},{10},{20},{40},{80}})]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
