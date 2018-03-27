/* ******************************************************************
PRTE2_X_Ins_DataCleanse.BWR_List_All_Ins_Bases
****************************************************************** */

IMPORT PRTE2_Email_Data_Ins,PRTE2_Header_Ins,PRTE2_Liens_Ins,PRTE2_LNProperty_Ins,PRTE2_Phonesplus_Ins,PRTE2_PropertyInfo_Ins,PRTE2_WaterCraft_Ins;

// The following have Insurance based dids ************************
// emailBase := PRTE2_Email_Data_Ins.Files.Email_Base_DS;
// HeaderBase := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
// LNPropBase := PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS;
// PhonesBase := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;
//******************************************************************


// The following have Insurance based dids ************************
emailBase := PRTE2_Email_Data_Ins.Files.Email_Base_DS_PROD;
HeaderBase := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod;
LNPropBase := PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS_Prod;
PhonesBase := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS_Prod;
//******************************************************************


// NO did REFERENCE APPEARS HERE ***********************************
// LnJBase := PRTE2_Liens_Ins.Files.Party_Base_SF_DS;
// LnJBase := PRTE2_Liens_Ins.Files.Main_Base_SF_DS;
// PropInfoBase := PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS;
//******************************************************************

// NO did REFERENCE APPEARS HERE ***********************************
LnJBase1 := PRTE2_Liens_Ins.Files.Party_Base_DS_Prod;
LnJBase2 := PRTE2_Liens_Ins.Files.Main_DS_Prod;
PropInfoBase := PRTE2_PropertyInfo_Ins.Files.PII_ALPHA_BASE_SF_DS_Prod;
//******************************************************************



// Has did references but they are not Insurance values *************
// WaterBase := PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal;
WaterBase := PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal_Prod;
//******************************************************************

OUTPUT(emailBase,NAMED('emailBase'));
OUTPUT(HeaderBase,NAMED('HeaderBase'));
OUTPUT(LnJBase1,NAMED('LnJBase1'));
OUTPUT(LnJBase2,NAMED('LnJBase2'));
OUTPUT(LNPropBase,NAMED('LNPropBase'));
OUTPUT(PhonesBase,NAMED('PhonesBase'));
OUTPUT(WaterBase,NAMED('WaterBase'));
OUTPUT(PropInfoBase,NAMED('PropInfoBase'));
