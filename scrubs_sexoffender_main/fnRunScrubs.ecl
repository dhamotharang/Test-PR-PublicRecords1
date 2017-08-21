import scrubs,scrubs_sexoffender_main,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('sexoffender_main','scrubs_sexoffender_main','ScrubsAlerts_Sexoffender_Main','',pVersion,emailList,false);

end;