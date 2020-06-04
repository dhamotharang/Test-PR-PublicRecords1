import BIPV2, did_add, Business_Header_SS, Business_Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, MDR;

in_file := Calbus.Update_Calbus;

Pre_BDID_Rec := record
	string2	source := '';
	calbus.Layouts_Calbus.layout_bdid;
end;

//Hash on full raw data fields to make source_rec_id persistent
Pre_BDID_Rec	xSourceRecID(Calbus.Layouts_Calbus.Layout_AID_Common l) := 
transform
	self.source := MDR.sourceTools.src_CA_Sales_Tax;
	self.source_rec_id := (unsigned8) (hash64(
													l.district_branch		
												, l.account_number
												, l.district
												, l.tax_code_full
												, l.firm_name
												, l.owner_name
												, l.business_street
												, l.business_city
												, l.business_st
												, l.business_zip5
												, l.business_zip_plus_4
												, l.business_foreign_zip
												, l.business_country_name
												, l.mailing_street
												, l.mailing_city
												, l.mailing_st
												, l.mailing_zip5
												, l.mailing_zip_plus_4
												, l.mailing_foreign_zip
												, l.mailing_country_name
												, l.start_date
												, l.industry_code
												, l.naics_code	
												, l.county_code 
												, l.city_code
												, l.ownership_code));	
	self 				:= l;
end;

in_file_ext	:= project(in_file, xSourceRecID(left));

//added filter to separate the individual names from the business names
filter_owner	:= in_file_ext(trim(Ownership_Code,left,right) in Calbus.Constants.OwnerShip_Code_Check); 
filter_no_own := in_file_ext(trim(Ownership_Code,left,right) not in Calbus.Constants.OwnerShip_Code_Check);

matchset := ['A','N'];

//macro for businesses 
Business_Header_SS.MAC_Match_Flex(
          filter_no_own					// Input Dataset                 
         ,matchset							// BDID Matchset what fields to match on           
         ,Owner_Name						// company_name                 
         ,Business_prim_range		// prim_range
         ,Business_prim_name		// prim_name
				 ,Business_zip5					// zip5
         ,Business_sec_range		// sec_range
         ,Business_st						// state
         ,''										// phone                      
         ,''										// fein              
         ,bdid									// bdid                                    
         ,Pre_BDID_Rec					// Output Layout 
         ,false									// output layout has bdid score field?                       
         ,bdid_score						// bdid_score                 
         ,postBDID							// Output Dataset
				 ,
				 ,											// score_threshold
				 ,											// file version (prod)
				 ,											// use other environment?
				 ,BIPV2.xlink_version_set  // BIP2 ids
				 ,											// URL
				 ,											// email
				 ,Business_p_city_name	// city
				 ,											// contact's first name
				 ,											// contact's middle name
				 ,											// contact's last name                 			 
				 ,											// contact ssn
			   ,source								// source
			   ,source_rec_id					// source_record_id
				 ,false									// does MAC_Source_Match exist before Flex macro	
				 );	 	

//macro for businesses and individuals 
Business_Header_SS.MAC_Match_Flex(
          filter_owner					// Input Dataset                 
         ,matchset							// BDID Matchset what fields to match on           
         ,Firm_Name							// company_name                 
         ,Business_prim_range		// prim_range
         ,Business_prim_name		// prim_name
				 ,Business_zip5					// zip5
         ,Business_sec_range		// sec_range
         ,Business_st						// state
         ,''										// phone                      
         ,''										// fein              
         ,bdid									// bdid                                    
         ,Pre_BDID_Rec					// Output Layout 
         ,false									// output layout has bdid score field?                       
         ,bdid_score						// bdid_score                 
         ,postBDID2							// Output Dataset
				 ,				 
				 ,											// score_threshold
				 ,											// file version (prod)
				 ,											// use other environment?
				 ,BIPV2.xlink_version_set  // BIP2 ids
				 ,											// URL
				 ,											// email
				 ,Business_p_city_name	// city
				 ,											// contact's first name
				 ,											// contact's middle name
				 ,											// contact's last name
				 ,											// contact ssn
			   ,source								// source
			   ,source_rec_id					// source_record_id
				 ,false									// does MAC_Source_Match exist before Flex macro			 
				 ); 

//concatenated macro records
Cleaned_Calbus_BDID_Concat := postBDID + postBDID2;

export Cleaned_Calbus_BDID := Cleaned_Calbus_BDID_Concat : persist(Calbus.Constants.Cluster + 'persist::calbus::Cleaned_Calbus_bdid');
