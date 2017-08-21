export Update_Company(

	 dataset(Layouts.Base.AID			)	pBaseFile

) :=
function

	dSplitit		:= Split_Base(pBaseFile).Companies;
	
	return dSplitit;

end;