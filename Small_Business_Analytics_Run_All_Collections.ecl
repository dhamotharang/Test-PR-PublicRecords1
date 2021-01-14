Import std, ut;

SBOM1601 := ScoringQA.BWR_Small_Business_Analytics_SBFE_SBOM_1601.elc;
SBBM1601 := ScoringQA.BWR_Small_Business_Analytics_SBFE_SBBM_1601.elc;
SLBO1702 := ScorignQA.BWR_Small_Business_Analytics_NonSBFE_SLBO1702_Attributes.ecl;
SLBB1702 :=ScorignQA.BWR_Small_Business_Analytics_NonSBFE_SLBB1702_Attributes.ecl;
SLBO1809 :=ScorignQA.BWR_Small_Business_Analytics_NonSBFE_SLBO1809_Attributes.ecl;
SLBB1809 := ScorignQA.BWR_Small_Business_Analytics_NonSBFE_SLBB1809_Attributes.ecl;

Sequential(SBOM1601, SBBM1601, SLBO1702, SLBB1702, SLBO1809, SLBB1809;):
:WHEN(CRON('38 14 * * *')), 
SUCCESS(FileServices.SendEmail('Noah.Lahr@lexisnexisrisk.com;', 'Small_Business_Analytics_Jobs_'+curr_date+'_1 Completed','The Completed workunit is:' + workunit)),
FAILURE(FileServices.SendEmail('Noah.Lahr@lexisnexisrisk.com; ', 'Small_Business_Analytics_Jobs_'+curr_date+'_1 Failed','The Failed workunit is:'   + workunit + FailMessage));
