IMPORT ECRulings;

EXPORT Search_IDs := MODULE
	
	EXPORT val(IParam.searchIds in_mod) := FUNCTION
		
		by_auto	:=  AutoKey_Ids.val(project(in_mod, IParam.autokey_search));
		rawrecs := PROJECT(by_auto,TRANSFORM(ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc,SELF := LEFT));

		RETURN(rawrecs);
	END;
END;
