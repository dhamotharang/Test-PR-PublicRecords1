IMPORT iesp, AutoStandardI, AutoHeaderI, doxie, UPS_Services;

shared mod_PowerSearch := UPS_Services.mod_PowerSearch;
shared Constants := UPS_Services.Constants;
shared mod_Names := UPS_Services.mod_Names;
shared mod_Address := UPS_Services.mod_Address;
shared SearchParams := UPS_Services.SearchParams;
shared IF_PartialMatchSearchParams := UPS_Services.IF_PartialMatchSearchParams;
shared mod_Score := UPS_Services.mod_Score;

export UPSBusinessSearch(DATASET(iesp.rightaddress.t_RightAddressSearchRequest) inReq = DATASET([], iesp.rightaddress.t_RightAddressSearchRequest)) := MODULE
	ds_in := DATASET([], iesp.rightaddress.t_RightAddressSearchRequest) : STORED ('RightAddressSearchRequest', FEW);
	shared first_row := if (EXISTS(inReq), inReq[1], ds_in[1]) : independent;

  //set options (translate from the pre-determined xml style into the stored/soap style that roxie is expecting
	shared search_options := global(first_row.options);
	shared search_by := global (first_row.SearchBy);
	shared powersearch := global(search_by.PowerSearch);
	shared search_by_name := global (mod_Names(search_by).bestParser());
	shared search_by_addr := global (mod_Address(search_by.Address).bestParser());

	shared ps := mod_PowerSearch(powersearch);
	shared ps_name := ps.getName();
	shared ps_addr := ps.getAddress();
	shared ps_phone := ps.getPhone();

  //set main search criteria:
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(search_options);

	// the UPS service has allowed Options/MaxResults to be set to 0.  When
	// MaxResults is 0, though, we miss some records in the individual header
	// lookup (gong?).  Due to a WSDL/ESDL bug (Options/MaxResults isn't 
	// currently visible to the middleware) we can't directly set it in the 
	// request.  This creates a bit of a problem, so if maxresults=0 we'll set
	// a reasonable default value here.
	maxResults := if(search_options.maxresults = 0, 100, search_options.maxresults);
	#stored('MaxResults', maxResults);

	// set the query inputs (from XML) so they can be picked up by GlobalModule.
	iesp.ECL2ESP.SetInputName (if(powersearch <> '', ps_name, search_by_name));
	#stored('CompanyName', search_by_name.CompanyName);
	iesp.ECL2ESP.SetInputAddress (if(powersearch <> '', ps_addr, search_by_addr));
	iesp.ECL2ESP.SetInputSearchOptions (first_row.options);

	// filter out invalid phone inputs, such as "000-0000" or "(561) 000-0000"
	// (per Bugzilla 38423)
	shared validPhone := MAP(powersearch <> ''=> ps_phone,
													 LENGTH(search_by.Phone10) =  7 AND (INTEGER) search_by.Phone10 <> 0 => search_by.Phone10,
													 LENGTH(search_by.Phone10) = 10 AND (INTEGER)(search_by.Phone10[4..10]) <> 0 => search_by.Phone10,
													 '');

	#stored ('phone', validPhone);
	
	shared EntityType := if(search_by.EntityType = Constants.TAG_ENTITY_IND OR
													search_by.EntityType = Constants.TAG_ENTITY_BIZ OR
													search_by.EntityType = Constants.TAG_ENTITY_UNK, search_by.EntityType, Constants.TAG_ENTITY_UNK);

  // pack input parameters into a module
	shared inputmod := AutoStandardI.GlobalModule();

	shared search_inputs := MODULE(SearchParams)
		export nameQueryInputs := if (powersearch <> '', ps_name, search_by_name);
		export addrQueryInputs := if (powersearch <> '', ps_addr, search_by_addr);
		export phoneQueryInput := validPhone;
	END;

	// export BusinessSearch := MODULE

		// Do a business search
		BSearchMod := 
		module (project (inputmod, ups_services.mod_Searches.BusinessSearch.params, opt))
		end;

		biz_res := ups_services.mod_Searches.businessSearch.records(BSearchMod);	

		// Penalize business search results
		BPenMod := module(project (inputmod, IF_PartialMatchSearchParams, opt))
		end;

		biz_res_pen := mod_Score(search_inputs).score(biz_res);

		// don't do a business search if we're searching individuals
		export records := if (EntityType = Constants.TAG_ENTITY_IND, 
															DATASET( [], RECORDOF(biz_res_pen)),
															biz_res_pen);
	// END;

	// export records := BusinessSearch.records;
END;