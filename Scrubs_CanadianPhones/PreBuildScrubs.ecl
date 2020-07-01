IMPORT ut, scrubs, _control,Orbit3SOA, SALT36,std,tools;

EXPORT PreBuildScrubs (string filedate ,string EmailList='') := FUNCTION

RETURN 	scrubs.ScrubsPlus('CanadianPhones','Scrubs_CanadianPhones','Scrubs_CanadianPhones_InfutorWP','InfutorWP',filedate,emailList,false);
								   
END;