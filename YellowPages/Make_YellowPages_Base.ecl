IMPORT ut, Business_Header, Business_header_SS, did_add;
#workunit('name', 'Build Yellow Pages Base ' + yellowpages.YellowPages_Build_Date);

// Combine Yellow Pages with Pseudo_Yellow Pages derived from Gong Business Listings
YellowPages_Base := YellowPages.YellowPages_Base_YP() + YellowPages.YellowPages_Base_Gong();

YP_Base_BusName_NonBlank 	:= YellowPages_Base(business_name <> '');
YP_Base_BusName_Blank		  := YellowPages_Base(business_name = '');

// First do a direct source match to the current Business Headers
// -- BDID records First Pass
Business_Header.MAC_Source_Match(
		 YP_Base_BusName_NonBlank				// infile
		,YellowPages_Base_BDID					// outfile
		,false													// bool_bdid_field_is_string12
		,bdid														// bdid_field
    ,true														// bool_infile_has_source_field
		,source													// source_type_or_field
    ,false													// bool_infile_has_source_group
		,source_group_field							// source_group_field
		,business_name									// company_name_field
		,prim_range											// prim_range_field
		,prim_name											// prim_name_field
		,sec_range											// sec_range_field
		,zip														// zip_field
		,true														// bool_infile_has_phone
		,phone10												// phone_field
		,false													// bool_infile_has_fein
		,fein_field											// fein_field
		,																// bool_infile_has_vendor_id = 'false'
		,																// vendor_id field					 = 'vendor_id'
);												

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Business_Header_SS.MAC_Add_BDID_FLEX(
          YellowPages_Base_BDID											// Input Dataset                 
         ,BDID_Matchset															// BDID Matchset what fields to match on           
         ,business_name															// company_name                 
         ,prim_range																// prim_range
         ,prim_name																	// prim_name
				 ,zip																				// zip5
         ,sec_range																	// sec_range
         ,st																				// state
         ,phone10																		// phone                      
         ,fein_field																// fein              
         ,bdid																			// bdid                                    
         ,Layout_YellowPages_Base_V2_bip						// Output Layout 
         ,false																			// output layout has bdid score field?                       
         ,BDID_score_field													// bdid_score                 
         ,YellowPages_Base_BDID_Rematch							// Output Dataset
				 ,																					// score_threshold
				 ,																					// file version (prod)
				 ,																					// use other environment?
				 ,BIPV2.xlink_version_set  									// BIP2 ids
				 ,																					// URL
				 ,email_address															// email
				 ,p_city_name																// city
				 ,fname																			// contact's first name
				 ,mname																			// contact's middle name
				 ,lname																			// contact's last name                 			 
				 ,																					// contact ssn
				 ,source																		// source
				 ,source_rec_id															// source_record_id
				 ,true				 															// does MAC_Source_Match exist before Flex macro				 
				 );  										

YellowPages_Base_BDID_All := YP_Base_BusName_Blank + YellowPages_Base_BDID_Rematch;

COUNT(YellowPages_Base_BDID_All(bdid <> 0));

//OUTPUT(YellowPages_Base_BDID_All,,'BASE::YellowPages_' + YellowPages.YellowPages_Build_Date, OVERWRITE);
ut.MAC_SF_BuildProcess(yellowpages_base_bdid_all,'base::YellowPages',do_it,2)

ut.MAC_SK_BuildProcess_v2(yellowpages.key_yellowpages_bdid,'~thor_data400::key::yellowpages_bdid',do_2);
ut.MAC_SK_BuildProcess_v2(yellowpages.Key_YellowPages_Addr,'~thor_data400::key::yellowpages_addr',do_2b);
ut.MAC_SK_BuildProcess_v2(yellowpages.key_yellowpages_phone,'~thor_Data400::key::yellowpages_phone',do_2c);

ut.MAC_SK_Move_v2('~thor_data400::key::yellowpages_bdid','Q',do_3,2);
ut.MAC_SK_Move_v2('~thor_data400::key::yellowpages_phone','Q',do_3b,2);
ut.MAC_SK_Move_v2('~thor_data400::key::yellowpages_addr','Q',do_3c,2);


sequential(do_it,do_2,do_2b, do_2c, do_3, do_3b, do_3c);
