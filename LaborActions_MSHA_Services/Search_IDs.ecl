IMPORT LaborActions_MSHA;

EXPORT Search_IDs := MODULE
	
	EXPORT val(IParam.searchIds in_mod) := FUNCTION
		
		by_auto	:=  AutoKey_IDs.val(project(in_mod, IParam.autokey_search));
		RETURN(by_auto);
	END;
END;
