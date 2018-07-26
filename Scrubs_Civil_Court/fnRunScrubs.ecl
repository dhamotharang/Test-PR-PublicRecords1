import scrubs,Scrubs_Civil_Court,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('Civil_Court','Scrubs_Civil_Court','Scrubs_Civil_Court_Matter','Matter',pVersion,emailList,false),
scrubs.ScrubsPlus('Civil_Court','Scrubs_Civil_Court','Scrubs_Civil_Court_Activity','Activity',pVersion,emailList,false),
scrubs.ScrubsPlus('Civil_Court','Scrubs_Civil_Court','Scrubs_Civil_Court_Party','Party',pVersion,emailList,false)
);

end;