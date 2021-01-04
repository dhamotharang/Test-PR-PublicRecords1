IMPORT CivilCourt_services, iesp, doxie;

EXPORT SearchService_IDs := MODULE
  EXPORT params := INTERFACE(AutoKey_IDs.params)
  END;
  EXPORT val(params in_mod) := FUNCTION
    
    by_auto := CivilCourt_services.AutoKey_IDs.val(in_mod);
    
  
    ids_d := DEDUP(SORT(by_auto, case_key), case_key);
    ret_code := LIMIT( ids_d, iesp.constants.MAX_COUNT_CIVIL_COURT_AUTOKEY_LIMIT, FAIL(11, doxie.ErrorCodes(11)));
    // case_key(s) are returned here.
    // this limit was added to prevent the out of memory errors that were happening.
    // the 11 return code returns a 'search too broad' message.
    RETURN ret_code;
  END;
END;
