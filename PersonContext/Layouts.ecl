import ut,Insurance_iesp,iesp, InsuranceContext_iesp, iesp.Constants,
       PersonContext;
 
EXPORT Layouts := MODULE

 EXPORT Layout_PCRequest := Insurance_iesp.personcontext.t_personcontextRequest;
 EXPORT Layout_PCSearchBy := Insurance_iesp.personcontext.t_personcontextSearchBy;
 EXPORT Layout_PCSearchKey := Insurance_iesp.personcontext.t_personcontextSearchKey;
 
 EXPORT Layout_PCResponse := Insurance_iesp.personcontext.t_personcontextResponse;
 EXPORT Layout_PCDBResponse := Insurance_iesp.personcontext.t_personcontextDeltabaseResponseEx;
 EXPORT Layout_PCResponseRec := Insurance_iesp.personcontext.t_personcontextRecord;

//this layout is used to hold a simpler form of the search keys dataset along with Validation Status. 
 EXPORT Layout_PCRequestStatus := RECORD
   STRING3 SearchStatus;
	 Layout_PCSearchKey;
 END;

 EXPORT Layout_Soapcall_Response := RECORD
 	 Layout_PCDBResponse;
   STRING ErrorIndicator;  		
	 STRING Message;
   STRING2048 soapfault;
   UNSIGNED4 Latency{XPATH('_call_latency_ms')};
 END;

 EXPORT	Layout_faultRecord := RECORD
		STRING10 pFaultErrorCode;
		STRING1024 pFaultMessage;
 END;	
 
 EXPORT Layout_deltakey_personcontext := RECORD
    string20 LexID ;
    string50 RecId1 ;
    string50 RecId2 ;
    string50 RecId3 ;
    string50 RecId4 ;
		string50 CD_id;
    string50 DataGroup ;
    string5 RecordType ;
    unsigned5 DataTypeVersion ;
    string22 DateAdded ;
    string5 EventType ;
    string10 SourceSystem ;
    unsigned5 StatementSequence ;
    unsigned5 StatementId ;
    string Content { maxlength(3000)}; 
 END; 

	
	//Layouts for handling state code to numeric code conversion
	EXPORT Layout_StateCodes := RECORD
		STRING2 state;
		STRING codes;
	END;

END;

 