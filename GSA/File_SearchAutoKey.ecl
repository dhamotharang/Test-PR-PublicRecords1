export File_SearchAutoKey := function

	// base := GSA.File_GSA_Base;
	
	// akrec := record,maxlength(10000)
		// base;
		// string1		blank 	:= '';
		// unsigned6	zero 	:= 0;
		// end;
		
	// akds := project(base,akrec);
	
	// return akds;
	
	base := GSA.File_GSA_Base;
	
	gsa.Layouts_GSA.layout_AutoKeys bldKeys(base input) := transform
		self := input;
		end;
		
	akds := project(base,bldKeys(left));
	
	return akds;
	
end;	