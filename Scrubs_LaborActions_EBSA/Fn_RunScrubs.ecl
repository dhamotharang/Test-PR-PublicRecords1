import scrubs,Scrubs_LaborActions_EBSA,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('LaborActions_EBSA','Scrubs_LaborActions_EBSA','Scrubs_LaborActions_EBSA','',pVersion,emailList,false);

end;