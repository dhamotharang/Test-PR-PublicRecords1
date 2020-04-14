import scrubs,Scrubs_Diversity_Certification,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion = '20200402', string emailList = '') := function

    return scrubs.ScrubsPlus('Diversity_Certification','Scrubs_Diversity_Certification','Scrubs_Diversity_Certification','',pVersion,emailList,false);

end;