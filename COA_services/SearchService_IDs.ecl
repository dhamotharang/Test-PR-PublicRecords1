import doxie, COA_services, AutoKeyI;

export SearchService_IDs := module
	export params := interface(AutoKeyI.AutoKeyStandardFetchBaseInterface)
		export boolean noDeepDive := false;
		export unsigned2 MAX_DEEP_DIDS := 100;
		export unsigned1 dppapurpose;
		export unsigned1 glbpurpose;
	 end;
	export val(params in_mod) := function 
		
   allow_wildcard_val := true;  // this also gets utilities and quick header recs too.
	 // this call also returns clean header recs as well.
   set_of_header_recs := doxie.header_records(true, allow_wildcard_val);
 		
		return set_of_header_recs;
	end;
end;