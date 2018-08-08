import scrubs,Scrubs_CityStateZip,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('CityStateZip','Scrubs_CityStateZip','Scrubs_CityStateZip','',pVersion,emailList,false);

end;