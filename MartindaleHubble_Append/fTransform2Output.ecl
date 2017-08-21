export fTransform2Output(

	dataset(layouts.Out_allfields) pDataset

) :=
function

	layouts.out t2OutputLayout(layouts.Out_allfields l):=
	transform
	
		self := l;
	
	end;

	return project(pDataset, t2OutputLayout(left));

end;