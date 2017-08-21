import business_header,business_header_ss,did_add,ut,mdr,PromoteSupers;

df := govdata.File_MS_Workers_Comp_In;

govdata.Layout_MS_Workers_Comp_base into_base(df L) := transform
	self.bdid := 0;
	self 			:= l;
end;

df2 := project(df,into_base(LEFT));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records First Pass
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(
		 df2																	// infile
		,o1																		// outfile
		,false																// bool_bdid_field_is_string12
		,bdid																	// bdid_field
    ,false																// bool_infile_has_source_field
		,MDR.sourceTools.src_MS_Worker_Comp		// source_type_or_field
    ,false																// bool_infile_has_source_group
		,foo																	// source_group_field
		,employer_name												// company_name_field
		,emp_prim_range												// prim_range_field
		,emp_prim_name												// prim_name_field
		,emp_sec_range												// sec_range_field
		,emp_zip5															// zip_field
		,false																// bool_infile_has_phone
		,foo																	// phone_field
		,true																	// bool_infile_has_fein
		,employer_fein												// fein_field
		,																			// bool_infile_has_vendor_id = 'false'
		,																			// vendor_id field					 = 'vendor_id'
		);

myset := ['A','F'];

Business_Header_SS.MAC_Match_Flex(
			 o1																	// input dataset						
			,myset				                			// bdid matchset what fields to match on           
			,employer_name	                    // company_name	              
			,emp_prim_range		                  // prim_range		              
			,emp_prim_name		                  // prim_name		              
			,emp_zip5					                  // zip5					              
			,emp_sec_range		                  // sec_range		              
			,emp_st				        		          // state				              
			,foo						                  	// phone				              
			,employer_fein            			    // fein              
			,bdid										        		// bdid												
			,Layout_MS_Workers_Comp_base				// output layout 
			,false                              // output layout has bdid score field? 																	
			,score                     					// bdid_score                 
			,o3				          								// output dataset
			,																		// keep count
			,																		// default threshold
			,																		// use prod version of superfiles
			,																		// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set						// create BIP keys only
			,																		// url
			,																		// email 
			,emp_p_city_name										// city
			,claim_name_first										// fname
			,claim_name_middle									// mname
			,claim_name_last										// lname
			,claimant_ssn												// contact ssn
		);	

o4 := distribute(o3,hash(employer_name, employer_address, employer_city, employer_state, employer_zip));

o5 := sort(o4,record,except date_first_seen,date_last_seen,local);

Layout_MS_Workers_Comp_base RollupUpdate(Layout_MS_Workers_Comp_base l, Layout_MS_Workers_Comp_base r) := 
transform
		self.date_first_seen 						:= (STRING)ut.EarliestDate(
																				ut.EarliestDate((INTEGER)l.date_first_seen	,(INTEGER)r.date_first_seen)
																			 ,ut.EarliestDate((INTEGER)l.date_last_seen	,(INTEGER)r.date_last_seen)
																			 );
		self.date_last_seen 						:= (STRING)max((INTEGER)l.date_last_seen,(INTEGER)r.date_last_seen);	
		self 														:= l;
end;

o6 := ROLLUP(o5, RollupUpdate(left,right),record,except date_first_seen,date_last_seen,local);
					
PromoteSupers.MAC_SF_BuildProcess(o6,'~thor_data400::base::ms_workers_comp',do1,2);

export Make_MS_Workers_Comp_BDID := do1;
			