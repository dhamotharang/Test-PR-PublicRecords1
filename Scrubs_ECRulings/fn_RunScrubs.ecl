import scrubs,Scrubs_ECRulings,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('ECRulings','Scrubs_ECRulings','Scrubs_ECRulings','',pVersion,emailList,false);

end;