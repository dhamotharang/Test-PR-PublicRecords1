import scrubs,Scrubs_FCC,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('FCC','Scrubs_FCC','Scrubs_FCC_input','Input',pVersion,emailList,false);

end;