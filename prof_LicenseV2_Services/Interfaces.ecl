// export Interfaces := MODULE

	// export pt_param := INTERFACE
		// export unsigned2 pt := 20 : stored('PenaltThreshold');
	// END;

	// export do_search := INTERFACE
		// export boolean is_search := TRUE;
	// END;

	// export cnt_params := INTERFACE
		// export INTEGER5 startingRecord := 1 : STORED('starting_record');
		// export INTEGER5 returnCount := 9999 : STORED('return_count');
	// END;

	// export include := INTERFACE
		// export boolean Include_Prof_Lic := FALSE : stored('IncludeProfessionalLicenses');
		// export boolean Include_Sanc := FALSE		 : stored('IncludeSanctions');
		// export boolean Include_Prov := FALSE		 : stored('IncludeProviders');
	// END;

	// export search_params := INTERFACE(pt_param,do_search,include,cnt_params)
		// export unsigned6 	Sanc_id := 0 						 : stored('SanctionID');
		// export set of unsigned6  sanc_id_set := [] : stored('SanctionID');
		// export unsigned6  ProviderId := 0      		 : stored('ProviderID');
		// export unsigned6  prolic_seq_num := 0  		 : stored('SequenceID');
		// shared string20	  L_Number := '' 		 : stored('LicenseNumber');
		// export string20   License_Number :=  stringlib.stringtouppercase(l_number);	
		// export string20   filing_jurisdiction := '' : stored('FilingJurisdiction');
		// shared string		  bdid_val := ''					   : stored('BDID');
		// shared string14 	did_val  := ''  					 : stored('DID');
		// export unsigned6 bdid_value := (unsigned6) bdid_val;
		// export unsigned6 did_value  := (unsigned6) did_val;
	// END;
			
// END;