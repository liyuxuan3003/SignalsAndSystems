#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01D_02.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


dGauss[t_,b_]:=b Exp[-Pi (b t)^2];
dSample[t_,b_]:=Sin[b t]/(Pi t);
dExp[t_,b_]:=Exp[-Abs[t]/b]/(2b);
dPara[t_,b_]:=b/(Pi(b^2+t^2))


fig=ReleaseHold[Hold[Plot[
	f[t],{t,-2,2},PlotRange->{-1,4.5},
	GridLines->Automatic,
	ImageSize->Automatic->225,
	Frame->True,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-2,2,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.5]},{x,-1,4,1}]
	},
	FrameLabel->{MaTeX["t",Magnification->0.8],None},
	PlotLegends->Placed[LineLegend[(MaTeX["n="<>ToString[#,InputForm],Magnification->0.8]&)/@blist,LegendFunction->"Panel",LegendLayout->"Column"],{Left,Top}]
]]/.(({f[t]->Table[#[[1]][t,b],{b,#[[2]]}],blist->#[[2]],yrange->#[[3]]}&)/@
{
	{dGauss,{1,2,3,4},{-3,9}},
	{dSample,{1,2,4,8},{-1.5,4.5}},
	{dExp,{1,1/2,1/4,1/8},{-1.5,4.5}},
	{dPara,{1,1/2,1/4,1/8},{-1.5,4.5}}
})]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
