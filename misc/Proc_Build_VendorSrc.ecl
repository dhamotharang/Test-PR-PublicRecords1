IMPORT misc, ut, address, lib_stringlib, STD;

EXPORT Proc_Build_VendorSrc(STRING pVersion) := FUNCTION

	OldData							:= Misc.Files_VendorSrc(pVersion).OldData;
	PrevBase						:= Misc.Files_VendorSrc(pVersion).Combined_Base;
	NewBank							:= Misc.Files_VendorSrc(pVersion).Bankruptcy;
	NewLien							:= Misc.Files_VendorSrc(pVersion).Lien;
	NewRiskview					:= Misc.Files_VendorSrc(pVersion).RiskviewFFD;
	OldVendorSrc				:= Misc.Files_VendorSrc(pVersion).OldVendorSrc;
	Market_Restrict			:= Misc.Files_VendorSrc(pVersion).Market_restrict;
	Court_Locations 		:= Misc.Files_VendorSrc('').Court_Locations;
	MasterList      		:= Misc.Files_VendorSrc('').MasterList;
	CollegeLocator     		:= Misc.Files_VendorSrc('').CollegeLocator;

	invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];
			
	Layout_VendorSrc.MergedSrc_Base CleanAddr(NewBank L) := TRANSFORM
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
		SELF.date_added						:= pVersion[..8];
		SELF.input_file_id				:= 'BANKRUPTCY';
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT);
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT);
		Clean_Address 						:= address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2);														
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
		SELF											:= [];
	END;

	CleanBankFile	:= PROJECT(NewBank, CleanAddr(LEFT));
	
	Layout_VendorSrc.MergedSrc_Base CleanAddr2(NewLien L) := TRANSFORM
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.court_code), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.court_name), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
		SELF.date_added						:= pVersion[..8];
		SELF.input_file_id				:= 'LIENS';
		SELF.clean_phone 					:= if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= TRIM(Stringlib.StringToUpperCase(L.address1) + IF(L.address2 <> '', ' ' + Stringlib.StringToUpperCase(L.address2), ''), LEFT, RIGHT);
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.zip), LEFT, RIGHT);
		Clean_Address 						:= address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2);														
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
		SELF											:= [];
	END;

	CleanLienFile	:= PROJECT(NewLien, CleanAddr2(LEFT));
	
	BlankAddress			:= ['DS','DE','LA','BA','LP','L2','PL'];
	SpecialNameChars	:= ['#','*','@','!'];
	
	Layout_VendorSrc.MergedSrc_Base CleanAddr3(NewRiskview L) := TRANSFORM, SKIP (L.item_source_code = '')
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
		SELF.market_restrict_flag	:= TRIM(Stringlib.StringToUpperCase(L.market_restrict_flag), LEFT, RIGHT);
		SELF.date_added						:= pVersion[..8];
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
		SELF.prim_name   					:= if(l.item_source_code NOT IN BlankAddress, IF(TRIM(v_prim_name) IN invalid_prim_name,'',v_prim_name), '');
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
	
	CleanRiskViewFile	:= PROJECT(NewRiskview, CleanAddr3(LEFT));
	
	Layout_VendorSrc.MergedSrc_Base	FixDesc(CleanRiskViewFile L)	:= TRANSFORM
		SELF.display_name			:= IF(L.source_code = 'PL', 'SEE PROFESSIONAL LICENSE RECORDS BELOW',
																IF(L.source_code = 'DS', 'SEE SSN RECORDS',
																	IF(L.source_code = 'DE', 'SEE SSN RECORDS',
																		IF(L.source_code = 'LA', 'SEE ASSESSOR RECORDS BELOW',
																			IF(L.source_code = 'BA', 'SEE BANKRUPTCY RECORDS BELOW',
																				IF(L.source_code = 'LP', 'SEE DEED RECORDS BELOW',
																					IF(L.source_code = 'L2', 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW', L.display_name)))))));
		SELF.description			:= IF(L.source_code = 'PL', 'SEE PROFESSIONAL LICENSE RECORDS BELOW',
																IF(L.source_code = 'DS', 'SEE SSN RECORDS',
																	// IF(L.source_code = 'DE', 'SEE SSN RECORDS',
																		// IF(L.source_code = 'LA', 'SEE ASSESSOR RECORDS BELOW',
																			// IF(L.source_code = 'BA', 'SEE BANKRUPTCY RECORDS BELOW',
																				// IF(L.source_code = 'LP', 'SEE DEED RECORDS BELOW',
																					// IF(L.source_code = 'L2', 'SEE LAWSUITS, CIVIL FILINGS, JUDGMENTS AND LIEN RECORDS BELOW',
																					L.description));
		SELF									:= L;
	END;
		
	FixedRiskViewFile	:= PROJECT(CleanRiskViewFile, FixDesc(LEFT));
	
	Layout_VendorSrc.MergedSrc_Base ReadAdd(OldVendorSrc L)	:= TRANSFORM
		SELF.item_source			:=	TRIM(Stringlib.StringToUpperCase(L.item_source),LEFT,RIGHT);	
		SELF.source_code			:=	TRIM(Stringlib.StringToUpperCase(L.source_code),LEFT,RIGHT);				
		SELF.display_name			:=	TRIM(Stringlib.StringToUpperCase(L.display_name),LEFT,RIGHT);						
		SELF.description			:=	TRIM(Stringlib.StringToUpperCase(L.description),LEFT,RIGHT);
		SELF.status						:=	TRIM(Stringlib.StringToUpperCase(L.status),LEFT,RIGHT);							
		SELF.data_notes				:=	TRIM(Stringlib.StringToUpperCase(L.data_notes),LEFT,RIGHT);			
		SELF.coverage_1				:=	TRIM(Stringlib.StringToUpperCase(L.coverage_1),LEFT,RIGHT);	
		SELF.coverage_2				:=	TRIM(Stringlib.StringToUpperCase(L.coverage_2),LEFT,RIGHT);		
		SELF.orbit_item_name	:=	TRIM(Stringlib.StringToUpperCase(L.orbit_item_name),LEFT,RIGHT);
		SELF.orbit_source			:=	TRIM(Stringlib.StringToUpperCase(L.orbit_source),LEFT,RIGHT);				
		SELF.orbit_number			:=	TRIM(Stringlib.StringToUpperCase(L.orbit_number),LEFT,RIGHT);		
		SELF.website					:=	TRIM(Stringlib.StringToUpperCase(L.website),LEFT,RIGHT);							
		SELF.notes						:=	TRIM(Stringlib.StringToUpperCase(L.notes),LEFT,RIGHT);					
		SELF.date_added				:=	pVersion[..8];				
		SELF.input_file_id		:=	TRIM(Stringlib.StringToUpperCase(L.input_file_id),LEFT,RIGHT);						
		SELF.clean_phone			:=	ut.CleanPhone(L.clean_phone);							
		SELF.clean_fax				:=	ut.CleanPhone(L.clean_fax);					
		SELF.Prepped_addr1		:=	TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.Prepped_addr1)), LEFT,RIGHT);
		SELF.Prepped_addr2		:=	TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.Prepped_addr2)), LEFT,RIGHT);
		SELF									:=	L;
		SELF									:=	[];
	END;
	
	NewOldFormatFile	:= PROJECT(OldVendorSrc, ReadAdd(LEFT));
		
	Layout_VendorSrc.MergedSrc_Base CleanAddr4(NewOldFormatFile L) := TRANSFORM
		Clean_Address := address.CleanAddress182(L.Prepped_addr1,L.Prepped_addr2);
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
	
	// MVR Court Locator File
	Misc.Layout_VendorSrc.MergedSrc_Base CleanCourtAddr(Misc.Layout_VendorSrc.Court_Locator L) := TRANSFORM
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.CourtID), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.CourtName), LEFT, RIGHT);
		SELF.coverage_1						:= TRIM(Stringlib.StringToUpperCase(L.StateOfService), LEFT, RIGHT);
		SELF.coverage_2						:= TRIM(Stringlib.StringToUpperCase(L.CountyOfService), LEFT, RIGHT);
		SELF.date_added						:= pVersion[..8];
		SELF.input_file_id				:= 'MVRCOURT';
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		Clean_Address 						:= address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2);														
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
		SELF											:= [];
	END;
	CleanCourt_LocationsFile	:= PROJECT(Court_Locations, CleanCourtAddr(LEFT));

	CleanOldFormatFile	:= PROJECT(NewOldFormatFile, CleanAddr4(LEFT));
		
	CleanOldFormat_w_flag := JOIN(sort(distribute(CleanOldFormatFile,hash(source_code)),source_code, local), Market_Restrict,
										LEFT.source_code=RIGHT.source_code,
										transform(Misc.Layout_VendorSrc.MergedSrc_Base, 
												SELF.market_restrict_flag	:= RIGHT.marketingrestricted,
												SELF				:= LEFT),
												LEFT OUTER, LOOKUP);

	temp_layout	:= RECORD										// only needed temporarily to treat the base as an update, not a full refresh - intention is to be a full refresh at some point
		Misc.Layout_VendorSrc.MergedSrc_Base;	// but for the interim, we need to treat as an update to make sure that data that currently exists in the old base file
		STRING	record_type;									// does not get lost.
	END;

	HistOldData	:= project ((OldData + PrevBase(input_file_id not in ['PROFLIC','MARI'])),
														transform({temp_layout},
															SELF.record_type := 'H',
															SELF	:= LEFT));
															
// ***** CRIM SOURCES

	Misc.Layout_VendorSrc.MergedSrc_Base CleanCrimSources(misc.Files_VendorSrc('').dsCrimSources L) := TRANSFORM
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.vendor), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.source_file), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.fullname), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.fullname), LEFT, RIGHT);
		SELF.status								:= TRIM(Stringlib.StringToUpperCase(L.fullname), LEFT, RIGHT);
		SELF.coverage_1						:= '';
		SELF.coverage_2						:= '';
		SELF.date_added						:= pVersion[..8];
		SELF.input_file_id				:= 'CRIMSOURCES';
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.clean_fax						:= IF(ut.CleanPhone(L.fax) [1] NOT IN ['0','1'],ut.CleanPhone(L.fax), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		Clean_Address 						:= address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2);														
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
		SELF											:= [];
	END;

	CrimSourceData := PROJECT(misc.Files_VendorSrc('').dsCrimSources, CleanCrimSources(LEFT));

// ******
// ***** Master List

	Misc.Layout_VendorSrc.MergedSrc_Base CleanMasterList(MasterList L) := TRANSFORM
		SELF.item_source					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.source_code					:= TRIM(Stringlib.StringToUpperCase(L.LNsourcetCode), LEFT, RIGHT);
		SELF.display_name					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.description					:= TRIM(Stringlib.StringToUpperCase(L.vendorName), LEFT, RIGHT);
		SELF.status								:= '';
		SELF.coverage_1						:= '';
		SELF.coverage_2						:= '';
		SELF.date_added						:= pVersion[..8];
		SELF.input_file_id				:= l.LNfileCategory;
		SELF.clean_phone 					:= IF(ut.CleanPhone(L.phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.phone), '') ;
		SELF.prepped_addr1				:= STD.STR.CleanSpaces(STD.Str.ToUpperCase(L.address1)+' '+STD.Str.ToUpperCase(L.address2));
		SELF.prepped_addr2        := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.city) + IF(L.city <> '',',','')
																		+ ' '+ L.state	+ ' '+ L.ZipCode), LEFT, RIGHT);
		Clean_Address 						:= address.CleanAddress182(SELF.prepped_addr1, SELF.prepped_addr2);														
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
		SELF											:= [];
	END;

	pMasterList := PROJECT(MasterList(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), CleanMasterList(LEFT));
	pCollegeLocator := PROJECT(CollegeLocator(LNfileCategory<>'',LNsourcetCode<>'',vendorName<>'',address1<>'',city<>'',state<>'',zipcode<>''), CleanMasterList(LEFT));

// ******
	
	NewBaseData	:= CleanBankFile + CleanLienFile + FixedRiskViewFile + CleanOldFormat_w_flag 
										+ CleanCourt_LocationsFile + CrimSourceData + pMasterList
										+ pCollegeLocator;
	
	MarkCurrent	:= project (NewBaseData,
														transform({temp_layout},
															SELF.record_type	:= 'C',
															SELF	:= LEFT));
															
	OldAndNew	:= HistOldData + MarkCurrent;
	
		string75 filterThisOut := 'DENOTES DATA THAT IS SO OLD, NO SOURCE IS KNOWN';

	SortOldAndNew := SORT(distribute(OldAndNew(source_code<>filterThisOut), hash(item_source, source_code)),item_source, source_code,input_file_id,LOCAL);
										
	temp_layout t_rollup (SortOldAndNew L, SortOldAndNew R) := TRANSFORM
			SELF						 							:= IF(L.record_type = 'C', L, R);
	END;

	RolledBase := ROLLUP(SortOldAndNew,
										left.item_source	=	right.item_source and
										left.source_code	=	right.source_code and
										left.input_file_id=	right.input_file_id,
										t_rollup(LEFT,RIGHT),LOCAL);	

	// DedupBase			:=dedup(distribute(SortOldAndNew, hash(item_source, source_code)), item_source, source_code, all, local);
	
	NewBaseFile   :=project(RolledBase
													,transform({NewBaseData}
															,SELF.item_source:=if(left.item_source='','VENDOR',left.item_source)
															,SELF:=LEFT));


	RETURN NewBaseFile;
END; 