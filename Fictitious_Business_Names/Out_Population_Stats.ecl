import Business_Header, ut, fbn_new, Fictitious_Business_Names;

export Out_Population_Stats(STRING pversion = ut.GetDate) :=
module


	export Business_Headers(pfileversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessHeaderStats(
			Fictitious_Business_Names.fFBN_as_Business_Header(FBN_new.File_FBN_update)
			,'IF'
			,pversion
		);
	endmacro;

	export Business_Contact(pfileversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessContactStats(
			Fictitious_Business_Names.fFBN_as_Business_Contact(FBN_new.File_FBN_update)
			,'IF'
			,pversion
		);
	endmacro;

	Business_Headers(qa, BH);
	Business_Contact(qa, BC);

	export All :=
	parallel(
		 BH
		,BC
	);



end;



