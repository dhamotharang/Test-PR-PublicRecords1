IMPORT IDL_Header, Advo, PRTE2_Common_DevOnly,ut,STD;

EXPORT ValidateAddress := MODULE

	// Logic copied from DriverDiscovery.ValidateAddress.
	EXPORT isApt (STRING5 inZip, STRING10 inPrim_range, STRING28 inPrim_name, STRING2 inPredir):= FUNCTION
	// Get Apartment Count
		AptBuildingFile := PRTE2_Common_DevOnly.IDLHeader_ApartmentBuildings_File;
		apt_building_recs := AptBuildingFile.key(zip = inZip AND
															prim_range  = inPrim_range  AND
															prim_name   = inPrim_name   AND 
															predir      = inPredir);
															
		validAddress := if(count(apt_building_recs) > 0 AND inPrim_range != '', true, false);
		
		// res := if(validAddress AND apt_building_recs[1].apt_cnt > 1, 'Y', 'N');
		res := if(validAddress AND apt_building_recs[1].apt_cnt > 1, 'Y', 'N');
		RETURN res;
	END;


	// Logic copied from DriverDiscovery.ValidateAddress.
	EXPORT isAptBatch (inputDS, in_zip='zip', in_prim_range='prim_range', in_prim_name='prim_name', in_predir='predir'):= FUNCTIONMACRO
	IMPORT IDL_Header;
	// Get Apartment Count
		AptBuildingFile := PRTE2_Common_DevOnly.IDLHeader_ApartmentBuildings_File;
		addHighRiseIndicator := JOIN(inputDS, AptBuildingFile.key, 
																LEFT.in_zip         = RIGHT.zip         AND
																LEFT.in_prim_range  = RIGHT.prim_range  AND
																LEFT.in_prim_name   = RIGHT.prim_name   AND 
																LEFT.in_predir      = RIGHT.predir,
																TRANSFORM( {RECORDOF(inputDS) OR {PRTE2_Common_DevOnly.Layouts.highrise_ind}},
																		SELF.highrise_ind := IF(LEFT.in_zip         = RIGHT.zip         AND
																														LEFT.in_prim_range  = RIGHT.prim_range  AND
																														LEFT.in_prim_name   = RIGHT.prim_name   AND 
																														LEFT.in_predir      = RIGHT.predir,
																														IF(LEFT.in_prim_range !='' AND RIGHT.apt_cnt >1, 'Y', 'N'),
																														'');
																		SELF := LEFT),
																KEEP(1),
																LEFT OUTER
																);
																
		RETURN addHighRiseIndicator;
	ENDMACRO;	

	EXPORT addErrorDescription (inputDS):= FUNCTIONMACRO
	IMPORT Address,ut,STD;
	removecrlfExtra(STRING S1) := FUNCTION
			S1a := ut.fn_RemoveSpecialChars(S1);
			S1b := STD.STR.FilterOut(S1a,'\n');			// don't think HPCC does /r/n anywhere?
			Return STD.STR.CleanSpaces(S1b);
	END; 
	// Get Err_stat description
		addErrorDesc := PROJECT(inputDS,
															TRANSFORM({RECORDOF(inputDS) OR {STRING ErrorDescription}},
																	SELF.errorDescription := removecrlfExtra(Address.error_codes(LEFT.err_stat)),
																	SELF := LEFT));
																
		RETURN addErrorDesc;
	ENDMACRO;		
	
	EXPORT isAptBatch2 (inputDS, in_zip='zip', in_prim_range='prim_range', in_prim_name='prim_name', in_predir='predir'):= FUNCTIONMACRO
	IMPORT IDL_Header;
	// Get Apartment Count
		addHighRiseIndicator := JOIN(inputDS, IDL_Header.ApartmentBuildings_File.key, 
																LEFT.in_zip         = RIGHT.zip         AND
																LEFT.in_prim_range  = RIGHT.prim_range  AND
																LEFT.in_prim_name   = RIGHT.prim_name   AND 
																LEFT.in_predir      = RIGHT.predir,
																TRANSFORM( {RECORDOF(inputDS)},
																		SELF.highrise_ind := IF(LEFT.in_zip         = RIGHT.zip         AND
																														LEFT.in_prim_range  = RIGHT.prim_range  AND
																														LEFT.in_prim_name   = RIGHT.prim_name   AND 
																														LEFT.in_predir      = RIGHT.predir,
																														IF(LEFT.in_prim_range !='' AND RIGHT.apt_cnt >1, 'Y', 'N'),
																														'');
																		SELF := LEFT),
																KEEP(1),
																LEFT OUTER
																);
																
		RETURN addHighRiseIndicator;
	ENDMACRO;	
	
	EXPORT isBusinessAddressBatch (inputDS, in_zip='zip', in_prim_range='prim_range', in_prim_name='prim_name', in_predir='predir') := FUNCTIONMACRO
		IMPORT Advo, ut;
		// read ADVO data from Boca Prod.
		advoAddress := DATASET([],Advo.Layouts.Layout_Common_Out_k);
		advoKey := INDEX(advoAddress, 
										{zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
										{advoAddress},
										('~thor_data400::key::advo::qa::addr_search1') ); 
		/* Code result. From Advo._README
		(Business / Residential)	
		A = Residential
		B = Business
		C = Primary Residential with Business 
		D = Primary Business with Residential "
		*/
		addBusinessIndicator := JOIN(inputDS, advoKey, 
														LEFT.in_zip         = RIGHT.zip         AND
														LEFT.in_prim_range  = RIGHT.prim_range  AND
														LEFT.in_prim_name   = RIGHT.prim_name   AND 
														LEFT.in_predir      = RIGHT.predir,
														TRANSFORM( {RECORDOF(inputDS) OR {PRTE2_Common_DevOnly.Layouts.resi_or_busi_ind}},
																		SELF.resi_or_busi_ind := RIGHT.Residential_or_Business_Ind;
																		SELF := LEFT),
																KEEP(1),
																LEFT OUTER);
	
		RETURN addBusinessIndicator;
	ENDMACRO;
	
	EXPORT isBusinessAddressBatch2 (inputDS, in_zip='zip', in_prim_range='prim_range', in_prim_name='prim_name', in_predir='predir') := FUNCTIONMACRO
		IMPORT Advo, ut;
		// read ADVO data from Boca Prod.
		advoAddress := DATASET([],Advo.Layouts.Layout_Common_Out_k);
		advoKey := INDEX(advoAddress, 
										{zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
										{advoAddress},
										Data_Services.foreign_prod_boca+'thor_data400::key::advo::qa::addr_search1'); 
		/* Code result. From Advo._README
		(Business / Residential)	
		A = Residential
		B = Business
		C = Primary Residential with Business 
		D = Primary Business with Residential "
		*/
		addBusinessIndicator := JOIN(inputDS, advoKey, 
														LEFT.in_zip         = RIGHT.zip         AND
														LEFT.in_prim_range  = RIGHT.prim_range  AND
														LEFT.in_prim_name   = RIGHT.prim_name   AND 
														LEFT.in_predir      = RIGHT.predir,
														TRANSFORM( {RECORDOF(inputDS) },
																		SELF.resi_or_busi_ind := RIGHT.Residential_or_Business_Ind;
																		SELF := LEFT),
																KEEP(1),
																LEFT OUTER);
	
		RETURN addBusinessIndicator;
	ENDMACRO;
	
END;