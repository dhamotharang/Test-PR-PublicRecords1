import AutoStandardI,CourtSearch_services,ut,doxie,iesp,Address, header, doxie_cbrs,suppress;

export SearchService_Records := module
	export params := interface(
		CourtSearch_services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,		
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.ssn_mask_value.params)
		export boolean raw;
		export string5 industryclass;
		export boolean probationoverride;
	end;
	export val(params in_mod) := function
			
		ids := CourtSearch_services.SearchService_IDs.val(in_mod);
		
		ds_bdid :=   AutoStandardI.InterfaceTranslator.bdid_dataset.val(in_mod );
		n_vars := doxie_cbrs.name_variations_base(ds_bdid);
		comp_name_variations := project(n_vars.records,  transform(iesp.CourtSearchAdviser.t_courtSearchCompany,
		                                 self.companyName := left.company_name));
    // this gets best company name which is later used as default company name
		// need to bubble this to the top of the list in order for it to show up on GUI
		// in the correct place.
		
    best_compName := project(choosen(doxie_cbrs.fn_best_information(ds_bdid,false),1), 
		                    transform(iesp.CourtSearchAdviser.t_courtSearchCompany,
												self.companyName := left.company_name));

    tmp_best_compNames_set := project(comp_name_variations,transform(
		                            iesp.CourtSearchAdviser.t_courtSearchCompany,
																
																self.companyName := if (left.companyName = best_CompName[1].CompanyName, 
																                        skip, left.companyName);
																));															
		                  
    best_company_name_set := best_CompName + tmp_best_CompNames_set;		                  
		
		// general flow of service is that ids returns header recs
		// based on input criteria.
		// The state of the person's residence is then used to join
		// against information for county and federal (district) and state
		// court search information.
		
				
		// supress certain DIDs.  Set ofDID is all together in one keyfile
		// under field 'did'.  Macro takes ids - in dataset
		                             // did name of did field
																 // ids_tmp out dataset
 		Suppress.MAC_Suppress(ids,ids_tmp,in_mod.ApplicationType,Suppress.Constants.LinkTypes.DID,did);
		
		// surpress particular SSNs
		Suppress.MAC_Suppress(ids_tmp,ids_out,in_mod.ApplicationType,Suppress.Constants.LinkTypes.SSN,ssn);

		// moved this chunk of code before call to functions
		// so to find out # of recs that is returned from above calls
		// this helps below in fail condition to return correct error message.
		//
	  // added filter condition since all recs should have county and zip
		// this prevents downstream bad orders from being started in the court search system.
		// as fname/lname/zip/ssn is needed in data to start a court search order within
		// accurint for the web wizard part.		
    // see what should be passed in
		recsParam	:= if (count(ids_out(company_name <> '')) > 0, 
												 dedup(sort(ids_out(county <> '' AND zip <> ''),st, city_name, prim_name, prim_range, sec_range, company_name), 
												                                                    st, city_name, prim_name, prim_range, sec_range),
						             dedup(sort(ids_out(county <> '' AND zip <> ''),st, city_name, prim_name, prim_range, ssn, lname, fname, mname, -dt_last_seen),
												                                                    st, city_name, prim_name, prim_range, ssn, lname, fname, mname)
                         );																																						
		added_in_mod := project(in_mod, functions.params);
				
		recs_fmt := CourtSearch_services.Functions.fnCourtSearchSearchVal(
				                 recsParam, 											
												 added_in_mod, best_company_name_set);
				                		   				
		tempresults := project(recs_fmt,
		           iesp.courtSearchAdviser.t_CourtSearchAdviserRecord); 
    //output(best_company_name_set, named('best_company_name_set'));							 
		// output(ids_out, named('ids_out'));
		// output(best_company_name_set, named('best_company_name_set'));
		 
		ret_set := if (exists(recsParam), tempresults, fail(tempresults, 10,doxie.ErrorCodes(10)));		 				
		return ret_set;
		
	end; // function
end; // module	