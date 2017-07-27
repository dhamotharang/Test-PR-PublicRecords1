import AutoStandardI,COA_services,ut,doxie,iesp, Address, header, Census_Data;

export SearchService_Records := module
	export params := interface(COA_Services.SearchService_IDs.params)
			export string30 firstName := '';
			export string2 predir := '';
		  export string2 postdir := '';
			export string4 suffix := '';
		  export unsigned1 dppaPurpose;
		  export unsigned1 glbPurpose;
			export string200 addr := '';
			export boolean AllowAll;
			export boolean AllowGLB;
			export boolean AllowDPPA;
			export boolean includeMinors;
			export boolean probationoverride;
			export string5 industryclass;
			export boolean raw;
			export boolean donotfillblanks;
			export string32 ApplicationType;
	end;
	
	export val(params in_mod) := function

 	 unsigned1 region := address.Components.Country.US;
	 
	  // call ID's to get header record recs back
		// this is "first look in header recs which match on zip/address/lastname"
		 
    cleaned_presentation_layout_recs := COA_services.SearchService_IDs.val(in_mod);	
		
		cleaned_header_recs := project(cleaned_presentation_layout_recs, header.layout_header);
		 
		added_raw_in_mod := project(in_mod, raw.params);

		addr1 := Address.Addr1FromComponents(in_mod.prim_range, in_mod.predir, in_mod.prim_name,
		                                     in_mod.suffix, in_mod.postdir, 
																				 '', in_mod.sec_range);
		addr2 := Address.Addr2FromComponents(in_mod.city, in_mod.state, in_mod.zip);
		
    // determine if data passed via <streetAddress1> or in individual fields i.e. parsed or unparsed use accordingly.
		addr1_final := if (addr1 = '', in_mod.addr, addr1);
		clean_addr := Address.GetCleanAddress(addr1_final, addr2, region).results;


		did_set_rec_master := COA_services.Raw.getMasterRec(cleaned_header_recs, added_raw_in_mod, clean_addr);
		
		// grab the input dates which were added to the current address record by raw.getMasterRec
		inputFirstSeenDate := did_set_rec_master[1].inputFirstSeenDate;
		inputLastSeenDate  := did_set_rec_master[1].inputLastSeenDate;
				
		master_date_last_seen :=  did_set_rec_master[1].latestDate;
				
		did_set_recs_lead := COA_services.Raw.getLeadRecs(did_set_rec_master, added_raw_in_mod, clean_addr);

		lead_date_last_seen := did_set_recs_lead[1].dt_last_seen;
		
		// get latest date from master rec and use that if its the latest chronologically
		// otherwise check that rec against coa_lead latest recs and use both if they are equal
		// otherwise use master rec and coa_lead recs if master rec is less for better coverage.
		
		populatePossibleAddress := if (count(did_set_rec_master) = 0, true, 
																	if (master_date_last_seen > lead_date_last_seen, false,
																	     if (master_date_last_seen = lead_date_last_seen, false,
																			 // TODO may need to use top Rec of COA_lead here as well
																		   // lead_date_last_seen = COA_lead	  but how to figure out 
																			 // which coa_lead rec to use if multiple or include all?
																		
																		   if (master_date_last_seen < lead_date_last_seen, true, true))));
																			  
   // populate possible addresses if the latestDate for lead_date_last_seen and master_date_last_seen
	 // are same..otherwise set this to false and just pass in what is needed.
																								
		did_set_recs_final_tmp := if (populatePossibleAddress, did_set_rec_master+did_set_recs_lead,
		                            did_set_rec_master);
																
    did_set_recs_final := dedup(sort(did_set_recs_final_tmp, st, city_name, zip, lname), st,city_name,zip, lname);
																						
		
		
		
		did_set_recs_ds_county := join (did_set_recs_final, Census_Data.Key_Fips2County,
														 (LEFT.st<>'') AND (LEFT.county<>'') AND
                             (left.st = right.state_code) and
                             (left.county = right.county_fips), 
														 transform( coa_services.Layouts.rawrec ,
														          self.county_name := right.county_name,
																			self := left),LEFT OUTER, keep(1));
																			
    did_set_recs_ds := project(did_set_recs_ds_county, coa_services.Layouts.rawrec);																			
																		                      		 
		added_functions_in_mod := project(in_mod, functions.params);
										 													 											 																		 													 
		recs_fmt := COA_Services.Functions.coaSearchval(did_set_recs_ds, 				
																									  added_functions_in_mod, 
																										populatePossibleAddress,
																										inputFirstSeenDate,
																										inputLastSeenDate,
																										did_set_rec_master[1].lastSeenDate,
																										did_set_rec_master[1].firstSeenDate
																										);
		
		results := project(recs_fmt, COA_services.layouts.t_ChangeOfAddressRecord); 
		// OUTPUT(did_set_rec_master,named('ssr_DID_SET_REC_master'));
		// OUTPUT(did_set_recs_lead,named('ssr_did_set_recs_lead'));
		// output(populatePossibleAddress, named('populatePreviousAddress'));
		
		
		// output(populatePossibleAddress,named('SSR_populatePossibleAddr'));
		// output(master_date_last_seen,named('SSR_master_date_last_seen'));
		// output(lead_date_last_seen,named('ssr_lead_date_last_seen'));
		// output(did_set_recs_ds,named('ssr_did_set_recs_ds'));
		// output(inputFirstSeenDate,named('ssr_inputFirstSeenDate'));
		// output(inputlastSeenDate,named('ssr_inputlastSeenDate'));
		
		// output(cleaned_header_recs,named('cleaned_header_recs'));
		// output(did_set_rec_master,named('did_set_rec_master'));
		
		// output(did_set_recs_ds, named('didsetrecsds')); 				
		//output(added_functions_in_mod, named('addedfunctionsinmod'));
		// output(populatePossibleAddress, named('populatePossibleAddress'));
		// output(inputFirstSeenDate, named('inputFirstSeenDate'));
		// output(inputLastSeenDate, named('inputLastSeenDate'));
		// output(did_set_rec_master[1].lastSeenDate, named('MasterREc_lastSeenDate'));
		// output(did_set_rec_master[1].firstSeenDate, named('MasterREc_firstSeenDate'));
		
		return(results);
	end;
end;
		
		