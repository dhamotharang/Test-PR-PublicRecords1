import scrubs,Scrubs_Sheila_Greco;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return sequential(
        scrubs.ScrubsPlus('Sheila_Greco','Scrubs_Sheila_Greco','Scrubs_Sheila_Greco_Companies','Companies',pVersion,emailList,false),
        scrubs.ScrubsPlus('Sheila_Greco','Scrubs_Sheila_Greco','Scrubs_Sheila_Greco_Contacts','Contacts',pVersion,emailList,false)
    );

end;