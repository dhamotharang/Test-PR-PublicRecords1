import scrubs,scrubs_crim,std,ut,tools,hygenics_crim;

EXPORT fn_RunScrubsBase(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_Court_Offenses_Dev','Moxie_Court_Offenses_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_Crim_Offender2_Dev','Moxie_Crim_Offender2_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_DOC_Offenses_Dev','Moxie_DOC_Offenses_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_DOC_Punishment_Dev','Moxie_DOC_Punishment_Dev',pVersion,emailList,false)
);

end;