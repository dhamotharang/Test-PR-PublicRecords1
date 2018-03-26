// PRTE2_Liens_Ins_DataPrep.U_Gather_Filing_Types


STRING dateString := PRTE2_Common.Constants.TodayString+'';

CA1 := LiensV2_preprocess.Files_lkp.filing_type, named('CA_FilingType');
CA2 := LiensV2_preprocess.Files_lkp.change_filing, named('CA_ChangeFilingType');
HG1 := LiensV2_preprocess.Files_lkp.HGFiling_type, named('HG_FilingType');


LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
TempCSV3				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_3';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

desprayName1	:= 'CA_FilingType_'+dateString+'.csv';
desprayName2  := 'CA_ChangeFilingType_'+dateString+'.csv';
desprayName3  := 'HG_FilingType_'+dateString+'.csv';
PRTE2_Common.DesprayCSV(CA1, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(CA2, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
PRTE2_Common.DesprayCSV(HG1, TempCSV3, LandingZoneIP, pathFile+desprayNameParty);