#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01B_02.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


fig1=ReleaseHold[Hold[Plot[
	{Exp[sigma t]Cos[t],Exp[sigma t]},{t,-6 Pi,6 Pi},PlotRange->{-3.5,3.5},
	GridLines->Automatic,
	Frame->True,
	FrameTicks->None,
	FrameLabel->{
		MaTeX["t",Magnification->0.8],
		MaTeX["\\mathrm{Re}[f(t)]=\\mathrm{e}^{\\sigma}\\cos(\\omega t)",Magnification->0.8]},
	ImageSize->Automatic->240,
	PlotStyle->{{Black},{Red,Dashed,Thin}}
]]/.{{sigma->0.05},{sigma->0},{sigma->-0.05}}]
fig1Legend=LineLegend[{Black,Directive[Red,Dashed,Thin]},{
	MaTeX["\\hspace{-0.1em}\\omega\\neq 0\\hspace{1em}"],
	MaTeX["\\hspace{-0.1em}\\omega=0"]},LegendMarkerSize->40,LegendLayout->"Row"]


fig2=ReleaseHold[Hold[DiscretePlot[
	{Exp[alpha k Pi/10]Cos[k Pi/10],Exp[alpha k Pi/10]},{k,-60,60},PlotRange->{-3.5,3.5},
	GridLines->Automatic,
	Frame->True,
	FrameTicks->None,
	FrameLabel->{
		MaTeX["k",Magnification->0.8],
		MaTeX["\\mathrm{Re}[f(k)]=a^{k}\\cos(\\beta k)",Magnification->0.8]},
	ImageSize->Automatic->240,
	PlotMarkers->{{Automatic,Scaled[0.01]},{Automatic,Scaled[0.005]}},
	PlotStyle->{{Black},{Red,Thin,Tiny}}
]]/.{{alpha->0.05},{alpha->0},{alpha->-0.05}}]
fig2Legend=PointLegend[{Black,Red},{
	MaTeX["\\hspace{-0.1em}\\beta\\neq 0\\hspace{4em}"],
	MaTeX["\\hspace{-0.1em}\\beta=0"]},LegendMarkerSize->15,LegendLayout->"Row"]


fig=Join[fig1,fig2,{fig1Legend},{fig2Legend}];
figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
