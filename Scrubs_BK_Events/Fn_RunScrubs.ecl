import scrubs,Scrubs_BK_Events,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('BK_Events','Scrubs_BK_Events','Scrubs_BK_Events','',pVersion,emailList,false);

end;