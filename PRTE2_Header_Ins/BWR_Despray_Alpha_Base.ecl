// PRTE2_Header_Ins.BWR_Despray_Base := 'todo';
//  - despray the Header Info base file for editing.

IMPORT PRTE2_Header_Ins, ut, PRTE2_Common;
#workunit('name', 'Boca CT Header Despray');

xdate	:= ut.GetDate;

CSV_NAME := 'PersonHeader_Alpha_Base_DEV_'+xdate+'.csv';
Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
// CSV_NAME := 'PersonHeader_Alpha_Base_PROD_'+xdate+'.csv';
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_PROD;

lzFilePathGatewayFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;
EXPORT_DS							:= DEDUP(SORT(Alpha_Base_DS,DID),DID);

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);
