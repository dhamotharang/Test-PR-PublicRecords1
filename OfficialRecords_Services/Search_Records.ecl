import Address,AutoStandardI,official_records,iesp, NID, ut, suppress;

export Search_Records := module
	export params := interface
	  (OfficialRecords_Services.Search_IDs.params,
		 AutoStandardI.LIBIN.PenaltyI_Indv.base)
 		 export integer2 FilingStartDateYear  := 0;  
	   export integer2 FilingStartDateMonth := 0;
	   export integer2 FilingStartDateDay   := 0;
	   export integer2 FilingEndDateYear    := 0;
	   export integer2 FilingEndDateMonth   := 0;
	   export integer2 FilingEndDateDay     := 0;
	end;
	
	export dataset(iesp.officialrecord.t_OfficialRecRecord) val(params in_mod) := function
	
		// Get the official_record_key (orid) numbers associated with what information was 
		// entered in the input search fields.
		orids := OfficialRecords_Services.Search_IDs.val(in_mod);
		
		// Join orids returned from Search_IDs to key party orid on official_record_key to get
		// detailed info for the orid.
		recs_joined := join(orids,official_records.Key_Party_ORID,
			               keyed(left.official_record_key=right.official_record_key),
		 				         transform(OfficialRecords_Services.Layouts.raw_rec,
						           self:=left,
											 self:=right,
											 self := []),
										 limit(OfficialRecords_Services.Constants.MAX_RECS_ON_JOIN, skip));

	  // Set local attributes to be used in filter checking below
		search_st          := trim(StringLib.StringToUpperCase(in_mod.state),left,right);
		// Reminder; input county was stored in city for searching autokeys
		search_county      := trim(StringLib.StringToUpperCase(in_mod.city),left,right);
										 
 	  // Create 8 digit date string from individual pieces (yyyy, mm, dd).
		integer4 search_date_start := (in_mod.FilingStartDateYear*10000) + 
		                              (in_mod.FilingStartDateMonth*100)  + 
		                              in_mod.FilingStartDateDay;
	  integer4 temp_date_end     := (in_mod.FilingEndDateYear*10000) + 
		                              (in_mod.FilingEndDateMonth*100)  + 
												          in_mod.FilingEndDateDay;
																	
		// if end date not entered, set it to the highest possible value for filtering below.
    integer4 search_date_end := if(temp_date_end=0,99999999,temp_date_end);
				
    // Filter to only include records that meet what was entered on the search criteria.

		// Only include recs for the requested state (if there was one).
		recs_filt1 := recs_joined (search_st='' or 
										           (search_st <> '' and search_st = state_origin));

    // Only include recs for the requested county and state (if there was one).
		// If county entered on search form, then state must also be entered for filtering
		// to take place.  That is how the moxie search worked.
		recs_filt2 := recs_filt1 (search_county='' or 
		                          (search_county<>'' and search_st='') or
										          (
															 search_county <> '' and search_county = county_name and
															 search_st <> '' and search_st = state_origin
															)
														 );

    // Used to replace spaces in date strings with zeroes so cast to integer works Ok for
		// all date variations.
    fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');


    // *********************************************************************************
		// Filter to only include records that meet what was entered on the search criteria.
    // *********************************************************************************

    // Only include recs within the requested date range (if there was one), 
		// fixing the doc_filed_dt in case it just contains a yyyy or a yyyymm.
		recs_filt3 := recs_filt2 (search_date_start <= (integer4) fixed_date(doc_filed_dt) and
		                          (integer4) fixed_date(doc_filed_dt) <= search_date_end
		                         );
	 	 
		// input values
		in_strict       := in_mod.StrictMatch;
		in_nicknames_on := in_mod.allownicknames;
		in_phonetics_on := in_mod.phoneticmatch;
		
    string20 search_firstname  := trim(StringLib.StringToUpperCase(in_mod.FirstName),left,right);
		string20 search_middlename := trim(StringLib.StringToUpperCase(in_mod.MiddleName),left,right);
		boolean search_mi_only     := if(search_middlename[2]=' ',true,false);
		string20 search_lastname   := trim(StringLib.StringToUpperCase(in_mod.LastName),left,right);		
    string120 search_compname  := StringLib.StringToUpperCase(in_mod.CompanyName);

		// When StrictMatch requested, filter on last name
		// allowing for when PhoneticMatch was requested.
	  recs_filt4 := recs_filt3 (not(in_strict) or search_compname<>'' or 
										          (search_lastname <> '' and 
															 (search_lastname = trim(lname1,left,right) or
															  (in_phonetics_on and 
															            metaphonelib.DMetaPhone1(search_lastname)[1..6] = 
															            metaphonelib.DMetaPhone1(lname1)[1..6]
																)
															 )
															)
														 );

		// When StrictMatch requested, filter on first name,
		// allowing for when AllowNickNames was requested.
	  recs_filt5 := recs_filt4 (not(in_strict) or search_compname<>'' or 
										          (search_firstname <> '' and 
															 (search_firstname = trim(fname1,left,right) or
															  (in_nicknames_on and 
																             NID.mod_PFirstTools.PFLeqPFR(search_firstname,trim(fname1,left,right))
																)
															 )
															)
														 );
		
		// When StrictMatch requested, filter on:
		// entire middle name if more than 1 character entered in search by field or
		// only first initial of middle name if only 1 character entered in search by field.
	  recs_filt6 := recs_filt5 (not(in_strict) or search_compname<>'' or 
		                          search_middlename=' ' or
										          (search_middlename <> '' and 
															 (not(search_mi_only) and
															                   search_middlename = trim(mname1,left,right)
															 )
															 or
															 (search_mi_only and search_middlename[1] = mname1[1])
															)
														 );
		

	  // Remove all records for an orid except one.
	 	recs_filt_deduped := dedup(sort(recs_filt6,official_record_key), 
		                           official_record_key);
 
 		// Join orids to key document orid on official_record_key to get
		// detailed document level info for the orid.
		recs_joined2 := join(recs_filt_deduped,official_records.Key_Document_ORID,
			               keyed(left.official_record_key=right.official_record_key) 
										 ,transform(recordof(official_records.Key_Document_ORID),
											 self:=right,
											 self := []),
										 limit(OfficialRecords_Services.Constants.MAX_RECS_ON_JOIN, skip));
		
		
		// Format recs for searchservice XML output
		recs_fmtd := OfficialRecords_Services.Functions.fnSearchVal(recs_joined2);
		
		// Sort into final order for returning
		recs_sort := sort(recs_fmtd,-FilingDate.Year,
																-FilingDate.Month,
																-FilingDate.Day,
																State,
																County,
																OfficialRecordId,
											record);

		// Dedup
		recs_dedup := dedup(recs_sort, record);
		
    // Limit the returned output records to the current max value of 2000 records.
    recs_proj := choosen(recs_dedup, iesp.Constants.OFFRECS_MAX_COUNT_SEARCH_RESPONSE_RECORDS);

		// Compliance
		Suppress.MAC_Suppress(recs_proj,recs_pulled,in_mod.applicationtype,,,Suppress.Constants.DocTypes.OfficialRecord,OfficialRecordId);


    //Uncomment lines below as needed to assist in debugging
		//output(in_mod.penalty_threshold,named('sr_inmod_pen_th'));
		//output(orids,named('sr_orids'));
		//output(recs_joined, named('sr_recs_joined'));
	  //output(in_mod.state,named('sr_inmod_state'));
		//output(in_mod.city,named('sr_inmod_city'));
		//output(search_st,named('sr_search_st'));
		//output(search_county,named('sr_search_county'));
	  //output(search_date_start,named('sr_searchdatestart'));
		//output(temp_date_end,named('sr_tempdateend'));
		//output(search_date_end,named('sr_searchdateend'));
		//output(in_strict,named('sr_in_strict'));
		//output(in_nicknames_on,named('sr_in_nicknames_on'));
		//output(in_phonetics_on,named('sr_in_phonetics_on'));
		//output(search_firstname,named('sr_search_firstname'));
		//output(search_middlename,named('sr_search_middlename'));
		//output(search_lastname,named('sr_search_lastname'));
		//output(recs_filt1, named('sr_recs_filt1'));
		//output(recs_filt2, named('sr_recs_filt2'));
		//output(recs_filt3, named('sr_recs_filt3'));
		//output(recs_filt4, named('sr_recs_filt4'));
		//output(recs_filt5, named('sr_recs_filt5'));
		//output(recs_filt6, named('sr_recs_filt6'));
		//output(recs_filt_deduped, named('sr_recs_filt_deduped'));
		//output(recs_joined2, named('sr_recs_joined2'));
		//output(recs_fmtd, named('sr_recs_fmt'));
    //output(recs_sort, named('sr_recs_sort'));
		//output(recs_proj, named('sr_recs_proj'));
		
		return recs_pulled;

	end;
		
end;
