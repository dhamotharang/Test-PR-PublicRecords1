IMPORT _control;

EXPORT Constants := MODULE

    EXPORT MaxIHperLexId := 10000;  // used to pull data from index

    EXPORT StatusCodes := MODULE
        EXPORT  NoSearchRecords     := 401;       //  no valid lexids in the request
        EXPORT  ResultsFound        := 501;       //  found records for at least 1 lexid in the request
        EXPORT  NoResultsFound      := 503;       //  no records found for valid lexid(s)
    END;    //  StatusCodes MODULE

    EXPORT Messages := MODULE
        EXPORT  NoSearchRecordsMsg  := 'NO VALID INPUT SEARCH KEYS PROVIDED';   // for 401
        EXPORT  ResultsFoundMsg     := 'RESULTS FOUND';                         // for 501
        EXPORT  NoResultsFoundMsg   := 'NO RESULTS FOUND';                      // for 503

    END;    //  Messages MODULE
    
    EXPORT GetStatusMesage(INTEGER __code) := CASE(__code, 
                                                  StatusCodes.NoSearchRecords => Messages.NoSearchRecordsMsg, 
                                                  StatusCodes.ResultsFound => Messages.ResultsFoundMsg, 
                                                  StatusCodes.NoResultsFound => Messages.NoResultsFoundMsg, 
                                                  '');
    
    EXPORT  ESP_Method          := 'FCRAInquiryHistoryDeltabase';
    EXPORT  ResultStructure     := 'FCRAInquiryHistoryDeltabaseResponseEx';
    
    EXPORT INTEGER 	SOAPWaitTime 	:= 4;
    EXPORT INTEGER 	SOAPCallRetry := 1;


END;    //  Constants MODULE