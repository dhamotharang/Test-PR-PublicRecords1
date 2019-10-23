import scrubs,Scrubs_PCNSR,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('PCNSR','Scrubs_PCNSR','Scrubs_PCNSR','',pVersion,emailList,false);

end;