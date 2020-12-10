import scrubs,Scrubs_tris_lnssi,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('tris_lnssi','Scrubs_tris_lnssi','Scrubs_tris_lnssi','',pVersion,emailList,false);

end;