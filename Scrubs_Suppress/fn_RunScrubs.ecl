import scrubs,Scrubs_Suppress,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('Suppress','Scrubs_Suppress','Scrubs_Suppress_New','New',pVersion,emailList,false);

end;