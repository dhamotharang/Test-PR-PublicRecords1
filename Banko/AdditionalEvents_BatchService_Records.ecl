export AdditionalEvents_BatchService_Records(	dataset(layout_bkevents_in) ds_in,
																							boolean isFCRA = false, 
																							search_type = Constants.search_type_code.CASECOURT,
																							boolean returnUncategorizedEvents = false) 
:= function
	
	k_evts := banko.key_Banko_courtcode_casenumber(isFCRA);

	outrec := record
		string30 acctno;
		k_evts;
	end;
	
	/* transform for join */
	outrec xfm_join(ds_in le, k_evts ri) := transform
		self := ri;
		self := le;
	end;
	
	/* 
		drcategoryeventid = '0' is an unclassified event. we don't want those.
		and we want to limit to date values on the data (RIGHT) that occurred 
		since the input (LEFT) 'entered_date' so that we get updated events on a case.
    12/6/2016 - JIRA RR-10730 - product manager: Jennifer Matheny
    Change ECL so input "entered_date" is being compared to the data field
    "fileddate" (the date the Event was filed with the court).
	*/
	other_join_options() := macro
		(returnUncategorizedEvents or right.drcategoryeventid != '0') and right.entereddate >= left.entered_date
	endmacro;

	
	/*	get results from defined search type	*/
	ds_out := case(search_type,
							Constants.search_type_code.CASECOURT => 
														join(	ds_in, 
																	k_evts, 
																	keyed(left.casekey = right.casekey and left.court_code = right.court_code)
																		and other_join_options(),
																	xfm_join(left, right),
																	limit(Banko.Constants.BkEvents.JOIN_LIMIT, skip)),
							Constants.search_type_code.TMSID			=> 
														join(	ds_in,
																	k_evts, 
																	keyed(left.tmsid[8.. ] = right.casekey and left.tmsid[3..7] = right.court_code)
																		and other_join_options(),
																	xfm_join(left, right),
																	limit(Banko.Constants.BkEvents.JOIN_LIMIT, skip)),
							Constants.search_type_code.CASEID		=> 
														join(	ds_in, 
																	k_evts, 
																	keyed(left.caseid = right.caseid) and wild(right.casekey) and wild(right.court_code)
																		and other_join_options(),
																	xfm_join(left, right),
																	limit(Banko.Constants.BkEvents.JOIN_LIMIT, skip)));

	// DEBUG:
	// output(search_type, named('search_type'));
	// output(ds_in, named('ds_in'));
	// output(ds_out, named('ds_out'));	
	
	return ds_out;
	
end;
