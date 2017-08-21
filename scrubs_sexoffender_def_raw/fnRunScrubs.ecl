import scrubs,scrubs_sexoffender_def_raw,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('sexoffender_def_raw','scrubs_sexoffender_def_raw','Scrubs_Sexoffender_Def_Raw','',pVersion,emailList,false);

end;