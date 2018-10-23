IMPORT AutoKeyI;

EXPORT Constants := MODULE

    EXPORT MaxIHperLexId := 10000;  // used to pull data from index
    
    EXPORT StatusCodes := MODULE
        EXPORT  ResultsFound        := 0;       //  found records for at least 1 lexid in the request
        EXPORT  NoResultsFound      := AutoKeyI.errorcodes._codes.NO_RECORDS;       //  no records found for valid lexid(s)
	      EXPORT  SOAPError           := AutoKeyI.errorcodes._codes.SOAP_ERR;
    END;    //  StatusCodes MODULE

    
    EXPORT GetStatusMessage(INTEGER __code) := AutoKeyI.errorcodes._msgs(__code);
    
    EXPORT  ESP_Method          := 'FCRAInquiryHistoryDeltabase';
    EXPORT  ResultStructure     := 'FCRAInquiryHistoryDeltabaseResponseEx';
    
    EXPORT INTEGER 	SOAPWaitTime 	:= 4;
    EXPORT INTEGER 	SOAPCallRetry := 1;


END;    //  Constants MODULE