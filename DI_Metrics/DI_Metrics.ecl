﻿//With automation, I'll have many ECL calls for different files. This attribute file will contain all the datasets. 
//when this is merged into git, I'll have to update the path where the file resides, i.e.,  DI_Metrics.FCRA_ASL_Students
//pHostname := 'uspr-edata12.risk.regn.net'
//pTarget := '/data/Builds/builds/DI_Metrics/'
//pContact := 'cleophus.johnson@lexisnexisrisk.com'

export DI_Metrics(string pHostname, string pTarget, string pContact ='\' \'') := function

build_all := SEQUENTIAL(

DI_Metrics.FCRA_ASL_Students(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Bankruptcy(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Criminal(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_EDA_GONG(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Liens_Judgments_Evictions(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_PAW(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_People_Header_and_Prof_Licenses(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Property_By_DocType(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Property_By_LandUse(pHostname, pTarget, pContact)

,DI_Metrics.FCRA_Watercraft(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_ASL_Students(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Bankruptcy(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_BIP_Corps(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Criminal(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_EDA_Gong(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Liens_Judgments(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_LiensV2_Evictions(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_PAW(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_PeopleHeader_and_Prof_Licenses(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Property_Deeds_By_DocType(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Property_Tax_By_LandUse(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_QueryHeaderStatsWatchdogHdr(pHostname, pTarget, pContact)

,DI_Metrics.NonFCRA_Watercraft(pHostname, pTarget, pContact)

DI_Metrics.ChartsGeoMaps_AccidentReports(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Criminal(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_DeathMaster(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_DriversLicenses(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Emails(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Evictions(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_FAA(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Foreclosure(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Marriage_Divorce(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Phones(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Professional_Licenses(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Students(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_UCC(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Utility(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Vehicles(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Voters(pHostname, pTarget, pContact)

,DI_Metrics.ChartsGeoMaps_Watercraft(pHostname, pTarget, pContact)

);

return build_all;

end;