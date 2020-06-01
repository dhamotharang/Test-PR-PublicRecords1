import scrubs,Scrubs_Diversity_Certification,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList = '') := function

    return scrubs.ScrubsPlus('Diversity_Certification','Scrubs_Diversity_Certification','Scrubs_Diversity_Certification_Input','Input',pVersion,emailList,false);

end;