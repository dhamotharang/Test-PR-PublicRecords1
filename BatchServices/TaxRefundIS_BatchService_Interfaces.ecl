IMPORT doxie;

EXPORT TaxRefundIS_BatchService_Interfaces := MODULE

	EXPORT Input := INTERFACE (doxie.IDataAccess)
	
	  EXPORT boolean IncludeBlankDOD;
    EXPORT boolean PhoneticMatch; 
    EXPORT boolean AllowNickNames; 
		EXPORT string120 append_l; //Append allows all Best Info to return
		EXPORT string120 verify_l;
		EXPORT string2 input_state;
		EXPORT boolean isInputState(string2 st) := st = input_state or input_state = '' or st = '';
		EXPORT unsigned2 BestSSNScoreMin;
		EXPORT unsigned2 BestNameScoreMin;
		EXPORT unsigned2 SSNScoreMin;
		EXPORT unsigned2 NAMEScoreMin;
		EXPORT string20  ModelName;        
		EXPORT string3   NPIThreshold; 
		EXPORT string30  FilterRule;
		
	END;

END;
