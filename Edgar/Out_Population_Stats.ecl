import Business_Header;
export Out_Population_Stats :=
module


	export Business_Headers(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessHeaderStats(
			Edgar.fEdgar_As_Business_Header(File_Edgar_Company_Base)
			,'E'
			,Version_Edgar_Company
		);
	endmacro;

	export Business_Contact(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessContactStats(
			Edgar.fEdgar_As_Business_Contact(File_Edgar_Contacts_Base)
			,'E'
			,Version_Edgar_Company
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



