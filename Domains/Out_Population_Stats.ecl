import Business_Header, domains, strata;

export Out_Population_Stats :=
module

	export Business_Headers(pversion, pOut) :=
	macro
    whois_base := File_Whois_Base;
	
		strata.createAsBusinessHeaderStats(
			Domains.fWhois_As_Business_Header(whois_base),		   
			'Whois', 
		   'Data', 
		   Domains.Whois_Build_Date, 
		   'lbentley@seisint.com', 
		   pOut
		  );

	endmacro;

	Business_Headers(qa, BH);
	export bh_out := bh;
	
/*	export Business_Contact(pversion, pOut) :=
	macro
		
		pOut := Business_Header.fAsBusinessContactStats(
			 DCA.fDCA_as_Business_Contact(File_DCA_all_In)
			,'DC'
			,DCA.version
		);

	endmacro;

	Business_Contact(qa, BC);
*/
	export All :=
	parallel(
		 bh_out
		,Strata_Population_Stats
//		,BC
	);

	
end;