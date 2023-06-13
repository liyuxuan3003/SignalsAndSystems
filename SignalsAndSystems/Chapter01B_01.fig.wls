#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01B_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
Export[nbPDFName,""]


Fig1=Plot[
	Sin[x],{x,-2Pi,2Pi},
	GridLines->Automatic,
	Frame->True,
	FrameTicks->
	{
		Table[{x Pi,MaTeX[ToString[x]<>"\\pi",Magnification->0.7]},{x,-2,2,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.7]},{x,-1,1,0.5}]
	},
	FrameLabel->{MaTeX["\\omega t",Magnification->0.8],MaTeX["f(t)=\\sin(\\omega t)",Magnification->0.8]},
	ImageSize->Automatic->200,
	PlotStyle->Black
]
Export[StringReplace[nbPDFName,".fig"->"a.fig"],Fig1]


Fig2=DiscretePlot[
	Sin[b k]/.{b->Pi/10},{k,-20,20},
	GridLines->Automatic,
	Frame->True,
	FrameTicks->
	{
		Table[{x,MaTeX[ToString[x],Magnification->0.7]},{x,-20,20,10}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.7]},{x,-1,1,0.5}]
	},
	FrameLabel->{MaTeX["k\\quad(\\beta=\\pi/10)",Magnification->0.8],MaTeX["f(k)=\\sin(\\beta k)",Magnification->0.8]},
	ImageSize->Automatic->200,
	PlotStyle->Black
]
Export[StringReplace[nbPDFName,".fig"->"b.fig"],Fig2]


(*-*)
