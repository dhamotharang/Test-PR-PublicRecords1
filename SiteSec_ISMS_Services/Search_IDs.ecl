IMPORT SiteSec_ISMS_Services;

EXPORT Search_IDs := MODULE
	
	EXPORT val(IParam.searchIds in_mod) := FUNCTION
		
		by_auto	:=  AutoKey_IDs.val(PROJECT(in_mod,IParam.autokey_search));
		rawrecs := PROJECT(by_auto,Layouts.rawrec);
		RETURN(rawrecs);
	END;
END;
