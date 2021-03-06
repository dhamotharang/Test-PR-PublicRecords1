import doxie, doxie_cbrs, Alerts, AutoStandardI, BankruptcyV3_Services,
       NID, Std, ut, address;

export bankruptcy_raw(boolean isFCRA = false) :=
	module
    shared UNSIGNED8 maxResults_val := AutoStandardI.InterfaceTranslator.maxResults_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.maxResults_val.params));
		shared UNSIGNED2 penalt_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
		shared string32 applicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(isFCRA),AutoStandardI.InterfaceTranslator.application_type_val.params));
    shared STRING4 in_SSNLast4 :=  '' : stored('SSNLast4');
		shared empty_dids := dataset([],doxie.layout_references);
		shared empty_bdids := dataset([],doxie_cbrs.layout_references);
		shared empty_tmsids := dataset([],bankruptcyv3_services.layouts.layout_tmsid_ext);
		//----------------
		// The search view
		//----------------
		export search_view(
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = '',
			string2 in_filing_jurisdiction = '',
			boolean suppress_withdrawn_bankruptcy = false,
     boolean EnableCaseNumberFilter = false,
     string2 in_state = '',
     string9 in_ssn = '',
     string50 in_lname = '',
     string30 in_fname = '',
     string25 in_case_number = '',
     unsigned6 in_did = 0,
			string25 in_city = '',
			string120 in_attorney_name  = '',  // This can be an Attorney Person or Attorney Company name 
			string10 in_court_code = ''
			) :=
				function
      
      AttorneyCompanyName :=  in_attorney_name; 
      cleaned_AttorneyPersonName := Address.CleanPerson73_fields(in_attorney_name);
      AttorneyPersonName_First :=  cleaned_AttorneyPersonName.fname;
      AttorneyPersonName_Last := cleaned_AttorneyPersonName.lname;
      boolean isAttorneySearch := in_attorney_name != '';

     
        
				temp_results1 := bankruptcyv3_services.fn_rollup(empty_dids,empty_bdids,empty_tmsids,0,in_ssn_mask,true,,
                                                        in_party_type,in_filing_jurisdiction, isFCRA, in_SSNLast4,false,
                                                        '','',applicationType,EnableCaseNumberFilter, isAttorneySearch);
					
					// FCRA overrides
					temp_results_corr := BankruptcyV3_Services.fn_fcra_correct(temp_results1);
          temp_results2 := if (isFCRA, temp_results_corr, temp_results1);
					temp_results_raw := BankruptcyV3_Services.fn_add_withdrawn_status(temp_results2, isFCRA, suppress_withdrawn_bankruptcy);
					
          // When the case number is input, filter the results to remove any records that don't contain the case number
           temp_results_raw_with_case_number := temp_results_raw( case_number = in_case_number OR 
                                                                  full_case_number = in_case_number);
          SameLocation(ds_debtors, input_state, input_city) := functionmacro
                           return
                             (EXISTS(ds_debtors.addresses(st = input_state)) OR filing_jurisdiction = input_state ) AND
                             (EXISTS(ds_debtors.addresses(p_city_name = input_city)) OR court_location = input_city );
                       endmacro;
                                           
          
          SameName(pp, Attorney_First, Attorney_Last, Attorney_Company) := functionmacro
                          return  
                            (NID.PreferredFirstNew(pp.fname) = NID.PreferredFirstNew(Attorney_First) AND 
                             pp.lname = Attorney_Last)
                             OR
                             pp.cname = Attorney_Company;
                    endmacro;
                                       
           
           attorney_name_search_pre :=  temp_results_raw_with_case_number(
                      (matched_party.party_type = 'A') AND 
                      SameLocation (debtors, in_state, in_city) AND
                      SameName (matched_party.parsed_party, AttorneyPersonName_First, AttorneyPersonName_Last, AttorneyCompanyName));
/*           In case of attorney name, casenumber search, there is possiblity of tmsid duplicates. 
             We allowed this to catch both company aswell as person attorney. We are deduping based on TMSID now */
           attorney_name_search := dedup(sort(attorney_name_search_pre,
                                              tmsid,(unsigned6)matched_party.did),
                                         tmsid);
           
           temp_results_filtered_by_input :=  
           MAP(
                in_ssn != '' => 
                  temp_results_raw_with_case_number(EXISTS(debtors(in_ssn IN [ssn,app_ssn,ssnmatch]))),
                  
                in_did != 0  =>
                  temp_results_raw_with_case_number((unsigned6)matched_party.did = in_did),
                  
                in_fname != ''  and in_lname != '' => 
                 temp_results_raw_with_case_number(
                                     NID.PreferredFirstNew(matched_party.parsed_party.fname) = NID.PreferredFirstNew(in_fname) AND 
                                     matched_party.parsed_party.lname = in_lname AND 
                                    (EXISTS(debtors.addresses(st = in_state)) OR filing_jurisdiction = in_state )
                                    ),
                isAttorneySearch  => attorney_name_search ,										 
                                       
								 in_court_code != '' =>
										temp_results_raw_with_case_number(court_code  = in_court_code),  
               
                dataset([],recordof(temp_results_raw_with_case_number))
            );
            									
    
          temp_results :=
            if(EnableCaseNumberFilter,
               temp_results_filtered_by_input,
               temp_results_raw);

					temp_sorted := sort(
						// temp_results(penalt <= in_parms.penalt_threshold),
						temp_results(penalt <= penalt_threshold),
						isdeepdive,penalt,-date_filed,case_number,
						if(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), record);

					Alerts.mac_ProcessAlerts(temp_sorted,BankruptcyV3_services.alert,temp_final);
          
					RETURN temp_final;
				end;
		//----------------
		// The report view
		//----------------
		export report_view(
			dataset(doxie.layout_references) in_dids = empty_dids,
			dataset(doxie_cbrs.layout_references) in_bdids = empty_bdids,
			dataset(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = ''
			) :=
				function
					temp_results := bankruptcyv3_services.fn_rollup(in_dids,in_bdids,in_tmsids,in_limit,in_ssn_mask,false,,in_party_type,'',isfcra,'',false,'','',applicationType);
					return temp_results;
				end;
		//----------------
		// The source view
		//----------------
		export source_view(
			dataset(doxie.layout_references) in_dids = empty_dids,
			dataset(doxie_cbrs.layout_references) in_bdids = empty_bdids,
			dataset(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			boolean in_all_bks_for_all_debtors = false,
			string1 in_party_type = '',
			boolean include_dockets = false,
			string8 lower_entered_date = '',
			string8 upper_entered_date = '',
			boolean suppress_withdrawn_bankruptcy = false
			) :=
				function
					
					temp_results1 := bankruptcyv3_services.fn_rollup(in_dids,in_bdids,in_tmsids,in_limit,in_ssn_mask,false,in_all_bks_for_all_debtors,
																	in_party_type, ,isFCRA,,include_dockets, 
																	lower_entered_date, upper_entered_date,applicationType);
					
					// FCRA overrides
					temp_results_corr := BankruptcyV3_Services.fn_fcra_correct(temp_results1);
					temp_results := if (isFCRA, temp_results_corr, temp_results1);
					
					bk_results := BankruptcyV3_Services.fn_add_withdrawn_status(temp_results,isFCRA,suppress_withdrawn_bankruptcy);
					
					return bk_results;
				end;
		//----------------
		// The source view for Boolean
		//----------------
		export boolean_source_view(
			dataset(bankruptcyv3_services.layouts.layout_tmsid_ext) in_tmsids = empty_tmsids,
			unsigned in_limit = 0,
			string6 in_ssn_mask = 'NONE',
			string1 in_party_type = ''
			) :=
				function
					temp_results := bankruptcyv3_services.fn_boolean_rollup(in_tmsids,in_limit,in_ssn_mask,false,in_party_type,isFCRA,applicationType);
					return temp_results;
				end;
	end;
	
	
