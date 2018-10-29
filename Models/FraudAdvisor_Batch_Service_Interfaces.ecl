EXPORT FraudAdvisor_Batch_Service_Interfaces := MODULE 
	
	EXPORT Input := INTERFACE
		export string 	 ModelName_in ;
		export boolean   doVersion1 ;
		export boolean   doVersion2 ;
		export unsigned1 dppa ;
		export unsigned1 glb ;
		export string5   industry_class_val ;
		export boolean   ofac_Only ;
		export boolean   ofacSearching ;
		export boolean   excludewatchlists ;
		export unsigned1 OFACVersion ;
		export boolean   IncludeOfac ;
		export real      gwThreshold ;
		export boolean   addtl_watchlists ;
		export boolean   usedobFilter ;
		export integer2  dobradius ;
		export unsigned1 RedFlag_version ;
		export string    DataRestriction ;
		export string    DataPermission ;
    export boolean   doParo_attrs ;
    export string    requestedattributegroups;
	END;
	
END;