IMPORT ut, FCC, NID, AID, address, Std;

EXPORT proc_prebuild_clean_records(STRING filedate) := FUNCTION
// This function was created to replace the ab initio process portion of this build

  dRawFCC:= FCC.File_FCC_licenses_in;

	//*** Sequence records for joining records
	Layout_Base_Seq := record
		UNSIGNED8 seq_num 	 := 0;
    FCC.Layout_FCC_base_bip_AID
	end;

  //*** Cleaning attention person names using the NID name cleaner.
	NID.Mac_CleanFullNames(dRawFCC, dRawFCC_clean_attn_temp, licensees_attention_line);	
	dRawFCC_clean_attn := dRawFCC_clean_attn_temp;    

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Clean and add dates
	// -- Map cleaned attention name fields
	// -- Clean phone numbers
	// -- Prepare licensees and firm addresses for AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	Layout_Base_Seq tStandardizeInput(dRawFCC_clean_attn L, INTEGER c) := TRANSFORM

    l_street                                  := ut.CleanSpacesAndUpper(L.licensees_street);
    l_city                                    := ut.CleanSpacesAndUpper(L.licensees_city);
    l_state                                   := ut.CleanSpacesAndUpper(L.licensees_state);
    l_zip                                     := TRIM(L.licensees_zip,LEFT,RIGHT);
    f_street                                  := ut.CleanSpacesAndUpper(L.contact_firms_street_address);
    f_city                                    := ut.CleanSpacesAndUpper(L.contact_firms_city);
    f_state                                   := ut.CleanSpacesAndUpper(L.contact_firms_state);
    f_zip                                     := TRIM(L.contact_firms_zipcode,LEFT,RIGHT);

		SELF.seq_num                              := c;		
	  SELF.process_date                         := filedate;
		SELF.license_type                         := ut.CleanSpacesAndUpper(L.license_type);
		SELF.file_number                          := TRIM(L.file_number,LEFT,RIGHT);
		SELF.callsign_of_license                  := ut.CleanSpacesAndUpper(L.callsign_of_license);
		SELF.radio_service_code                   := ut.CleanSpacesAndUpper(L.radio_service_code);
		SELF.licensees_name                       := ut.CleanSpacesAndUpper(L.licensees_name);
		SELF.licensees_attention_line             := ut.CleanSpacesAndUpper(L.licensees_attention_line);
		SELF.DBA_name                             := ut.CleanSpacesAndUpper(L.DBA_name);
		SELF.licensees_street                     := l_street;
		SELF.licensees_city                       := l_city;
		SELF.licensees_state                      := l_state;
		SELF.licensees_zip                        := l_zip;
		SELF.licensees_phone                      := TRIM(L.licensees_phone,LEFT,RIGHT);
		SELF.type_of_last_change                  := ut.CleanSpacesAndUpper(L.type_of_last_change);
		SELF.latitude                             := TRIM(L.latitude,LEFT,RIGHT);
		SELF.longitude                            := TRIM(L.longitude,LEFT,RIGHT);
		SELF.transmitters_street                  := ut.CleanSpacesAndUpper(L.transmitters_street);
		SELF.transmitters_city                    := ut.CleanSpacesAndUpper(L.transmitters_city);
		SELF.transmitters_county                  := ut.CleanSpacesAndUpper(L.transmitters_county);
		SELF.transmitters_state                   := ut.CleanSpacesAndUpper(L.transmitters_state);
		SELF.transmitters_antenna_height          := TRIM(L.transmitters_antenna_height,LEFT,RIGHT);
		SELF.transmitters_height_above_avg_terra  := TRIM(L.transmitters_height_above_avg_terra,LEFT,RIGHT);
		SELF.transmitters_height_above_ground_le  := TRIM(L.transmitters_height_above_ground_le,LEFT,RIGHT);
		SELF.power_of_this_frequency              := TRIM(L.power_of_this_frequency,LEFT,RIGHT);
		SELF.frequency_Mhz                        := TRIM(L.frequency_Mhz,LEFT,RIGHT);
		SELF.class_of_station                     := ut.CleanSpacesAndUpper(L.class_of_station);
		SELF.number_of_units_authorized_on_freq   := TRIM(L.number_of_units_authorized_on_freq,LEFT,RIGHT);
		SELF.effective_radiated_power             := TRIM(L.effective_radiated_power,LEFT,RIGHT);
		SELF.emissions_codes                      := ut.CleanSpacesAndUpper(L.emissions_codes);
		SELF.frequency_coordination_number        := TRIM(L.frequency_coordination_number,LEFT,RIGHT);
		SELF.paging_license_status                := ut.CleanSpacesAndUpper(L.paging_license_status);
		SELF.control_point_for_the_system         := ut.CleanSpacesAndUpper(L.control_point_for_the_system);
		SELF.pending_or_granted                   := ut.CleanSpacesAndUpper(L.pending_or_granted);
		SELF.firm_preparing_application           := ut.CleanSpacesAndUpper(L.firm_preparing_application);
		SELF.contact_firms_street_address         := f_street;
		SELF.contact_firms_city                   := f_city;
		SELF.contact_firms_state                  := f_state;
		SELF.contact_firms_zipcode                := f_zip;
		SELF.contact_firms_phone_number           := TRIM(L.contact_firms_phone_number,LEFT,RIGHT);
		SELF.contact_firms_fax_number             := TRIM(L.contact_firms_fax_number,LEFT,RIGHT);
		SELF.unique_key                           := ut.CleanSpacesAndUpper(L.unique_key);
																								 //** STD.Date.ConvertDateFormat returns the string value of '-11130' for bad/empty dates, so the checking. Default date format expected is - mm/dd/yyyy
		SELF.date_application_received_at_FCC     := if(STD.Date.ConvertDateFormat(L.date_application_received_at_FCC) <> '-11130', STD.Date.ConvertDateFormat(L.date_application_received_at_FCC), '');
		SELF.date_license_issued                  := if(STD.Date.ConvertDateFormat(L.date_license_issued) <> '-11130', STD.Date.ConvertDateFormat(L.date_license_issued), '');
		SELF.date_license_expires                 := if(STD.Date.ConvertDateFormat(L.date_license_expires) <> '-11130', STD.Date.ConvertDateFormat(L.date_license_expires), '');
		SELF.date_of_last_change                  := if(STD.Date.ConvertDateFormat(L.date_of_last_change) <> '-11130', STD.Date.ConvertDateFormat(L.date_of_last_change), '');
		SELF.attention_title		         	        := L.cln_title;
		SELF.attention_fname	                    := L.cln_fname;
		SELF.attention_mname	                    := L.cln_mname;
		SELF.attention_lname		         	        := L.cln_lname;
		SELF.attention_name_suffix	              := L.cln_suffix;
		SELF.attention_name_score  	              := '';
		SELF.clean_licensees_phone                := ut.CleanPhone(L.licensees_phone);
		SELF.clean_contact_firms_phone_number     := ut.CleanPhone(L.contact_firms_phone_number);
		SELF.clean_contact_firms_fax_number       := ut.CleanPhone(L.contact_firms_fax_number);
		SELF.prep_line1_licensees			 	          := l_street;
		SELF.prep_line_last_licensees		          := address.Addr2FromComponents(l_city, l_state, l_zip[1..5]);
		SELF.prep_line1_firm     			 	          := f_street;
		SELF.prep_line_last_firm     		          := address.Addr2FromComponents(f_city, f_state, f_zip[1..5]);		
		SELF										                  := L;			
	  SELF                                      := [];
  END;
		
	dStandardizedInput := project(dRawFCC_clean_attn, tStandardizeInput(LEFT, COUNTER));

  //*** Prepare records for 
	Layout_Temp_Name := RECORD
		UNSIGNED8 seq_num         := 0;
		STRING1		record_type			:='';
    STRING50  prep_name       :='';
	END;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Normalize the names to find which ones are companies
	//////////////////////////////////////////////////////////////////////////////////////
  Layout_Temp_Name tNormInputNames(dStandardizedInput L, INTEGER CTR) := TRANSFORM
    SELF.record_type    := CHOOSE(CTR, 'L', 'D', 'F');  // 'L' Licensees name, 'D' DBA name, 'F' Firm name
		SELF.prep_name      := CHOOSE(CTR, L.licensees_name, L.DBA_name, L.firm_preparing_application);
		SELF                := L;
  END;  //End tNormInputNames

  PreppedNames := NORMALIZE(dStandardizedInput, 3, tNormInputNames(LEFT, COUNTER));	
	
  //*** Cleaning names using the NID name cleaner to find out which ones are company names
	NID.Mac_CleanFullNames(PreppedNames, dStandardizedNames_temp, prep_name);	
	dStandardizedNames := dStandardizedNames_temp;    

	// An executive decision was made to consider Unclassifed and Invalid names as company names
	business_flags := ['B', 'U', 'I'];
	
  Layout_Base_Seq tFindCompanyNames(dStandardizedNames L, dStandardizedInput R) := TRANSFORM
    SELF.clean_licensees_name  := IF(L.record_type = 'L' AND L.nametype IN business_flags, R.licensees_name,             R.clean_licensees_name);
    SELF.clean_DBA_name        := IF(L.record_type = 'D' AND L.nametype IN business_flags, R.DBA_name,                   R.clean_DBA_name);
    SELF.clean_firm_name       := IF(L.record_type = 'F' AND L.nametype IN business_flags, R.firm_preparing_application, R.clean_firm_name);
		SELF                       := R;
  END;  //End tFindCompanyNames

  dStandardizedNames_dist := DISTRIBUTE(dStandardizedNames, seq_num);
  dStandardizedInput_dist := DISTRIBUTE(dStandardizedInput, seq_num);
	
	//*** Put the company names in to the clean fields
  dCompanyNames := JOIN(dStandardizedNames_dist
										   ,dStandardizedInput_dist
										   ,LEFT.seq_num = RIGHT.seq_num
										   ,tFindCompanyNames(LEFT, RIGHT)
										   ,RIGHT OUTER
										   ,LOCAL);

  //*** Denormalize the records by rolling up the name fields
  Layout_Base_Seq tRollNames(dCompanyNames L, dCompanyNames R) := TRANSFORM
	  SELF.clean_licensees_name       := IF(L.clean_licensees_name = '',  R.clean_licensees_name,    L.clean_licensees_name);
	  SELF.clean_dba_name 	          := IF(L.clean_dba_name       = '',  R.clean_dba_name,          L.clean_dba_name);
	  SELF.clean_firm_name      	    := IF(L.clean_firm_name      = '',  R.clean_firm_name,         L.clean_firm_name);
		SELF										        := L;			
	END;
	
	names_sort := SORT(DISTRIBUTE(dCompanyNames, seq_num), seq_num, LOCAL);
 
  dCompanyNames_rolled := ROLLUP(names_sort, seq_num, tRollNames(LEFT, RIGHT), LOCAL);  													

	AID_prep_slim_layout := RECORD
	  UNSIGNED8                      seq_num 	        := 0;
		STRING1			                   record_type			:='';
	  STRING100		                   prep_line1				:='';
	  STRING50		                   prep_line_last		:='';
	  AID.Common.xAID	               RawAID	          := 0;
	  AID.Common.xAID	               ACEAID	          := 0;
	  Address.Layout_Clean182_fips;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Normalize the licensee and firm addresses
	//////////////////////////////////////////////////////////////////////////////////////
  AID_prep_slim_layout tNormInputAddrs(Layout_Base_Seq L, INTEGER CTR) := TRANSFORM
		SELF.seq_num        := L.seq_num;
	  //First time through, process licensees addresses. Second time through process firm addresses
    SELF.record_type    := CHOOSE(CTR, 'L', 'F');  // 'L' Licensees address, 'F' Firm addresses
		SELF.prep_line1     := CHOOSE(CTR, L.prep_line1_licensees,     L.prep_line1_firm);
    SELF.prep_line_last := CHOOSE(CTR, L.prep_line_last_licensees, L.prep_line_last_firm);
    SELF.RawAID         := CHOOSE(CTR, L.RawAID_licensees,         L.RawAID_firm);
		SELF                := [];
  END;  //End tNormInputAddrs

  PreppedInput := NORMALIZE(dCompanyNames_rolled, 2, tNormInputAddrs(LEFT, COUNTER));	

	//Get AID for all of the Addresses
	dWith_address			:= PreppedInput(TRIM(prep_line_last, ALL) != '');

	UNSIGNED4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
	AID.MacAppendFromRaw_2Line(dWith_address, prep_line1, prep_line_last, RawAID, dwithAID, lFlags);
	
  dAIDSlim := PROJECT(dwithAID
	  ,TRANSFORM(AID_prep_slim_layout,
				       SELF.ACEAID				  := LEFT.aidwork_acecache.aid					;
				       SELF.RawAID				  := LEFT.aidwork_rawaid								;
				       SELF.prim_range			:= LEFT.aidwork_acecache.prim_range		;
				       SELF.predir					:= LEFT.aidwork_acecache.predir				;
				       SELF.prim_name			  := LEFT.aidwork_acecache.prim_name		;
				       SELF.addr_suffix		  := LEFT.aidwork_acecache.addr_suffix	;
				       SELF.postdir					:= LEFT.aidwork_acecache.postdir			;
				       SELF.unit_desig			:= LEFT.aidwork_acecache.unit_desig		;
				       SELF.sec_range				:= LEFT.aidwork_acecache.sec_range		;
				       SELF.p_city_name			:= LEFT.aidwork_acecache.p_city_name	;
				       SELF.v_city_name			:= LEFT.aidwork_acecache.v_city_name	;
				       SELF.st							:= LEFT.aidwork_acecache.st						;
				       SELF.zip							:= LEFT.aidwork_acecache.zip5					;
				       SELF.zip4						:= LEFT.aidwork_acecache.zip4					;
				       SELF.cart						:= LEFT.aidwork_acecache.cart					;
				       SELF.cr_sort_sz			:= LEFT.aidwork_acecache.cr_sort_sz		;
				       SELF.lot							:= LEFT.aidwork_acecache.lot					;
				       SELF.lot_order				:= LEFT.aidwork_acecache.lot_order		;
				       SELF.dbpc						:= LEFT.aidwork_acecache.dbpc					;
				       SELF.chk_digit				:= LEFT.aidwork_acecache.chk_digit		;
				       SELF.rec_type				:= LEFT.aidwork_acecache.rec_type			;
				       SELF.fips_state 			:= LEFT.aidwork_acecache.county[1..2]	;
				       SELF.fips_county			:= LEFT.aidwork_acecache.county[3..]	;
				       SELF.geo_lat					:= LEFT.aidwork_acecache.geo_lat			;
				       SELF.geo_long				:= LEFT.aidwork_acecache.geo_long			;
				       SELF.msa							:= LEFT.aidwork_acecache.msa					;
				       SELF.geo_blk					:= LEFT.aidwork_acecache.geo_blk			;
				       SELF.geo_match				:= LEFT.aidwork_acecache.geo_match		;
				       SELF.err_stat				:= LEFT.aidwork_acecache.err_stat			;								
				       SELF							 		:= LEFT																;));

														
  Layout_Base_Seq tAssignAIDs(dAIDSlim L, dCompanyNames R) := TRANSFORM
	  SELF.prep_line1_licensees	        := IF(L.record_type = 'L', L.prep_line1,    R.prep_line1_licensees);
	  SELF.prep_line_last_licensees     := IF(L.record_type = 'L', L.prep_line_last,R.prep_line_last_licensees);
	  SELF.ACEAID_licensees 	          := IF(L.record_type = 'L', L.ACEAID,        R.ACEAID_licensees);
	  SELF.RawAID_licensees 	          := IF(L.record_type = 'L', L.RawAID,        R.RawAID_licensees);
	  SELF.prim_range			              := IF(L.record_type = 'L', L.prim_range,    R.prim_range);
	  SELF.predir					              := IF(L.record_type = 'L', L.predir,        R.predir);
	  SELF.prim_name			              := IF(L.record_type = 'L', L.prim_name,     R.prim_name);
	  SELF.addr_suffix		              := IF(L.record_type = 'L', L.addr_suffix,   R.addr_suffix);
	  SELF.postdir				              := IF(L.record_type = 'L', L.postdir,       R.postdir);
	  SELF.unit_desig			              := IF(L.record_type = 'L', L.unit_desig,    R.unit_desig);
	  SELF.sec_range			              := IF(L.record_type = 'L', L.sec_range,     R.sec_range);
	  SELF.p_city_name		              := IF(L.record_type = 'L', L.p_city_name,   R.p_city_name);
	  SELF.v_city_name		              := IF(L.record_type = 'L', L.v_city_name,   R.v_city_name);
	  SELF.st							              := IF(L.record_type = 'L', L.st,            R.st);
	  SELF.zip5						              := IF(L.record_type = 'L', L.zip,           R.zip5);
	  SELF.zip4						              := IF(L.record_type = 'L', L.zip4,          R.zip4);
	  SELF.fips_state 		              := IF(L.record_type = 'L', L.fips_state,    R.fips_state);
	  SELF.fips_county		              := IF(L.record_type = 'L', L.fips_county,   R.fips_county);
	  SELF.geo_lat				              := IF(L.record_type = 'L', L.geo_lat,       R.geo_lat);
	  SELF.geo_long				              := IF(L.record_type = 'L', L.geo_long,      R.geo_long);
	  SELF.cbsa						              := IF(L.record_type = 'L', L.msa,           R.cbsa);
	  SELF.geo_blk				              := IF(L.record_type = 'L', L.geo_blk,       R.geo_blk);
	  SELF.geo_match			              := IF(L.record_type = 'L', L.geo_match,     R.geo_match);
	  SELF.cart						              := IF(L.record_type = 'L', L.cart,          R.cart);
	  SELF.cr_sort_sz			              := IF(L.record_type = 'L', L.cr_sort_sz,    R.cr_sort_sz);
	  SELF.lot						              := IF(L.record_type = 'L', L.lot,           R.lot);
	  SELF.lot_order			              := IF(L.record_type = 'L', L.lot_order,     R.lot_order);
	  SELF.dpbc						              := IF(L.record_type = 'L', L.dbpc,          R.dpbc);
	  SELF.chk_digit			              := IF(L.record_type = 'L', L.chk_digit,     R.chk_digit);
	  SELF.err_stat				              := IF(L.record_type = 'L', L.err_stat,      R.err_stat);
				
	  SELF.prep_line1_firm	        		:= IF(L.record_type = 'F', L.prep_line1,    R.prep_line1_firm);
	  SELF.prep_line_last_firm     			:= IF(L.record_type = 'F', L.prep_line_last,R.prep_line_last_firm);
	  SELF.ACEAID_firm 	         			  := IF(L.record_type = 'F', L.ACEAID,        R.ACEAID_firm);
	  SELF.RawAID_firm 	          			:= IF(L.record_type = 'F', L.RawAID,        R.RawAID_firm);
	  SELF.firm.prim_range			        := IF(L.record_type = 'F', L.prim_range,    R.firm.prim_range);
	  SELF.firm.predir					        := IF(L.record_type = 'F', L.predir,        R.firm.predir);
	  SELF.firm.prim_name			          := IF(L.record_type = 'F', L.prim_name,     R.firm.prim_name);
	  SELF.firm.addr_suffix		          := IF(L.record_type = 'F', L.addr_suffix,   R.firm.addr_suffix);
	  SELF.firm.postdir				          := IF(L.record_type = 'F', L.postdir,       R.firm.postdir);
	  SELF.firm.unit_desig			        := IF(L.record_type = 'F', L.unit_desig,    R.firm.unit_desig);
	  SELF.firm.sec_range			          := IF(L.record_type = 'F', L.sec_range,     R.firm.sec_range);
	  SELF.firm.p_city_name		          := IF(L.record_type = 'F', L.p_city_name,   R.firm.p_city_name);
	  SELF.firm.v_city_name		          := IF(L.record_type = 'F', L.v_city_name,   R.firm.v_city_name);
	  SELF.firm.st							        := IF(L.record_type = 'F', L.st,            R.firm.st);
	  SELF.firm.zip5						        := IF(L.record_type = 'F', L.zip,           R.firm.zip5);
	  SELF.firm.zip4						        := IF(L.record_type = 'F', L.zip4,          R.firm.zip4);
	  SELF.firm.fips_state 		          := IF(L.record_type = 'F', L.fips_state,    R.firm.fips_state);
	  SELF.firm.fips_county		          := IF(L.record_type = 'F', L.fips_county,   R.firm.fips_county);
	  SELF.firm.geo_lat				          := IF(L.record_type = 'F', L.geo_lat,       R.firm.geo_lat);
	  SELF.firm.geo_long				        := IF(L.record_type = 'F', L.geo_long,      R.firm.geo_long);
	  SELF.firm.cbsa						        := IF(L.record_type = 'F', L.msa,           R.firm.cbsa);
	  SELF.firm.geo_blk				          := IF(L.record_type = 'F', L.geo_blk,       R.firm.geo_blk);
	  SELF.firm.geo_match			          := IF(L.record_type = 'F', L.geo_match,     R.firm.geo_match);
	  SELF.firm.cart						        := IF(L.record_type = 'F', L.cart,          R.firm.cart);
	  SELF.firm.cr_sort_sz			        := IF(L.record_type = 'F', L.cr_sort_sz,    R.firm.cr_sort_sz);
	  SELF.firm.lot						          := IF(L.record_type = 'F', L.lot,           R.firm.lot);
	  SELF.firm.lot_order			          := IF(L.record_type = 'F', L.lot_order,     R.firm.lot_order);
	  SELF.firm.dpbc						        := IF(L.record_type = 'F', L.dbpc,          R.firm.dpbc);
	  SELF.firm.chk_digit			          := IF(L.record_type = 'F', L.chk_digit,     R.firm.chk_digit);
	  SELF.firm.err_stat				        := IF(L.record_type = 'F', L.err_stat,      R.firm.err_stat);
						
	  SELF								              := R;
	  SELF                              := [];
  END;	

	dCompanyNames_dist      := DISTRIBUTE(dCompanyNames_rolled, seq_num);
  dAIDSlim_dist           := DISTRIBUTE(dAIDSlim, seq_num);
		
  dAIDBase := JOIN(dAIDSlim_dist
									,dCompanyNames_dist
									,LEFT.seq_num = RIGHT.seq_num
									,tAssignAIDs(LEFT, RIGHT)
									,RIGHT OUTER
									,LOCAL);

  Layout_Base_Seq tRollFinal(dAIDBase L, dAIDBase R) := TRANSFORM
		
	  SELF.prim_range			                      := IF(L.prim_range = '',       R.prim_range,              L.prim_range);
	  SELF.predir					                      := IF(L.predir = '',           R.predir,                  L.predir);
	  SELF.prim_name			                      := IF(L.prim_name = '',        R.prim_name,               L.prim_name);
	  SELF.addr_suffix		                      := IF(L.addr_suffix = '',      R.addr_suffix,             L.addr_suffix);
	  SELF.postdir				                      := IF(L.postdir = '',          R.postdir,                 L.postdir);
	  SELF.unit_desig			                      := IF(L.unit_desig = '',       R.unit_desig,              L.unit_desig);
	  SELF.sec_range			                      := IF(L.sec_range = '',        R.sec_range,               L.sec_range);
	  SELF.p_city_name		                      := IF(L.p_city_name = '',      R.p_city_name,             L.p_city_name);
	  SELF.v_city_name		                      := IF(L.v_city_name = '',      R.v_city_name,             L.v_city_name);
	  SELF.st							                      := IF(L.st = '',               R.st,                      L.st);
	  SELF.zip5						                      := IF(L.zip5 = '',             R.zip5,                    L.zip5);
	  SELF.zip4						                      := IF(L.zip4 = '',             R.zip4,                    L.zip4);
	  SELF.fips_state 		                      := IF(L.fips_state = '',       R.fips_state,              L.fips_state);
	  SELF.fips_county		                      := IF(L.fips_county = '',      R.fips_county,             L.fips_county);
	  SELF.geo_lat				                      := IF(L.geo_lat = '',          R.geo_lat,                 L.geo_lat);
	  SELF.geo_long				                      := IF(L.geo_long = '',         R.geo_long,                L.geo_long);
	  SELF.cbsa						                      := IF(L.cbsa = '',             R.cbsa,                    L.cbsa);
	  SELF.geo_blk				                      := IF(L.geo_blk = '',          R.geo_blk,                 L.geo_blk);
	  SELF.geo_match			                      := IF(L.geo_match = '',        R.geo_match,               L.geo_match);
	  SELF.cart						                      := IF(L.cart = '',             R.cart,                    L.cart);
	  SELF.cr_sort_sz			                      := IF(L.cr_sort_sz = '',       R.cr_sort_sz,              L.cr_sort_sz);
	  SELF.lot						                      := IF(L.lot = '',              R.lot,                     L.lot);
	  SELF.lot_order			                      := IF(L.lot_order = '',        R.lot_order,               L.lot_order);
	  SELF.dpbc						                      := IF(L.dpbc = '',             R.dpbc,                    L.dpbc);
	  SELF.chk_digit			                      := IF(L.chk_digit = '',        R.chk_digit,               L.chk_digit);
	  SELF.err_stat				                      := IF(L.err_stat = '',         R.err_stat,                L.err_stat);
				
	  SELF.firm.prim_range			                := IF(L.firm.prim_range = '',  R.firm.prim_range,         L.firm.prim_range);
	  SELF.firm.predir					                := IF(L.firm.predir = '',      R.firm.predir,             L.firm.predir);
	  SELF.firm.prim_name			                  := IF(L.firm.prim_name = '',   R.firm.prim_name,          L.firm.prim_name);
	  SELF.firm.addr_suffix		                  := IF(L.firm.addr_suffix = '', R.firm.addr_suffix,        L.firm.addr_suffix);
	  SELF.firm.postdir				                  := IF(L.firm.postdir = '',     R.firm.postdir,            L.firm.postdir);
	  SELF.firm.unit_desig			                := IF(L.firm.unit_desig = '',  R.firm.unit_desig,         L.firm.unit_desig);
	  SELF.firm.sec_range			                  := IF(L.firm.sec_range = '',   R.firm.sec_range,          L.firm.sec_range);
	  SELF.firm.p_city_name		                  := IF(L.firm.p_city_name = '', R.firm.p_city_name,        L.firm.p_city_name);
	  SELF.firm.v_city_name		                  := IF(L.firm.v_city_name = '', R.firm.v_city_name,        L.firm.v_city_name);
	  SELF.firm.st							                := IF(L.firm.st = '',          R.firm.st,                 L.firm.st);
	  SELF.firm.zip5						                := IF(L.firm.zip5 = '',        R.firm.zip5,               L.firm.zip5);
	  SELF.firm.zip4						                := IF(L.firm.zip4 = '',        R.firm.zip4,               L.firm.zip4);
	  SELF.firm.fips_state 		                  := IF(L.firm.fips_state = '',  R.firm.fips_state,         L.firm.fips_state);
	  SELF.firm.fips_county		                  := IF(L.firm.fips_county = '', R.firm.fips_county,        L.firm.fips_county);
	  SELF.firm.geo_lat				                  := IF(L.firm.geo_lat = '',     R.firm.geo_lat,            L.firm.geo_lat);
	  SELF.firm.geo_long				                := IF(L.firm.geo_long = '',    R.firm.geo_long,           L.firm.geo_long);
	  SELF.firm.cbsa						                := IF(L.firm.cbsa = '',        R.firm.cbsa,               L.firm.cbsa);
	  SELF.firm.geo_blk				                  := IF(L.firm.geo_blk = '',     R.firm.geo_blk,            L.firm.geo_blk);
	  SELF.firm.geo_match			                  := IF(L.firm.geo_match = '',   R.firm.geo_match,          L.firm.geo_match);
	  SELF.firm.cart						                := IF(L.firm.cart = '',        R.firm.cart,               L.firm.cart);
	  SELF.firm.cr_sort_sz			                := IF(L.firm.cr_sort_sz = '',  R.firm.cr_sort_sz,         L.firm.cr_sort_sz);
	  SELF.firm.lot						                  := IF(L.firm.lot = '',         R.firm.lot,                L.firm.lot);
	  SELF.firm.lot_order			                  := IF(L.firm.lot_order = '',   R.firm.lot_order,          L.firm.lot_order);
	  SELF.firm.dpbc						                := IF(L.firm.dpbc = '',        R.firm.dpbc,               L.firm.dpbc);
	  SELF.firm.chk_digit			                  := IF(L.firm.chk_digit = '',   R.firm.chk_digit,          L.firm.chk_digit);
	  SELF.firm.err_stat				                := IF(L.firm.err_stat = '',    R.firm.err_stat,           L.firm.err_stat);

	  SELF.RawAID_licensees 	                  := IF(L.RawAID_licensees = 0,  R.RawAID_licensees,        L.RawAID_licensees);
	  SELF.ACEAID_licensees 	                  := IF(L.ACEAID_licensees = 0,  R.ACEAID_licensees,        L.ACEAID_licensees);
	  SELF.RawAID_firm      	                  := IF(L.RawAID_firm = 0,       R.RawAID_firm,             L.RawAID_firm);
	  SELF.ACEAID_firm      	                  := IF(L.ACEAID_firm = 0,       R.ACEAID_firm,             L.ACEAID_firm);
		
		SELF										                  := L;			
	END;
	
	pre_roll_sort := SORT(DISTRIBUTE(dAIDBase, seq_num), seq_num, LOCAL);
 
  final_update_ds := ROLLUP(pre_roll_sort, seq_num, tRollFinal(LEFT, RIGHT), LOCAL);
	
	final_ds := PROJECT(final_update_ds,TRANSFORM(fcc.Layout_FCC_base_bip_AID,SELF:=LEFT;)) :PERSIST('~thor_data400::persist::fcc::proc_prebuild_clean_records');

  RETURN final_ds;
	
END;											