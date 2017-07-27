import doxie,doxie_cbrs,doxie_raw, COA_services, AutoKeyI;

export SearchService_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned1 dppapurpose;
		export unsigned1 glbpurpose;
	 end;
	export val(params in_mod) := function 
		
		// deep DIDs
		// deep_dids := project(limit(doxie.Get_Dids(,true),in_mod.MAX_DEEP_DIDS,skip),
									 // transform(doxie.layout_references, 									   								
										 // self.did := left.did,										
										  // self := left));
																
   // by_deep_dids := if ( not in_mod.noDeepDive,COA_services.Raw.byDids(deep_dids, in_mod.dppaPurpose,
	                                                                               // in_mod.glbPurpose));	
	 
   allow_wildcard_val := true;  // this also gets utilities and quick header recs too.
	 // this call also returns clean header recs as well.
   set_of_header_recs := doxie.header_records(true, allow_wildcard_val);
 		
		// output(by_deep_dids,named('SSI_by_deep_dids'));
		
		return set_of_header_recs;
	end;
end;