IMPORT scrubs,Scrubs_Suppress,std,ut,tools;
EXPORT fn_RunScrubs_OptOut(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('Suppress','Scrubs_Suppress','Scrubs_Suppress_OptOut','OptOut',pVersion,emailList,false);

end;