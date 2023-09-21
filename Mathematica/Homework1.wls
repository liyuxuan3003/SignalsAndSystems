#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


xLabelFont={FontColor->Black,FontFamily->"Latin Modern",FontSize->5}


xFigConfig={
	Frame->True,GridLines->Automatic,ImageSize->Automatic->300,
	FrameStyle->BlackFrame,PlotStyle->ColorData[10],BaseStyle->xLabelFont};
xFigTicks=(FrameTicks->{
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}],
	Table[{x,xLaTeX[ToString[PaddedForm[x,{#4[[1]],#4[[2]]}]],0.5]},{x,#3[[1]],#3[[2]],#3[[3]]}]})&;
xFigLabel=(FrameLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8]})&;


funcList1={
	(2-3Exp[-t])UnitStep[t],
	Sin[Pi t]UnitStep[t],
	UnitStep[Sin[t]],
	2^k UnitStep[k],
	(k+1)UnitStep[k],
	2UnitStep[t+1]-3UnitStep[t-1]+UnitStep[t-2],
	t UnitStep[t] UnitStep[2-t],
	Sin[Pi (t-1)](UnitStep[2-t]-UnitStep[-t]),
	2^(-(k-2))UnitStep[k-2]
}


(* ::InheritFromParent:: *)
(*{(2-3 E^-t) UnitStep[t],UnitStep[t] Sin[\[Pi] t],UnitStep[Sin[t]],2^k UnitStep[k],(1+k) UnitStep[k],UnitStep[-2+t]-3 UnitStep[-1+t]+2 UnitStep[1+t],t UnitStep[2-t] UnitStep[t],(UnitStep[2-t]-UnitStep[-t]) Sin[\[Pi] (-1+t)],2^(2-k) UnitStep[-2+k]}*)


Plot[funcList1[[1]],{t,-5,5},Evaluate@xFigConfig]
Plot[funcList1[[2]],{t,-5,5},Evaluate@xFigConfig]
Plot[funcList1[[3]],{t,-5,5},Evaluate@xFigConfig]
DiscretePlot[funcList1[[4]],{k,-5,5},Evaluate@xFigConfig]
DiscretePlot[funcList1[[5]],{k,-5,5},Evaluate@xFigConfig]
Plot[funcList1[[6]],{t,-5,5},Evaluate@xFigConfig]
Plot[funcList1[[7]],{t,-5,5},PlotRange->All,Evaluate@xFigConfig]
Plot[funcList1[[8]],{t,-5,5},Evaluate@xFigConfig]
DiscretePlot[funcList1[[9]],{k,-5,5},Evaluate@xFigConfig]


2Pi/(Pi/3)


Sin[-Pi/2]
