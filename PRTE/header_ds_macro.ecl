export header_ds_macro(projname,exp1='\'\'',exp2='\'\'',exp3='\'\'',exp4='\'\'',inlayout,inds,outds) := macro
inlayout projname(inds l) := transform
	#EXPAND(exp1)
	#EXPAND(exp2)
	#EXPAND(exp3)
	#EXPAND(exp4)
	self := l;
	self := [];
end;
outds := project(inds,projname(left));
endmacro;