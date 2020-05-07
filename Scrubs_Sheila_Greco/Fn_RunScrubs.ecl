import scrubs,Scrubs_Sheila_Greco;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('Sheila_Greco','Scrubs_Sheila_Greco','Scrubs_Sheila_Greco','',pVersion,emailList,false);

end;