//With automation, I'll have many ECL calls for different files. This attribute file will contain all the datasets. 
//when this is merged into git, I'll have to update the path where the file resides, i.e.,  DI_Metrics.FCRA_ASL_Students
//pHostname := 'uspr-edata12.risk.regn.net'
//pTarget := '/data/Builds/builds/DI_Metrics/'
//pContact := 'cleophus.johnson@lexisnexisrisk.com'

export DI_Metrics(string pHostname, string pTarget, string pContact ='\' \'') := function

today := (STRING8)STD.Date.Today();

build_all := SEQUENTIAL(

DI_Metrics.FCRA_ASL_Students(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Bankruptcy(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Criminal(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_EDA_GONG(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Liens_Judgments_Evictions(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_PAW(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_People_Header_and_Prof_Licenses(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Property_By_DocType(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Property_By_LandUse(pHostname, pTarget, pContact, today)

,DI_Metrics.FCRA_Watercraft(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_ASL_Students(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Bankruptcy(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_BIP_Corps(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Criminal(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_EDA_Gong(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Liens_Judgments(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_LiensV2_Evictions(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_PAW(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_PeopleHeader_and_Prof_Licenses(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Property_Deeds_By_DocType(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Property_Tax_By_LandUse(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_QueryHeaderStatsWatchdogHdr(pHostname, pTarget, pContact, today)

,DI_Metrics.NonFCRA_Watercraft(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_AccidentReports(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Criminal(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_DeathMaster(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_DriversLicenses(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Emails(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Evictions(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_FAA(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Foreclosure(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Marriage_Divorce(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Phones(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Professional_Licenses(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Students(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_UCC(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Utility(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Vehicles(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Voters(pHostname, pTarget, pContact, today)

,DI_Metrics.ChartsGeoMaps_Watercraft(pHostname, pTarget, pContact, today)

,DI_Metrics.Monthly_Cortera_Tradeline_Metrics.Cortera_Tradeline_Metrics(pHostname, pTarget, pContact, today)

,DI_Metrics.FDN_Metrics(pHostname, pTarget, pContact, today)

,DI_Metrics.InquiryRpts_bwrFCRAInq41(pHostname, pTarget, pContact, today)

,DI_Metrics.InquiryRpts_bwrFCRAInq50(pHostname, pTarget, pContact, today)

,DI_Metrics.InquiryRpts_bwrNonFCRAInq41(pHostname, pTarget, pContact, today)

,DI_Metrics.InquiryRpts_bwrNonFCRAInq50(pHostname, pTarget, pContact, today)

);

return build_all;

end;