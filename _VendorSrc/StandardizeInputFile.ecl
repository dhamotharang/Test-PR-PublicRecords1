IMPORT misc, ut, address, lib_stringlib, STD;
EXPORT StandardizeInputFile (STRING filedate, BOOLEAN pUseProd = FALSE):= MODULE

// Function clean_address

	EXPORT Clean_Addr(DATASET(layouts.Base) pFile) := FUNCTION
	
	invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

	_VendorSrc.layouts.Base cleanAddr (pFile L) := TRANSFORM
	
		Clean_Address 						:= address.CleanAddress182(l.prepped_addr1, l.prepped_addr2);														
		STRING28  v_prim_name 		:= Clean_Address[13..40];
		STRING5   v_zip       		:= Clean_Address[117..121];
		STRING4   v_zip4      		:= Clean_Address[122..125];
		SELF.prim_range 		 			:= Clean_Address[ 1..  10];
		SELF.predir      					:= Clean_Address[ 11.. 12];
		SELF.prim_name   					:= IF(TRIM(v_prim_name) IN invalid_prim_name,'',v_prim_name);
		SELF.addr_suffix 					:= Clean_Address[ 41.. 44];
		SELF.postdir     					:= Clean_Address[ 45.. 46];
		SELF.unit_desig  					:= Clean_Address[ 47.. 56];
		SELF.sec_range   					:= Clean_Address[ 57.. 64];
		SELF.p_city_name		 			:= Clean_Address[ 65.. 89];
		SELF.v_city_name 					:= Clean_Address[ 90..114];
		SELF.st          					:= Clean_Address[115..116];
		SELF.zip         					:= IF(v_zip='00000','',v_zip);
		SELF.zip4       	 				:= IF(v_zip4='0000','',v_zip4);
		SELF.cart        					:= Clean_Address[126..129];
		SELF.cr_sort_sz  					:= Clean_Address[130..130];
		SELF.lot        		 			:= Clean_Address[131..134];
		SELF.lot_order   					:= Clean_Address[135..135];
		SELF.dbpc        					:= Clean_Address[136..137];
		SELF.chk_digit   					:= Clean_Address[138..138];
		SELF.rec_type    					:= Clean_Address[139..140];
		SELF.county      					:= Clean_Address[141..145];
		SELF.geo_lat     					:= Clean_Address[146..155];
		SELF.geo_long    					:= Clean_Address[156..166];
		SELF.msa         					:= Clean_Address[167..170];
		SELF.geo_blk     					:= Clean_Address[171..177];
		SELF.geo_match   					:= Clean_Address[178..178];
		SELF.err_stat    					:= Clean_Address[179..182];
		SELF 											:= L;
	END;

return project (pFile,CleanAddr(left));
end;


// Function BankInput

	EXPORT BankInput	:= FUNCTION
	
		BankInput	:= Files(filedate,pUseProd).Bank_Court_input;  
		
		_VendorSrc.layouts.Base MapBankInput(layouts.Bank_Court_input L) := TRANSFORM
		
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'BANKRUPTCY';
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT);
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT);
		SELF											:= [];
	END;
				
		StdBank := PROJECT(BankInput, MapBankInput(LEFT)); 
		BankInputCleanAddr := clean_addr(StdBank); 
		RETURN BankInputCleanAddr;
	END;
	
	
	// Function Lien  Input
	
	EXPORT LienInput	:= FUNCTION
	
		LienInput	:= Files(filedate,pUseProd).Lien_Court_input;  
		
		_VendorSrc.layouts.Base MapLienInput(layouts.Lien_Court_input L) := TRANSFORM
		
    SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'LIENS';
		SELF.clean_phone 					:= if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT);
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT);
		SELF											:= [];
	END;
				
		StdLien := PROJECT(LienInput, MapLienInput(LEFT)); 
		LienInputCleanAddr := clean_addr(StdLien); 
		RETURN LienInputCleanAddr;
	END;
	
	
	
// Function Riskview  Input

		EXPORT RiskviewFFDInput	:= FUNCTION
	
	BlankAddress			:= ['DS','DE','LA','BA','LP','L2','PL'];
	SpecialNameChars	:= ['#','*','@','!'];
	
		RiskviewFFDInput	:= Files(filedate,pUseProd).Riskview_FFD_input;  
		
		_VendorSrc.layouts.Base MapRiskviewFDDInput(layouts.Riskview_FFD_input L) := TRANSFORM
		
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.item_source_code), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.item_source_code), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.source_name), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.item_description), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.status_name), LEFT, RIGHT);
		SELF.orbit_item_name			:= if((l.item_source_code NOT IN BlankAddress AND l.item_name[..1] NOT IN SpecialNameChars), 
																			TRIM(Stringlib.StringToUpperCase(L.item_name), LEFT, RIGHT),
																				if((l.item_source_code NOT IN BlankAddress AND l.item_name[..1] IN SpecialNameChars),
																					TRIM(Stringlib.StringToUpperCase(L.item_name[2..]), LEFT, RIGHT), ''));
		SELF.orbit_source					:= TRIM(Stringlib.StringToUpperCase(L.source_id), LEFT, RIGHT);
		SELF.orbit_number					:= TRIM(Stringlib.StringToUpperCase(L.item_id), LEFT, RIGHT);
		SELF.website							:= TRIM(Stringlib.StringToUpperCase(L.source_website), LEFT, RIGHT);
		//SELF.market_restrict_flag	:= TRIM(Stringlib.StringToUpperCase(L.market_restrict_flag), LEFT, RIGHT);
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= case(self.source_code
																		,'ALC'       => 'PROFLIC'
																		,'INFOGROUP' => 'PROFLIC'
																		,'PERSONHEADER'
																		);
		SELF.clean_phone 					:= if(l.item_source_code NOT IN BlankAddress, if(ut.CleanPhone(L.source_phone) [1] not in ['0','1'],ut.CleanPhone(L.source_phone), ''),'') ;
		SELF.prepped_addr1				:= if(l.item_source_code NOT IN BlankAddress, TRIM(Stringlib.StringToUpperCase(L.source_address1) + 
																 IF(L.source_address2 <> '', ' ' + Stringlib.StringToUpperCase(L.source_address2), ''), LEFT, RIGHT),'');
		SELF.prepped_addr2        := if(l.item_source_code NOT IN BlankAddress, TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.source_city) + IF(L.source_city <> '',',','')
																		+ ' '+ L.source_state	+ ' '+ L.source_zip), LEFT, RIGHT), '');
		Clean_Address 						:= if(l.item_source_code NOT IN BlankAddress, address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2), '');														
		STRING28  v_prim_name 		:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[13..40], '');
		STRING5   v_zip       		:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[117..121], '');
		STRING4   v_zip4      		:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[122..125], '');
		SELF.prim_range 		 			:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 1..  10], '');
		SELF.predir      					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 11.. 12], '');
		//SELF.prim_name   					:= if(l.item_source_code NOT IN BlankAddress, IF(TRIM(v_prim_name) IN invalid_prim_name,'',v_prim_name), '');
		SELF.addr_suffix 					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 41.. 44], '');
		SELF.postdir     					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 45.. 46], '');
		SELF.unit_desig  					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 47.. 56], '');
		SELF.sec_range   					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 57.. 64], '');
		SELF.p_city_name		 			:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 65.. 89], '');
		SELF.v_city_name 					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[ 90..114], '');
		SELF.st          					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[115..116], '');
		SELF.zip         					:= if(l.item_source_code NOT IN BlankAddress, IF(v_zip='00000','',v_zip), '');
		SELF.zip4       	 				:= if(l.item_source_code NOT IN BlankAddress, IF(v_zip4='0000','',v_zip4), '');
		SELF.cart        					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[126..129], '');
		SELF.cr_sort_sz  					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[130..130], '');
		SELF.lot        		 			:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[131..134], '');
		SELF.lot_order   					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[135..135], '');
		SELF.dbpc        					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[136..137], '');
		SELF.chk_digit   					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[138..138], '');
		SELF.rec_type    					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[139..140], '');
		SELF.county      					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[141..145], '');
		SELF.geo_lat     					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[146..155], '');
		SELF.geo_long    					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[156..166], '');
		SELF.msa         					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[167..170], '');
		SELF.geo_blk     					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[171..177], '');
		SELF.geo_match   					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[178..178], '');
		SELF.err_stat    					:= if(l.item_source_code NOT IN BlankAddress, Clean_Address[179..182], '');
		SELF 											:= L;
		SELF											:= [];
	END;
	
		StdRiskviewFFD := PROJECT(RiskviewFFDInput, MapRiskviewFDDInput(LEFT)); 


	//	Clean RiskView
	
	layouts.Base	FixDesc(StdRiskviewFFD L)	:= TRANSFORM
		 SELF.display_name			:= CASE(L.source_code, 'PL' => 'SEE PROFESSIONAL LICENSE RECORDS BELOW',
															                     'DS' => 'SEE SSN RECORDS',
															                     'DE' => 'SEE SSN RECORDS',
															                     'LA' => 'SEE ASSESSOR RECORDS BELOW',
															                     'BA' => 'SEE BANKRUPTCY RECORDS BELOW',
															                     'LP' => 'SEE DEED RECORDS BELOW',
															                     'L2' => 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW', L.display_name);
		// SELF.description			:= IF(L.source_code = 'PL', 'SEE PROFESSIONAL LICENSE RECORDS BELOW',
																// IF(L.source_code = 'DS', 'SEE SSN RECORDS',
																	//IF(L.source_code = 'DE', 'SEE SSN RECORDS',
																		//IF(L.source_code = 'LA', 'SEE ASSESSOR RECORDS BELOW',
																		//	IF(L.source_code = 'BA', 'SEE BANKRUPTCY RECORDS BELOW',
																		//		IF(L.source_code = 'LP', 'SEE DEED RECORDS BELOW',
																			//		IF(L.source_code = 'L2', 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW',
																					// L.description));
		 SELF									:= L;
	 END;
	 
	 
				FixedRiskViewFile	:= PROJECT(StdRiskviewFFD, FixDesc(LEFT));
				RETURN FixedRiskViewFile;
	END;



		// Function Court Locations  Input
	
	EXPORT CourtLocatorInput	:= FUNCTION
	
		CourtLocatorInput	:= Files(filedate,pUseProd).Court_Locations_input;  
		
		_VendorSrc.layouts.Base MapCourtLocatorInput(layouts.Court_Locations_input L) := TRANSFORM
		
    SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.StateOfService), LEFT, RIGHT);
		SELF.coverage_2						:= TRIM(Stringlib.StringToUpperCase(L.CountyOfService), LEFT, RIGHT);
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'MVRCOURT';
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		SELF											:= [];
	END;
				
		StdCourtLocator := PROJECT(CourtLocatorInput, MapCourtLocatorInput(LEFT)); 
		CourtLocatorInputCleanAddr := clean_addr(StdCourtLocator); 
		RETURN CourtLocatorInputCleanAddr;
	END;
	
	
	// Function Master List  Input
	
	EXPORT MasterListInput	:= FUNCTION
	
		MasterListInput	:= Files(filedate,pUseProd).Master_List_input;  
		
		_VendorSrc.layouts.Base MapMasterListInput(layouts.Master_List_input L) := TRANSFORM
		
    SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.status								:= '';
		SELF.coverage_1						:= '';
		SELF.coverage_2						:= '';
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= l.LNfileCategory;
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		SELF											:= [];
	END;
		
		StdMasterList := PROJECT(MasterListInput, MapMasterListInput(LEFT)); 
		MasterListInputCleanAddr := clean_addr(StdMasterList);
		
		RETURN MasterListInputCleanAddr;
	END;
	
	
	// Function College Locator  Input
	
	EXPORT CollegeLocatorInput	:= FUNCTION
	
		CollegeLocatorInput	:= Files(filedate,pUseProd).Master_List_input;  
		
		_VendorSrc.layouts.Base MapCollegeLocatorInput(layouts.Master_List_input L) := TRANSFORM
		
    SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.status								:= '';
		SELF.coverage_1						:= '';
		SELF.coverage_2						:= '';
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= l.LNfileCategory;
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		SELF											:= [];
	END;
		
		StdCollegeLocator := PROJECT(CollegeLocatorInput, MapCollegeLocatorInput(LEFT)); 
		CollegeLocatorInputCleanAddr := clean_addr(StdCollegeLocator);
		
		RETURN CollegeLocatorInputCleanAddr;
	END;
	
 END;