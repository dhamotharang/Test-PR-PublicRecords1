import Business_Header, corp, strata;

export Out_Population_Stats :=
module

	export Business_Headers(pversion, pOut) :=
	macro
		strata.createAsBusinessHeaderStats(
			 Corp.fCorp_As_Business_Header(File_Corp_Base(Filters.As_Business.Corp_Base)),
		   'Corporations', 
		   'Data', 
		   Corp.Corp_Build_Date, 
		   'lbentley@seisint.com', 
		   pOut
		  );

		
	endmacro;
	Business_Headers(qa, BH);

	export bh_out := bh;
	
	export Business_Contact(pversion, pOut) :=
	macro
		
		pOut := Business_Header.fAsBusinessContactStats(
			 Corp.fCorp_As_Business_Contact(File_Corp_Base(Filters.As_Business.Corp_Base), File_Corp_Cont_Base(Filters.As_Business.Corp_Cont))
			,'C'
			,Corp.Corp_Build_Date
		);

	endmacro;

	Business_Contact(qa, BC);

	export All :=
	parallel(
		bh_out
//		,BC
	);

	
end;