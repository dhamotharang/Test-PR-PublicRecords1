import scrubs,Scrubs_TelcordiaTPM,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('TelcordiaTPM','Scrubs_TelcordiaTPM','Scrubs_TelcordiaTPM','',pVersion,emailList,false);

end;