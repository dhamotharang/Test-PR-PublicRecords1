import scrubs,Scrubs_SalesChannel,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('SalesChannel','Scrubs_SalesChannel','Scrubs_SalesChannel','',pVersion,emailList,false);

end;