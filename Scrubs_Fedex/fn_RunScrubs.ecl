import scrubs,Scrubs_fedex,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('fedex','Scrubs_Fedex','Scrubs_Fedex','',pVersion,emailList,false);

end;