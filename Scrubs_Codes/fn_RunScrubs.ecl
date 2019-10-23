import scrubs,Scrubs_Codes,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return scrubs.ScrubsPlus('Codes','Scrubs_Codes','Scrubs_CodesV3','CodesV3',pVersion,emailList,false);

end;