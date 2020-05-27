import scrubs,Scrubs_SalesChannel;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('WorldCheck','Scrubs_WorldCheck','Scrubs_WorldCheck','',pVersion,emailList,false);

end;