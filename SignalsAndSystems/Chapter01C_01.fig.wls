#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01C_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


f[x_]:=0/;(x<=-4);
f[x_]:=0.25x+1/;(-4<x<=0);
f[x_]:=1/;(0<x<=2);
f[x_]:=0/;(x>2);
fd[x_]:=f[x]/;IntegerQ[FullSimplify[x]];


fig1=ReleaseHold[Hold[Plot[
	{f[t],f[c[t]]},{t,-10,10},PlotRange->{-0.1,1.1},
	GridLines->Automatic,
	ImageSize->Automatic->240,
	AspectRatio->0.3,
	Frame->True,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-10,10,2}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.5]},{x,0,1,0.2}]
	},
	PlotStyle->{{Red,Dashed,Thin},{Black}}
]]/.(({c[t]->#}&)/@{t,-t,t-4,t+4,2t,0.5t})]


fig2=ReleaseHold[Hold[Show[
DiscretePlot[
	{fd[c[t]]},{t,-10,10,s},PlotRange->{-0.1,1.1},
	GridLines->Automatic,
	ImageSize->Automatic->240,
	AspectRatio->0.3,
	Frame->True,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-10,10,2}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.5]},{x,0,1,0.2}]
	},
	PlotStyle->{{Black}},
	PlotMarkers->{{Automatic,6}}
],
DiscretePlot[
	{fd[t]},{t,-10,10},
	PlotStyle->{{Red,Thin}},
	PlotMarkers->{{Automatic,2}}
]]]/.(({c[t]->#[[1]],s->#[[2]]}&)/@{{t,1},{-t,1},{t-4,1},{t+4,1},{2t,1},{Round[t/2],2}})]


fig=Join[fig1,fig2];
figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
