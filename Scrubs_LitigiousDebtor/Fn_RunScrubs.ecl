import scrubs,Scrubs_LitigiousDebtor,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('LitigiousDebtor','Scrubs_LitigiousDebtor','Scrubs_LitigiousDebtor','',pVersion,emailList,false);

end;