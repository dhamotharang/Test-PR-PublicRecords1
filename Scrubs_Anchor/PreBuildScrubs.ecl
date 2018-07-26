IMPORT ut, scrubs, _control,Orbit3SOA, SALT36,std,tools;

EXPORT PreBuildScrubs (string filedate ,string EmailList='') := FUNCTION

RETURN 	scrubs.ScrubsPlus('Anchor','Scrubs_anchor','Scrubs_email_data_anchor','',filedate,emailList,false);
								   
END;