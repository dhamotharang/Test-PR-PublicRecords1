import scrubs,scrubs_overrides,Scrubs_Headers_Monthly,Scrubs_LN_PropertyV2_Assessor,ln_propertyv2,std,ut,tools;

EXPORT fnRunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('Overrides','Scrubs_Overrides','Scrubs_Overrides_Flag','Flag',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false,true),
scrubs.ScrubsPlus('Overrides','Scrubs_Overrides','Scrubs_Overrides_PCR_PII','PCR_PII',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.file_HeaderScrubsInput,'Header','Scrubs_Headers_Monthly','Scrubs_Overrides_Scrubs_Headers_Monthly','',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.file_PropertyAssessmentScrubs,'LN_PropertyV2','Scrubs_LN_PropertyV2_Assessor','Scrubs_LN_PropertyV2_Assessor','',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false,true),
scrubs.ScrubsPlus_PassFile(Scrubs_Overrides.file_PropertyAssessmentScrubs,'LN_PropertyV2','Scrubs_LN_PropertyV2_Deed','Scrubs_LN_PropertyV2_Deed','',((String)Std.Date.Today())+'a','david.dittman@lexisnexis.com',false,true)
);

end;