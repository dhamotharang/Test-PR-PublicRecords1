import CivilCourt_services, iesp, doxie;

export SearchService_IDs := module
	export params := interface(AutoKey_IDs.params)
	end;
	export val(params in_mod) := function
		
		by_auto	:=  CivilCourt_services.AutoKey_IDs.val(in_mod);
		
	
		ids_d	:= dedup(sort(by_auto, case_key), case_key);
		ret_code := limit( ids_d, iesp.constants.MAX_COUNT_CIVIL_COURT_AUTOKEY_LIMIT, fail(11, doxie.ErrorCodes(11)));				
    // case_key(s) are returned here.
		// this limit was added to prevent the out of memory errors that were happening.
		// the 11 return code returns a 'search too broad' message.
		return ret_code;
	end;
end;