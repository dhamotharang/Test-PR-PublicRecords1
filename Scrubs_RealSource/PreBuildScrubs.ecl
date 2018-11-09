IMPORT ut, scrubs, _control,Orbit3SOA, SALT36,std,tools;

EXPORT PreBuildScrubs (string filedate ,string EmailList='') := FUNCTION

RETURN 	scrubs.ScrubsPlus('RealSource','Scrubs_realsource','Scrubs_email_data_realsource','',filedate,emailList,false);
								   
END;