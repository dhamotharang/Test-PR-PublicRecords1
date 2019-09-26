import dx_Header, ut,AutoHeaderV2;

export fetch_SSNPartial (dataset (AutoHeaderV2.layouts.search) ds_search) := function
  _row := ds_search[1];

		temp_fname_value := _row.tname.fname;
		temp_lname_value := _row.tname.lname;
		temp_lname_set_value :=  _row.tname.lname_set;
		temp_ssn_value := trim (_row.tssn.ssn);

    //check which part is being searched for:
    boolean is_ssn4 := length (temp_ssn_value) = 4;
    boolean is_ssn5 := length (temp_ssn_value) = 5;

		max_person := ut.limits.DID_PER_PERSON * 4;

		isLeadingMatch(string input, string keyfield) := 
			input = '' or trim(input) = keyfield[1..length(trim(input))];

		ds4 := project(choosen(limit(dx_Header.key_SSN4()(keyed(ssn4 = temp_ssn_value),
															keyed(temp_lname_value='' or (lname IN temp_lname_set_value)), 
															keyed(isLeadingMatch(temp_fname_value,fname)),
															temp_lname_value<>'' or temp_fname_value = fname  //**slightly funny way of enforcing that leading match only occurs if lname is available
															), max_person, skip),
								ut.limits.DID_PER_PERSON),		  
          transform (AutoHeaderV2.layouts.search_out, self.did := left.did, 
                                         self.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL,
                                         self.index_hit := AutoHeaderV2.Constants.IndexHit.SSN4));

		ds5 := project(choosen(limit(dx_Header.key_SSN5()(keyed(ssn5 = temp_ssn_value),
															keyed(temp_lname_value='' or (lname IN temp_lname_set_value)), 
															keyed(isLeadingMatch(temp_fname_value,fname)),
															temp_lname_value<>'' or temp_fname_value = fname	//**
															), max_person, skip), 
								ut.limits.DID_PER_PERSON),
          transform (AutoHeaderV2.layouts.search_out, self.did := left.did,
                                         self.fetch_hit := AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL,
                                         self.index_hit := AutoHeaderV2.Constants.IndexHit.SSN5));

    // NB: ssn-4 and ssn-5 are mutually exclusive; results should be unique; hence no dedup
    res := map (is_ssn4 and (temp_lname_value<>'' or length(trim(temp_fname_value)) > 1) => ds4,
                is_ssn5 and (temp_lname_value<>'' or length(trim(temp_fname_value)) > 1) => ds5,
                dataset ([], AutoheaderV2.layouts.search_out)); // diagnostics will be added before returning final results

		return if(exists(res), res, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.SSN_PARTIAL, AutoHeaderV2.Constants.STATUS._NOT_FOUND));
end;
