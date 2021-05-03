IMPORT Vendor_Src, ut, address, lib_stringlib, STD,Orbit3SOA;

EXPORT StandardizeInputFile(STRING filedate, BOOLEAN pUseProd = FALSE) := MODULE

// Function clean_address
	SHARED invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];
  SHARED BlankAddress			:= ['DS','DE','LA','BA','LP','L2','PL'];
	SHARED SpecialNameChars	:= ['#','*','@','!'];
	
	EXPORT Clean_Addr(DATASET(layouts.MergedSrc_Base) NewOldFormatFile) := FUNCTION


	Vendor_Src.layouts.MergedSrc_Base cleanAddr(NewOldFormatFile L) := TRANSFORM


	  Clean_Address 						:= if(l.source_code NOT IN BlankAddress, address.CleanAddress182(l.prepped_addr1, l.prepped_addr2),'');														
		STRING28  v_prim_name 		:= if(l.source_code NOT IN BlankAddress, Clean_Address[13..40], '');
		STRING5   v_zip       		:= if(l.source_code NOT IN BlankAddress, Clean_Address[117..121], '');
		STRING4   v_zip4      		:= if(l.source_code NOT IN BlankAddress, Clean_Address[122..125], '');
		SELF.prim_range 		 			:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 1..  10], '');
		SELF.predir      					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 11.. 12], '');
		SELF.prim_name   					:= if(l.source_code NOT IN BlankAddress, IF(TRIM(v_prim_name) IN invalid_prim_name,'',v_prim_name), '');
		SELF.addr_suffix 					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 41.. 44], '');
		SELF.postdir     					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 45.. 46], '');
		SELF.unit_desig  					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 47.. 56], '');
		SELF.sec_range   					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 57.. 64], '');
		SELF.p_city_name		 			:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 65.. 89], '');
		SELF.v_city_name 					:= if(l.source_code NOT IN BlankAddress, Clean_Address[ 90..114], '');
		SELF.st          					:= if(l.source_code NOT IN BlankAddress, Clean_Address[115..116], '');
		SELF.zip         					:= if(l.source_code NOT IN BlankAddress, IF(v_zip='00000','',v_zip), '');
		SELF.zip4       	 				:= if(l.source_code NOT IN BlankAddress, IF(v_zip4='0000','',v_zip4), '');
		SELF.cart        					:= if(l.source_code NOT IN BlankAddress, Clean_Address[126..129], '');
		SELF.cr_sort_sz  					:= if(l.source_code NOT IN BlankAddress, Clean_Address[130..130], '');
		SELF.lot        		 			:= if(l.source_code NOT IN BlankAddress, Clean_Address[131..134], '');
		SELF.lot_order   					:= if(l.source_code NOT IN BlankAddress, Clean_Address[135..135], '');
		SELF.dbpc        					:= if(l.source_code NOT IN BlankAddress, Clean_Address[136..137], '');
		SELF.chk_digit   					:= if(l.source_code NOT IN BlankAddress, Clean_Address[138..138], '');
		SELF.rec_type    					:= if(l.source_code NOT IN BlankAddress, Clean_Address[139..140], '');
		SELF.county      					:= if(l.source_code NOT IN BlankAddress, Clean_Address[141..145], '');
		SELF.geo_lat     					:= if(l.source_code NOT IN BlankAddress, Clean_Address[146..155], '');
		SELF.geo_long    					:= if(l.source_code NOT IN BlankAddress, Clean_Address[156..166], '');
		SELF.msa         					:= if(l.source_code NOT IN BlankAddress, Clean_Address[167..170], '');
		SELF.geo_blk     					:= if(l.source_code NOT IN BlankAddress, Clean_Address[171..177], '');
		SELF.geo_match   					:= if(l.source_code NOT IN BlankAddress, Clean_Address[178..178], '');
		SELF.err_stat    					:= if(l.source_code NOT IN BlankAddress, Clean_Address[179..182], '');
		SELF 											:= L;
	END;

CleanOldFormatFile	      := PROJECT(NewOldFormatFile, CleanAddr(LEFT));
return CleanOldFormatFile;
end;


  // NewBank
  	EXPORT Bank	:= FUNCTION
	
		Bank	:= Files(filedate,pUseProd).bankruptcy_input;  
			
	layouts.Base MapBankInput(layouts.Bank_Court L) := TRANSFORM
	
		SELF.item_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT));
		SELF.county_text          := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.county_text),LEFT, RIGHT));
		SELF.source_code					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT));
		SELF.display_name					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.description					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.status								:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.coverage_1						:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT));
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'BANKRUPTCY';
		SELF.clean_phone 					:= ut.fn_RemoveSpecialChars(IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), ''));
		SELF.prepped_addr1				:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT));
		SELF.prepped_addr2        := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT));																
		SELF											:= [];
	END;
				
		StdBank := PROJECT(Bank, MapBankInput(LEFT)); 
		CleanBankFile := clean_addr(StdBank); 
		RETURN CleanBankFile;
	END;
	
	
	// NewLien
  EXPORT Lien	:= FUNCTION
	
		Lien	:= Files(filedate,pUseProd).lien_input;  
			
	layouts.Base MapLienInput(layouts.Lien_Court L) := TRANSFORM	
	
		SELF.item_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT));
		SELF.county_text          := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.county_text),LEFT, RIGHT));
		SELF.source_code					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT));
		SELF.display_name					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.description					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.status								:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT));
		SELF.coverage_1						:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT));
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'LIENS';
		SELF.clean_phone 					:= ut.fn_RemoveSpecialChars(if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), ''));
		SELF.prepped_addr1				:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT));
		SELF.prepped_addr2        := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT));																														
		SELF 											:= L;
		SELF											:= [];
	END;

		StdLien := PROJECT(Lien, MapLienInput(LEFT)); 
		CleanLienFile := clean_addr(StdLien); 
		RETURN CleanLienFile;
	END;
	
	
	// NewRiskviews
	EXPORT OrbitFFD	:= FUNCTION
	

	
	OrbitFFD	:= Files(filedate,pUseProd).Orbit_input;  
	layouts.Base MapRiskviewFFDInput(layouts.Orbit L) := TRANSFORM 
	
		SELF.item_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.item_source_code), LEFT, RIGHT));
		SELF.source_code					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.item_source_code), LEFT, RIGHT));
		SELF.display_name					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.source_name), LEFT, RIGHT));
		SELF.description					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.item_description), LEFT, RIGHT));
		SELF.status								:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.status_name), LEFT, RIGHT));
		SELF.orbit_item_name			:= ut.fn_RemoveSpecialChars(if((l.item_source_code NOT IN BlankAddress AND l.item_name[..1] NOT IN SpecialNameChars), 
																			TRIM(Stringlib.StringToUpperCase(L.item_name), LEFT, RIGHT),
																				if((l.item_source_code NOT IN BlankAddress AND l.item_name[..1] IN SpecialNameChars),
																					TRIM(Stringlib.StringToUpperCase(L.item_name[2..]), LEFT, RIGHT), '')));
		SELF.orbit_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.source_id), LEFT, RIGHT));
		SELF.orbit_number					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.item_id), LEFT, RIGHT));
		SELF.website							:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.source_website), LEFT, RIGHT));
		SELF.market_restrict_flag	:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.market_restrict_flag), LEFT, RIGHT));
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= case(self.source_code
																		,'ALC'       => 'PROFLIC'
																		,'INFOGROUP' => 'PROFLIC'
																		,'PERSONHEADER'
																		);
		SELF.clean_phone 					:= ut.fn_RemoveSpecialChars(if(l.item_source_code NOT IN BlankAddress, if(ut.CleanPhone(L.source_phone) [1] not in ['0','1'],ut.CleanPhone(L.source_phone), ''),''));
		SELF.prepped_addr1				:= ut.fn_RemoveSpecialChars(if(l.item_source_code NOT IN BlankAddress, TRIM(Stringlib.StringToUpperCase(L.source_address1) + 
																 IF(L.item_source_code <> '', ' ' + Stringlib.StringToUpperCase(L.source_address2), ''), LEFT, RIGHT),''));
		SELF.prepped_addr2        := ut.fn_RemoveSpecialChars(if(l.item_source_code NOT IN BlankAddress, TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.source_city) + IF(L.source_city <> '',',','')
																		+ ' '+ L.source_state	+ ' '+ L.source_zip), LEFT, RIGHT), ''));

		SELF 											:= L;
		SELF											:= [];
	END;
	
	CleanOrbitFile	:= PROJECT(OrbitFFD, MapRiskviewFFDInput(LEFT));
	
	
	//Clean RiskView
	layouts.Base	FixDesc(CleanOrbitFile L)	:= TRANSFORM
	
			SELF.display_name			:= CASE(L.source_code, 'PL' => 'SEE PROFESSIONAL LICENSE RECORDS BELOW',
															                     'DS' => 'SEE SSN RECORDS',
															                     'DE' => 'SEE SSN RECORDS',
															                     'LA' => 'SEE ASSESSOR RECORDS BELOW',
															                     'BA' => 'SEE BANKRUPTCY RECORDS BELOW',
															                     'LP' => 'SEE DEED RECORDS BELOW',
															                     'L2' => 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW', L.display_name);
																									 
	     SELF.description		 := CASE(L.source_code,  'PL'=>  'SEE PROFESSIONAL LICENSE RECORDS BELOW',
																                   'DS' => 'SEE SSN RECORDS',
																	                 'DE' => 'SEE SSN RECORDS',
																		               'LA' => 'SEE ASSESSOR RECORDS BELOW',
																			             'BA' => 'SEE BANKRUPTCY RECORDS BELOW',
																				           'LP' => 'SEE DEED RECORDS BELOW',
																					         'L2' => 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW', 
																									 L.description);
		SELF:= L;
	END;
		
	FixedOrbitFile	:= PROJECT(CleanOrbitFile, FixDesc(LEFT));
	CleanFixedRiskViewFile := clean_addr(FixedOrbitFile); 
	RETURN CleanFixedRiskViewFile;
	END;
  
	
	// MVR Court Locator File
	  EXPORT CourtLocator		:= FUNCTION
	
		CourtLocator	:= Files(filedate,pUseProd).courtlocator_input;  
			
	  layouts.Base MapCourtLocatorInput(layouts.Court_Locator	 L) := TRANSFORM	
	
		SELF.item_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT));
		SELF.source_code					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT));
		SELF.display_name					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT));
		SELF.description					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT));
		SELF.status								:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT));
		SELF.coverage_1						:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.StateOfService), LEFT, RIGHT));
		SELF.coverage_2						:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.CountyOfService), LEFT, RIGHT));
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= 'MVRCOURT';
		SELF.clean_phone 					:= ut.fn_RemoveSpecialChars(IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), ''));
    SELF.prepped_addr1				:= STD.STR.CleanSpaces(ut.fn_RemoveSpecialChars(STD.Str.ToUpperCase(L.address1))+' '+ut.fn_RemoveSpecialChars(STD.Str.ToUpperCase(L.address2)));
		SELF.prepped_addr2        := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT));
		SELF 											:= L;
		SELF											:= [];
	END;
	
	StdCourt_Locator := PROJECT(CourtLocator, MapCourtLocatorInput(LEFT)); 
		CleanCourt_LocatorFile := clean_addr(StdCourt_Locator); 
		RETURN CleanCourt_LocatorFile;
	END;


	

// ***** Master List
  EXPORT MasterList		:= FUNCTION
	
		MasterList	:= Files(filedate,pUseProd).masterlist_input;  
			
	  layouts.Base MapMasterListInput(layouts.MasterList L) := TRANSFORM	
		

		SELF.item_source					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT));
		SELF.source_code					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT));
		SELF.display_name					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT));
		SELF.description					:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT));
		SELF.status								:= '';
		SELF.coverage_1						:= '';
		SELF.coverage_2						:= '';
		SELF.date_added						:= filedate[..8];
		SELF.input_file_id				:= l.LNfileCategory;
		SELF.clean_phone 					:= ut.fn_RemoveSpecialChars(IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), ''));
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(ut.fn_RemoveSpecialChars(STD.Str.ToUpperCase(L.address1))+' '+ut.fn_RemoveSpecialChars(STD.Str.ToUpperCase(L.address2)));
		SELF.prepped_addr2        := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT));
		SELF 											:= L;
		SELF											:= [];
	END;
    StdMasterList := PROJECT(MasterList(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), MapMasterListInput(LEFT)); 
		MasterListCleanAddr := clean_addr(StdMasterList); 
		RETURN MasterListCleanAddr;
	END;
	
	
		// Function College Locator  Input
	
	EXPORT CollegeLocator	:= FUNCTION
	
		CollegeLocator	:= Files(filedate,pUseProd).CollegeLocator_input  ;  
		
		layouts.Base MapCollegeLocatorInput(layouts.College_Locator L) := TRANSFORM
		
    SELF.item_source					    := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT));
		SELF.source_code					    := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT));
		SELF.display_name					    := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT));
		SELF.description				    	:= ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT));
		SELF.status								    := '';
		SELF.coverage_1					    	:= '';
		SELF.coverage_2						    := '';
		SELF.date_added						    := filedate[..8];
		SELF.input_file_id				    := l.LNfileCategory;
		SELF.clean_phone 					    := ut.fn_RemoveSpecialChars(IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), ''));
		SELF.prepped_addr1			    	:= ut.fn_RemoveSpecialChars(STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1) +' '+ IF(L.address2<>'NULL',STD.Str.ToUpperCase(L.address2),'')));
		SELF.prepped_addr2            := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT));
		SELF.NSCHEnrollVerify         := ut.fn_RemoveSpecialChars(TRIM(IF(L.NSCHEnrollVerify<>'NULL',STD.Str.ToUpperCase(L.NSCHEnrollVerify),''),LEFT, RIGHT));
		SELF.NSCHDegreeVerify         := ut.fn_RemoveSpecialChars(TRIM(IF(L.NSCHDegreeVerify<>'NULL',STD.Str.ToUpperCase(L.NSCHDegreeVerify),''),LEFT, RIGHT));
		SELF.PhoneVerify              := ut.fn_RemoveSpecialChars(TRIM(IF(L.PhoneVerify<>'NULL',STD.Str.ToUpperCase(L.PhoneVerify),''),LEFT, RIGHT)); 
		// SELF.OnlineDirectoryAvailable := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.OnlineDirectoryAvailable),LEFT, RIGHT));
		// SELF.OnlineDirectoryWebsite   := ut.fn_RemoveSpecialChars(TRIM(Stringlib.StringToUpperCase(L.OnlineDirectoryWebsite),LEFT, RIGHT));
		SELF.ContactName              := ut.fn_RemoveSpecialChars(TRIM(IF(L.ContactName<>'NULL',STD.Str.ToUpperCase(L.ContactName),''),LEFT, RIGHT));
		SELF.ContactPhone             := ut.fn_RemoveSpecialChars(TRIM(IF(L.ContactPhone<>'NULL',STD.Str.ToUpperCase(L.ContactPhone),''),LEFT, RIGHT));  
		SELF										     	:= [];
	END;
	
		StdCollegeLocator := PROJECT(CollegeLocator(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), MapCollegeLocatorInput(LEFT)); 
		CollegeLocatorCleanAddr := clean_addr(StdCollegeLocator);
		
		RETURN CollegeLocatorCleanAddr;
	END;
	
	
 EXPORT Orbit := FUNCTION

soapReturn := soapcall(
		Orbit3SOA.EnvironmentVariables.serviceurlprod,
		'GetDataViewData',
		layouts.rRequestCapsule,
		dataset(layouts.Orbit),
		xpath('GetDataViewDataResponse/GetDataViewDataResult/Result/RecordResponseGetDataViewData/Result/DataRows/DataRow/RowData'),//Result/RecordResponseGetDataViewData/Result/DataRows/DataRow/RowData'),
		namespace(Orbit3SOA.EnvironmentVariables.namespace),
		literal,
		soapaction(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'GetDataViewData')
		);
				
p:= project(soapReturn, Vendor_Src.layouts.Orbit)(item_source_code<>'');

RETURN p;
END;
END;

