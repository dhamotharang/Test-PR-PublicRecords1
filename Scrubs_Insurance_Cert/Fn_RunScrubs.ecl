import scrubs,Scrubs_Insurance_Cert,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return sequential(
        scrubs.ScrubsPlus('Insurance_Cert','Scrubs_Insurance_Cert','Scrubs_Insurance_Cert_Cert','Cert',pVersion,emailList,false),
        scrubs.ScrubsPlus('Insurance_Cert','Scrubs_Insurance_Cert','Scrubs_Insurance_Cert_Pol','Pol',pVersion,emailList,false)
    );

end;