import dx_Header, ut, AutoheaderV2;

export fetch_wild_SSNPartial (dataset (AutoheaderV2.layouts.search) ds_search) := function
	_row := ds_search[1];
		
	temp_fname_value := _row.tname.fname;
	temp_fname_wild_val := _row.tname.fname; //same as temp_fname_value
	temp_lname_value := _row.tname.lname;
	temp_lname_wild_val := _row.tname.lname; //same as temp_lname_value
	temp_ssn_value := _row.tssn.ssn;

	i4 := dx_Header.key_SSN4();
	i5 := dx_Header.key_SSN5();

	is_ssn4 := length(trim(temp_ssn_value))=4;
	is_ssn5 := length(trim(temp_ssn_value))=5;

	max_person := ut.limits.DID_PER_PERSON * 4;

	ds4 := project(choosen(limit(i4(keyed(ssn4=trim(temp_ssn_value)),
														temp_lname_wild_val='' OR stringlib.StringWildMatch(lname,temp_lname_wild_val,true),
														temp_fname_wild_val='' OR stringlib.StringWildMatch(fname,temp_fname_wild_val,true)),
											max_person, skip),
						 ut.limits.DID_PER_PERSON), 
									 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_SSN_PARTIAL));

	ds5 := project(choosen(limit(i5(keyed(ssn5=trim(temp_ssn_value)),
										 temp_lname_wild_val='' OR stringlib.StringWildMatch(lname,temp_lname_wild_val,true),
													 temp_fname_wild_val='' OR stringlib.StringWildMatch(fname,temp_fname_wild_val,true)),
													 max_person, skip),
						 ut.limits.DID_PER_PERSON),		 
						 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_SSN_PARTIAL));
																	
	res_final := map(is_ssn4 and (temp_lname_value<>'' or temp_fname_value<>'') => ds4, 
																							is_ssn5 and (temp_lname_value<>'' or temp_fname_value<>'') => ds5, 
																							dataset([],AutoheaderV2.layouts.search_out));
	
	return if(exists(res_final), res_final, AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_SSN_PARTIAL, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;
