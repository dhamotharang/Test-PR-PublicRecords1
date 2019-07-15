import ut, scrubs, _control,Orbit3SOA, SALT36,std,tools;

EXPORT PostBuildScrubs(string filedate ,string EmailList='') := FUNCTION

return 	scrubs.ScrubsPlus('bank_routing','Scrubs_bank_routing','Scrubs_bank_routing','',filedate,emailList,false);
								   
end;