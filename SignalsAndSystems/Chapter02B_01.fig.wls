#!/usr/bin/env wolframscript
(* ::Package:: *)

SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter02B_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


eq=y''[t]+2 a y'[t]+w0^2 y[t]==w0^2 f[t]


ysolveH=DSolve[{eq/.{f[t]->DiracDelta[t]},y[0]==0,y'[0]==0},y[t],t]
ysolveG=DSolve[{eq/.{f[t]->HeavisideTheta[t]},y[0]==0,y'[0]==0},y[t],t]


Manipulate[Plot[Evaluate[y[t]/.{ysolveG,ysolveH}/.{w0->1,a->am,HeavisideTheta[0]->0}],{t,-Pi,6Pi},
	Frame->True,
	GridLines->Automatic,
	PlotRange->{-1.1,2.1},
	PlotStyle->{Red,Blue}
],{am,0,10}]


alphaListStr={"0.000","0.125","0.250","0.500","1","2","4","8"};
alphaList=(ToExpression/@alphaListStr)/.{1->0.9999};
fig=ReleaseHold[Hold[Plot[Evaluate[y[t]/.ysolve/.{w0->1,HeavisideTheta[0]->0}/.Table[{a->ax},{ax,alphaList}]],{t,-Pi,6Pi},
	Frame->True,
	Axes->{False,False},
	GridLines->Automatic,
	PlotRange->{-2.1,2.1},
	PlotStyle->ColorData[10],
	ImageSize->Automatic->400,
	PlotPoints->5000,
	FrameTicks->{
		Table[{x Pi,MaTeX[ToString[x]<>"\\pi",Magnification->0.85]},{x,-1,6,1}],
		Table[{x,MaTeX[ToString[x],Magnification->0.85]},{x,-2,2,1}]
	},
	FrameLabel->{MaTeX["t",Magnification->1],MaTeX[funcName,Magnification->1]},
	PlotLegends->Placed[
		LineLegend[
			(MaTeX["\\alpha="<>#,Magnification->1]&)/@alphaListStr,
			LegendFunction->"Panel",
			LegendLayout -> {"Column",4}],{Center,Bottom}]
]]/.(({ysolve->#[[1]],funcName->#[[2]]}&)/@{{ysolveG,"g(t)"},{ysolveH,"h(t)"}})]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]]]]&)/@figWithName]


(*
b[a_,w0_]:=Sqrt[a^2-w0^2]/;a>w0
b[a_,w0_]:=Sqrt[w0^2-a^2]/;a<w0
b[a_,w0_]:=1/;a==w0
h[t_,a_,w0_]:=w0^2/b[a,w0]Exp[-a t]Sinh[b[a,w0] t]HeavisideTheta[t]/;a>w0
h[t_,a_,w0_]:=w0^2/b[a,w0]Exp[-a t]Sin[b[a,w0] t]HeavisideTheta[t]/;a<w0
h[t_,a_,w0_]:=w0^2Exp[-a t]t HeavisideTheta[t]/;a==w0
g[t_,a_,w0_]:=Integrate[h[tau,a,w0],{tau,-Infinity,t}]
*)


(*
Manipulate[Plot[{h[t,am,1],g[t,am,1]},{t,-Pi,6Pi},
	Frame->True,
	GridLines->Automatic,
	PlotRange->{-1.1,2.1},
	PlotStyle->{Red,Blue}
],{am,0,10}]
*)


Integrate[Exp[-a tau]Sinh[b tau],{tau,0,t}]
Integrate[Exp[-a tau]Sin[b tau],{tau,0,t}]
Integrate[Exp[-a tau]tau,{tau,0,t}]


(*-*)
