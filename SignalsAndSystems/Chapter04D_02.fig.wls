#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter04D_02.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


f1[t_]:=(1/t)/;0<=t<1
f1[t_]:=f1[t-1]/;t>1
f1[t_]:=f1[t+1]/;t<1
f2[t_]:=(Sin[2Pi/t])/;0<=t<1
f2[t_]:=f2[t-1]/;t>1
f2[t_]:=f2[t+1]/;t<1


fig={
Plot[
	f1[t],{t,-2,2},
	PlotRange->{0,8},
	ImageSize->Automatic->300,
	Frame->True,
	GridLines->All,
	Axes->None,
	PlotStyle->{Black,Thickness[0.003]},
	PlotPoints->5000,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-2,2,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{2,1}]],Magnification->0.5]},{x,0,8,1}]},
	Exclusions->Table[i,{i,-2,2,1}],
	Filling->Axis],
Plot[
	f2[t],{t,-2,2},
	PlotRange->{-1,1},
	ImageSize->Automatic->300,
	Frame->True,
	GridLines->All,
	Axes->None,
	PlotStyle->{Black,Thickness[0.001]},
	PlotPoints->5000,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-2,2,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{2,1}]],Magnification->0.5]},{x,-1,1,0.5}]}]
}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
