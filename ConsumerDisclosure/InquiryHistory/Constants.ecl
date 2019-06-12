IMPORT AutoKeyI;

EXPORT Constants := MODULE

    EXPORT MaxIHperLexId := 10000;  // used to pull data from index
    
    EXPORT  ESP_Method          := 'FCRAInquiryHistoryDeltabase';
    EXPORT  ResultStructure     := 'FCRAInquiryHistoryDeltabaseResponseEx';
    
    EXPORT INTEGER 	SOAPWaitTime 	:= 4;
    EXPORT INTEGER 	SOAPCallRetry := 1;


END;    //  Constants MODULE