import scrubs,scrubs_overrides,Scrubs_Headers_Monthly,Scrubs_LN_PropertyV2_Assessor,Scrubs_LN_PropertyV2_Deed,ln_propertyv2,
Scrubs_LN_PropertyV2_Search,Scrubs_LiensV2,Scrubs_bk_main,Scrubs_bk_search,Scrubs_email_data,Scrubs_Prof_License_Mari,Scrubs_American_Student_List,
Scrubs_Prof_License,Scrubs_sexoffender_main,Scrubs_sexoffender_offense,Scrubs_Watercraft_Search,Advo,Scrubs_Crim,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('Overrides','Scrubs_Overrides','Scrubs_Overrides_Flag','Flag',pVersion,emailList,false,true),
scrubs.ScrubsPlus('Overrides','Scrubs_Overrides','Scrubs_Overrides_PCR_PII','PCR_PII',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_HeaderScrubsInput,'Header','Scrubs_Headers_Monthly','Scrubs_Overrides_Headers_Monthly','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_PropertyAssessmentScrubs,'LN_PropertyV2','Scrubs_LN_PropertyV2_Assessor','Scrubs_Overrides_LN_PropertyV2_Assessor','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_PropertyDeedScrubs,'LN_PropertyV2','Scrubs_LN_PropertyV2_Deed','Scrubs_Overrides_LN_PropertyV2_Deed','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_PropertySearchScrubs,'LN_PropertyV2','Scrubs_LN_PropertyV2_Search','Scrubs_Overrides_LN_PropertyV2_Search','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_LiensParty,'LiensV2','Scrubs_LiensV2','Scrubs_Overrides_Liens_Party','party',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_LiensMain,'LiensV2','Scrubs_LiensV2','Scrubs_Overrides_Liens_Main','main',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_bankrupt_filing,'bk_main','Scrubs_bk_main','Scrubs_Overrides_bk_main','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_bankrupt_Search,'bk_search','Scrubs_bk_search','Scrubs_Overrides_bk_search','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_email_data,'email_data','Scrubs_email_data','Scrubs_Overrides_email_data','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_ProfLicMari,'Prof_License_Mari','Scrubs_Prof_License_Mari','Scrubs_Overrides_Prof_License_Mari','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_Student_New,'American_Student_List','Scrubs_American_Student_List','Scrubs_Overrides_American_Student_List','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_ProfLic,'Prof_License','Scrubs_Prof_License','Scrubs_Overrides_Prof_License','Base',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_SOff,'sexoffender_main','Scrubs_sexoffender_main','Scrubs_Overrides_sexoffender_main','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_SOffOffense,'sexoffender_offense','Scrubs_sexoffender_offense','Scrubs_Overrides_sexoffender_offense','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_Student,'American_Student_List','Scrubs_American_Student_List','Scrubs_Overrides_Student','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_Watercraft,'Watercraft_Search','Scrubs_Watercraft_Search','Scrubs_Overrides_Watercraft_Search','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_Advo,'Advo','Advo','Scrubs_Overrides_Advo','',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_CrimOffenders,'Crim','Scrubs_Crim','Scrubs_Overrides_Crim_Moxie_Crim_Offender2_Dev','Moxie_Crim_Offender2_Dev',pVersion,emailList,false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.OutsideFiles.file_CourtOffenses,'Crim','Scrubs_Crim','Scrubs_Overrides_Crim_Moxie_Court_Offenses_Dev','Moxie_Court_Offenses_Dev',pVersion,emailList,false,true),
scrubs.ScrubsPlus('Overrides','Scrubs_Overrides','Scrubs_Overrides_IndFlag','IndFlag',pVersion,emailList,false,true)
);

end;