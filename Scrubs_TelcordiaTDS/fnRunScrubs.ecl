import scrubs,Scrubs_TelcordiaTDS,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('TelcordiaTDS','Scrubs_TelcordiaTDS','Scrubs_TelcordiaTDS','',pVersion,emailList,false);

end;