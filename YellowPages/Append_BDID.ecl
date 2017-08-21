import BIPV2,Business_Header,Business_Header_SS,did_add,ut;

export Append_BDID(

	dataset(Layout_YellowPages_Base_V2_bip)	pYpBase

) :=
function

	YP_Base_BusName_NonBlank 	:= pYpBase(business_name <> '');
	YP_Base_BusName_Blank		  := pYpBase(business_name = '');

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
	
	BDID_Matchset := ['A'];
	
	// BDID records
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
         ,YellowPages_Base_BDID_out									// Output Dataset
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

	YellowPages_Base_BDID_All := YP_Base_BusName_Blank + YellowPages_Base_BDID_out;

	return YellowPages_Base_BDID_All;

end;