import ut, scrubs, _control,Orbit3SOA, SALT33,std,tools;

EXPORT BaseBuildScrubs(string filedate, string emailList='') := FUNCTION

return scrubs.ScrubsPlus('Patriot','Scrubs_Patriot','Scrubs_Patriot','',filedate,emailList,false);

end;
