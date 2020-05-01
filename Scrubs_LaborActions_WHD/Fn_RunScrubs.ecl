import scrubs,Scrubs_LaborActions_WHD,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('LaborActions_WHD','Scrubs_LaborActions_WHD','Scrubs_LaborActions_WHD','',pVersion,emailList,false);

end;