#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter01D_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


ArrowsDeltaFunction[eqn_,x_]:=Module[{xsubs,listDeltas,coefDeltas,locationDeltas},xsubs=(x/. Cases[eqn,DiracDelta[a__]:>Solve[a==0,x],{0,Infinity}])/. x->{};
listDeltas=DiracDelta[x-x0]/. x0->xsubs;
coefDeltas=Flatten[Coefficient[eqn,listDeltas]];
locationDeltas=Flatten[xsubs];
Arrow[Table[{{locationDeltas[[i]],0},{locationDeltas[[i]],coefDeltas[[i]]}},{i,1,Length[locationDeltas]}]]]


funcGamma[t_,n_]:=Piecewise[{{1/2+n/2 t,-(1/n)<t<1/n},{0,t<-(1/n)},{1,t>1/n}}];
funcEpsilon[t_]:=HeavisideTheta[t];
funcP[t_,n_]:=Piecewise[{{n/2,-(1/n)<=t<=1/n},{0,t<-(1/n)},{0,t>1/n}}];
funcDirac[t_]:=DiracDelta[t];


fig=ReleaseHold[Hold[Plot[
	f[t],{t,-4,4},PlotRange->{-0.1,1.1},
	Epilog->{sty,ArrowsDeltaFunction[f[t][[1]],t]},
	GridLines->Automatic,
	ImageSize->Automatic->250,
	Frame->True,
	Exclusions->None,
	FrameTicks->{
		Table[{x,MaTeX[ToString[x],Magnification->0.5]},{x,-4,4,1}],
		Table[{x,MaTeX[ToString[PaddedForm[x,{1,1}]],Magnification->0.5]},{x,0,1,0.1}]
	},
	FrameLabel->lab,
	PlotLegends->Placed[LineLegend[leg,LegendFunction->"Panel",LegendLayout->"ReversedColumn"],{Left,Top}],
	PlotStyle->sty
]]/.
(
	({f[t]->#[[1]],sty->#[[2]],lab->#[[3]],leg->#[[4]]}&)/@
	{
		{
			(funcGamma[t,#]&)/@{0.5,1,2},
			{{Gray,Dashed,Thickness[0.005]},{Black},{Red,Thin}},
			{MaTeX["t",Magnification->0.8],MaTeX["\\gamma_n(t)",Magnification->0.8]},
			{MaTeX["n=0.5",Magnification->0.8],MaTeX["n=1.0",Magnification->0.8],MaTeX["n=2.0",Magnification->0.8]}
		},
		{
			(funcP[t,#]&)/@{0.5,1,2},
			{{Gray,Dashed,Thickness[0.005]},{Black},{Red,Thin}},
			{MaTeX["t",Magnification->0.8],MaTeX["p_n(t)",Magnification->0.8]},
			{MaTeX["n=0.5",Magnification->0.8],MaTeX["n=1.0",Magnification->0.8],MaTeX["n=2.0",Magnification->0.8]}
		},
		{
			{funcEpsilon[t]},
			{Black},
			{MaTeX["t",Magnification->0.8],MaTeX["\\varepsilon_n(t)",Magnification->0.8]},
			{}
		},
		{
			{funcDirac[t]},
			{Black},
			{MaTeX["t",Magnification->0.8],MaTeX["\\updelta_n(t)","Preamble"->{"\\usepackage{upgreek}"},Magnification->0.8]},
			{}
		}
	}
)]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*-*)
