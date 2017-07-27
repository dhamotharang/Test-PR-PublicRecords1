import doxie,doxie_raw, CourtSearch_services,autoKeyI, doxie_cbrs,  AutoStandardI, business_header, iesp;

export SearchService_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface,
	                                AutoStandardI.InterfaceTranslator.bdid_dataset.params)																	
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned1 dppapurpose;
		export unsigned1 glbpurpose;
	end;
	export val(params in_mod) := function
				
	 allow_wildcard_val := true;  // this also gets utilities and quick header recs too.
	 // this call also returns clean header recs as well.
   tmp_set_of_header_recs := doxie.header_records(true, allow_wildcard_val); 
	 tmp_set_of_header_recs_slim := tmp_set_of_header_recs(length(trim(county, left, right)) = 3);
   ds_bdid :=   AutoStandardI.InterfaceTranslator.bdid_dataset.val(in_mod );
																	                                  	 													 
	 // return all the business recs for particular set of bdid(s) input. bdid can be 1 or many bdids.
	 // bdid set as a global on input
	 // pass in false cause we already have a defined set of bdids and don't need the case
	 // when you pass in a single bdid and use that single bdid to get a list of groupid's associated with that
	 // single bdid.
	 //
	  tmp_set_of_bus_recs := doxie_cbrs.fn_getBaseRecs(ds_bdid, false); 
		
	
		
		tmp_set_of_bus_recs_dedup := dedup(sort(tmp_set_of_bus_recs, 
		                                   state, zip, prim_name, prim_range, unit_desig, sec_range, company_name, name_source_id),
		                                   state, zip, prim_name, prim_range, unit_desig, sec_range, company_name, name_source_id);	
																									
   	
	 
	 n_vars := doxie_cbrs.name_variations_base(ds_bdid);

	 
	 	br_msa_county := RECORD
		doxie_cbrs.Layout_BH;
		string60 msaDesc := '';
		string18 county_name := '';
		string120 company_clean := '';
		unsigned2 name_source_id := 0;
		unsigned2 addr_source_id := 0;
		unsigned2 phone_source_id := 0;
		unsigned2 fein_source_id := 0;
		unsigned6 group_id := 0;
	END;
	  

	 
	   name_variations := n_vars.records;
		
		bus_rec_set := join(name_variations, tmp_set_of_bus_recs_dedup,
		                      left.name_source_id = right.name_source_id,											
												   transform ( br_msa_county,											
													 self := right													
													 ));

    tmp_best_rec := choosen(doxie_cbrs.fn_best_information(ds_bdid,false),1);
	 
	  best_rec := project(tmp_best_rec, transform( br_msa_county,	                         
														 self.bdid := (unsigned6) left.bdid,
														 self.dt_last_seen := (unsigned4) (left.dt_last_seen),
														 self := left,
														 self := []));													 
													 
    bus_rec_set_dedup := sort(dedup(sort(best_rec+bus_rec_set,company_name, name_source_id, state, zip, prim_name, prim_range),
		                                            company_name, name_source_id, state, zip, prim_name, prim_range), company_name);													 
	 // -1 is for adding of the best rec above
   bus_rec_set_dedup_reduced := choosen(bus_rec_set_dedup, iesp.constants.ctSearchAdviser.MaxAKAs - 
	                                      CourtSearch_services.Constants.CS_MAX_COMPANIES -1 );
	 
	 set_of_bus_recs :=   project( bus_rec_set_dedup_reduced,
	                                      transform (courtsearch_services.layouts.layout_header_extra,
																				  // divide by 100 on these dates to remove the DD in the YYYYMMDD format
																				self.dt_last_seen := left.dt_last_seen/100,
																				self.dt_first_seen := left.dt_first_seen/100,
																				self.dt_vendor_last_reported  := left.dt_vendor_last_reported/100,
																				self.dt_vendor_first_reported := left.dt_vendor_first_reported/100,
																				self.suffix := left.addr_suffix,
																				self.st := left.state,
																				self.city_name := left.city,
	                                      self := left,
																				self := []
																				));
		set_of_header_recs := project(tmp_set_of_header_recs_slim, 
		                                  transform( courtsearch_services.layouts.layout_header_extra,
		                                  self := left,
																			self := []));
   
	  combined_set := set_of_header_recs + set_of_bus_recs;
		 
		 //output(ds_bdid, named('ds_bdid'));
		 
		// output(set_of_bus_recs, named('set_of_bus_recs'));
    // output(combined_set, named('combined_set'));						
		
		//output(deduped_thebest, named('the_best'));
		//output(the_best);
		
		 //output(bus_rec_set, named('bus_rec_set'));
		 
		 //output(result_set, named('result_set'));
		 //output(n_vars, named('n_vars'));
		  //output(address_variations, named('address_variations'));
		 //output(address_variations, named('addr_variations'));
		 // output(bdid_addrs,named('bdid_addrs'));
		 ///////////////////////////////////////////////////////////
		 // output(tmp_set_of_bus_recs, named('tmp_set_of_bus_recs'));
		 // output(tmp_set_of_bus_recs_dedup, named('tmp_set_of_bus_recs_dedup'));
	    // output(name_variations, named('name_variations'));
			 // output(best_rec, named('best_rec'));
			 // output(bus_rec_set, named('bus_rec_set'));
	     // output(bus_rec_set_dedup, named('bus_rec_set_dedup'));
		//output(tmp_best_rec, named('tmp_best_rec'));
		//output (tmp_set_of_header_recs, named('tmp_set_of_header_recs'));
		return combined_set;
	end;
end;
