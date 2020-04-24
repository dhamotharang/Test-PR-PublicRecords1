import scrubs,Scrubs_eMerges,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return sequential(
        scrubs.ScrubsPlus('eMerges','Scrubs_eMerges','Scrubs_eMerges_Hunters','Hunters',pVersion,emailList,false);
        scrubs.ScrubsPlus('eMerges','Scrubs_eMerges','Scrubs_eMerges_Voters','Voters',pVersion,emailList,false);
        scrubs.ScrubsPlus('eMerges','Scrubs_eMerges','Scrubs_eMerges_HVCCW','HVCCW',pVersion,emailList,false);
    );

end;