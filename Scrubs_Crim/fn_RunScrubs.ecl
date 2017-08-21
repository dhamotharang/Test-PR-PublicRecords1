import scrubs,scrubs_crim,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_AddressHistory_Arrests','address_history_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_AddressHistory_Counties','addresshistory_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_AddressHistory_Doc','addresshistory_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_AddressHistory','addresshistory',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Alias_Arrests','alias_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Alias_Counties','alias_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Alias_Doc','alias_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Alias','alias',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Charge_Arrests','charge_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Charge_Counties','charge_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Charge_Doc','charge_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Charge','charge',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Defendant_Arrests','defendant_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Defendant_Counties','defendant_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Defendant_Doc','defendant_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Defendant','defendant',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Offense_Arrests','offense_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Offense_Counties','offense_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Offense_Doc','offense_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Offense','offense',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Priors_Doc','priors_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Sentence_Arrests','sentence_arrests',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Sentence_Counties','sentence_counties',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Sentence_Doc','sentence_doc',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Sentence','sentence',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_Court_Offenses_Dev','Moxie_Court_Offenses_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_Crim_Offender2_Dev','Moxie_Crim_Offender2_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_DOC_Offenses_Dev','Moxie_DOC_Offenses_Dev',pVersion,emailList,false),
scrubs.ScrubsPlus('crim','Scrubs_Crim','Scrubs_Crim_Moxie_DOC_Punishment_Dev','Moxie_DOC_Punishment_Dev',pVersion,emailList,false)
);

end;