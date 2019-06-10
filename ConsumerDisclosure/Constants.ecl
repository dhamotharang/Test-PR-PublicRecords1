IMPORT AutoKeyI;

EXPORT Constants := MODULE

  EXPORT StatusCodes := MODULE
    EXPORT  ResultsFound     := 0;      
    EXPORT  NoResultsFound   := AutoKeyI.errorcodes._codes.NO_RECORDS;       
	  EXPORT  SOAPError        := AutoKeyI.errorcodes._codes.SOAP_ERR;
  END;    
    
  EXPORT GetStatusMessage(INTEGER __code) := AutoKeyI.errorcodes._msgs(__code);

END;