import scrubs,Scrubs_Sheila_Greco;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return sequential(
        scrubs.ScrubsPlus('Sheila_Greco','Scrubs_Sheila_Greco','Scrubs_Sheila_Greco','Companies',pVersion,emailList,false),
        scrubs.ScrubsPlus('Sheila_Greco','Scrubs_Sheila_Greco','Scrubs_Sheila_Greco','Contacts',pVersion,emailList,false)
    );

end;