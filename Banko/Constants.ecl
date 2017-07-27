EXPORT Constants := MODULE

	EXPORT BkEvents := MODULE
		EXPORT JOIN_LIMIT := 10000;
	END;
	
	export search_type_code := enum(unsigned1, CASECOURT, TMSID, CASEID);
	
END;