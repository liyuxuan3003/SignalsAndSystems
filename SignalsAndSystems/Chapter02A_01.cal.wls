#!/usr/bin/env wolframscript
(* ::Package:: *)

xDSolve[expr_,func_,var_,l_:\[Lambda]]:=Module[
	{eq=expr[[1]],eq1,eq2,eigen,eigenSolve,eigenList,yh},
	eq1=eq[[1]];
	eq2=eq[[2]];
	eigen=eq1/.{Derivative[n_][Head[func]][var]:>l^n,func->1};
	eigenSolve=Solve[eigen==0,l];
	eigenList=(f@@Gather[Flatten[eigenSolve]])/.{a_List:>{a[[1]],Length[a]}}/.{(_->b_):>b};
	eigenListInd=MapIndexed[Flatten[{#1,#2}]&,eigenList];
	yh=Plus@@(eigenListInd/.{
		{a_,r_,n_}:>Exp[a var]Sum[c[n][k]var^k,{k,0,r-1}]});
	yh
];


xDSolve[{y''[t]+5y'[t]+6y[t]==2Exp[-t],y[0]==2,y'[0]==-1},y[t],t]
