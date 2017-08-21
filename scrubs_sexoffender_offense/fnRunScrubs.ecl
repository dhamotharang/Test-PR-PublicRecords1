import scrubs,scrubs_sexoffender_offense,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('sexoffender_offense','scrubs_sexoffender_offense','ScrubsAlerts_Sexoffender_Offense','',pVersion,emailList,false);

end;