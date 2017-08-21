import Business_Header, atf;

export Out_Population_Stats(string filedate) :=
module

	export Business_Headers(pversion, pOut) :=
	macro
		
		pOut := Business_Header.fAsBusinessHeaderStats(
			 ATF.fATF_as_Business_Header(atf.file_firearms_explosives_base_Bid)
			,'ATF'
			,filedate
		);

	endmacro;

	export Business_Contact(pversion, pOut) :=
	macro
		
		pOut := Business_Header.fAsBusinessContactStats(
			 ATF.fATF_as_Business_Contact(atf.file_firearms_explosives_base_Bid)
			,'ATF'
			,filedate
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