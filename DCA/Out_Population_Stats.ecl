import Business_Header, dca, strata;

// Pass file date as a parameter - to automate


// DCA As business header stats (STRATA)

export Out_Population_Stats(string pversion) :=
module

	strata.createAsBusinessHeaderStats(
			 DCA.fDCA_as_Business_Header(File_DCA_all_In),
		   'DCA', 
		   'Data', 
		   pversion, 
		   'lbentley@seisint.com', 
		   pOut
		  );

	export bh_out := pOut;
	
	// DCA as business contacts stats (STRATA)
	
	export Business_Contact(pversion, pOut) :=
	macro
		
		pOut := Business_Header.fAsBusinessContactStats(
			 DCA.fDCA_as_Business_Contact(File_DCA_all_In)
			,'DC'
			,DCA.version
		);

	endmacro;

	Business_Contact(qa, BC);

	export All :=
	parallel(
		 bh_out
		,Strata_Population_Stats(pversion)
//		,BC
	);

	
end;