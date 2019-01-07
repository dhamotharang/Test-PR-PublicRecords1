/* ******************************************************************
PRTE2_X_Ins_DataCleanse.BWR_Search_Dids_in_INS_Datasets
****************************************************************** */

IMPORT PRTE2_Common,PRTE2_Email_Data_Ins,PRTE2_Header_Ins,PRTE2_LNProperty_Ins,PRTE2_Phonesplus_Ins,PRTE2_Alpha_Data;

MHDR363 := PRTE2_Alpha_Data.Files_Alpha.Boca_HDR_Dup363_DS;
SetOfdids363 := SET(MHDR363,did);

// The following have Insurance based dids ************************
// emailBase := PRTE2_Email_Data_Ins.Files.Email_Base_DS;
// HeaderBase := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
// LNPropBase := PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS;
// PhonesBase := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;
//******************************************************************


// The following have Insurance based dids ************************
emailBase := PRTE2_Email_Data_Ins.Files.Email_Base_DS_PROD(did in SetOfdids363);
HeaderBase := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod(did in SetOfdids363);
LNPropBase := PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS_Prod(did in SetOfdids363);
PhonesBase := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod(did in SetOfdids363);
//******************************************************************

OUTPUT(COUNT(emailBase),NAMED('C_emailBase'));
OUTPUT(emailBase,NAMED('emailBase'));
OUTPUT(COUNT(HeaderBase),NAMED('C_HeaderBase'));
OUTPUT(HeaderBase,NAMED('HeaderBase'));
OUTPUT(COUNT(LNPropBase),NAMED('C_LNPropBase'));
OUTPUT(LNPropBase,NAMED('LNPropBase'));
OUTPUT(COUNT(PhonesBase),NAMED('C_PhonesBase'));
OUTPUT(PhonesBase,NAMED('PhonesBase'));

dateString	:= PRTE2_Common.Constants.TodayString + '';
//**********************************************************************
NameHDR 			:= 'Header_363_'+dateString+'.csv';
NameLNP 			:= 'LNProp_363_'+dateString+'.csv';
NameEML 			:= 'Email_363_'+dateString+'.csv';
NamePH 			:= 'Phone_363_'+dateString+'.csv';
HDRPath := PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + NameHDR;
LNPPath := PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + NameLNP;
PHPath := PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + NamePH;
EMLPath := PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + NameEML;
LandingZoneIP := PRTE2_Header_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Header_Ins.Files.FILE_SPRAY_NAME+'1';
TempCSV2				:= PRTE2_Header_Ins.Files.FILE_SPRAY_NAME+'2';
TempCSV3				:= PRTE2_Header_Ins.Files.FILE_SPRAY_NAME+'3';
TempCSV4				:= PRTE2_Header_Ins.Files.FILE_SPRAY_NAME+'4';
// ---------------------------------------------------------------------------------
PRTE2_Common.DesprayCSV(HeaderBase, TempCSV1, LandingZoneIP, HDRPath);
PRTE2_Common.DesprayCSV(LNPropBase, TempCSV2, LandingZoneIP, LNPPath);
PRTE2_Common.DesprayCSV(emailBase, TempCSV3, LandingZoneIP, EMLPath);
PRTE2_Common.DesprayCSV(PhonesBase, TempCSV4, LandingZoneIP, PHPath);