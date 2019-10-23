IMPORT ut, scrubs, _control,Orbit3SOA, SALT311,std,tools;

EXPORT Scrubs_InputFiles(string filedate ,string EmailList='') := FUNCTION

RETURN 	scrubs.ScrubsPlus('Dunndata_Consumer','Scrubs_Dunndata_Consumer','Scrubs_Dunndata_Consumer','',filedate,emailList,false);
								   
end;