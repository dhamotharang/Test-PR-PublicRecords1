EXPORT Options := MODULE
//	Options(string pGcID, string pJobId) := MODULE
	EXPORT ISearchParams := INTERFACE
		EXPORT STRING JOBID;
		EXPORT STRING GCID ;
	END;

	EXPORT SearchParams(string pGcID, string pJobId) := MODULE(ISearchParams)
		EXPORT STRING JOBID := pJobId;
		EXPORT STRING GCID  := pGcID;
	END;	
	//RETURN searchParams;
END;