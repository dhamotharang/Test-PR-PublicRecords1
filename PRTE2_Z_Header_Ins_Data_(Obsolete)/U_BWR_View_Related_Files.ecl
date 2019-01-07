/* **************************************************************************************
PRTE2_Header_Ins_Data_Work.U_BWR_View_Related_Files
		Quick list of IHDR/BHDR related files.
		BHDR
		remote IHDR
		remote MHDR
************************************************************************************** */
IMPORT PRTE2_Header_Ins,PRTE2_Header_Ins_Data_Work,PRTE2_Alpha_Data;

BHDR_D := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
OUTPUT(BHDR_D,NAMED('BHDR_D'));
OUTPUT(COUNT(BHDR_D),NAMED('C_BHDR_D'));

BHDR_P := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_Prod;
OUTPUT(BHDR_P,NAMED('BHDR_P'));
OUTPUT(COUNT(BHDR_P),NAMED('C_BHDR_P'));

IHDR := SORT(PRTE2_Alpha_Data.Files_Alpha.InsHeadDLDeath_Base_DS_Prod,uniqueID);
OUTPUT(IHDR,NAMED('IHDR'));
OUTPUT(COUNT(IHDR),NAMED('C_IHDR'));

IHDR2 := CHOOSEN(PRTE2_Alpha_Data.Files_Alpha.InsHead_Base_DS_PROD,500)(fb_src='EXPERIAN');
OUTPUT(IHDR2,NAMED('IHDR2'));
OUTPUT(COUNT(IHDR2),NAMED('C_IHDR2'));

MHDR_ORIG := SORT(PRTE2_Alpha_Data.Files_Alpha.Merged_Headers_DS,id);
OUTPUT(MHDR_ORIG,NAMED('MHDR_ORIG'));
OUTPUT(COUNT(MHDR_ORIG),NAMED('C_MHDR_ORIG'));

MHDR_NewPS := SORT(PRTE2_Alpha_Data.Files_Alpha.PS_Merged_Headers_DS,id);
OUTPUT(MHDR_NewPS,NAMED('MHDR_NewPS'));
OUTPUT(COUNT(MHDR_NewPS),NAMED('C_MHDR_NewPS'));
