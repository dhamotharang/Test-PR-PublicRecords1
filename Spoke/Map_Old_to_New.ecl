export Map_Old_To_New(

	dataset(layouts_old.base)	pOldBase = Files().BaseOLD.qa

) :=
function

	layouts.base tOld2New(layouts_old.base l) :=
	transform
	
		self := l;
	
	end;

	dNewBase := project(pOldBase, tOld2New(left));
	
	return dNewBase;

end;