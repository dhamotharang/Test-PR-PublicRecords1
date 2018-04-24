
/* ********************************************************************************************
PRTE2_Header_Ins.BWR_Despray_Alpha_Base
Need some re-write to use new LZ
Nov 2017, altered Constants for new LZ and this worked.
*********************************************************************************************** */

IMPORT PRTE2_Header_Ins, ut, PRTE2_Common;
#workunit('name', 'Boca CT Header Despray');

fileVersion	:= PRTE2_Common.Constants.TodayString+'';

//-----------------------------------------------------------------
// CSV_NAME := 'PersonHeader_Alpha_DEV_AfterAdds_'+fileVersion+'.csv';
// Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS;
CSV_NAME := 'PersonHeader_Alpha_Base_PROD_'+fileVersion+'.csv';
Alpha_Base_DS := PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS_PROD;
//-----------------------------------------------------------------

lzFilePathGatewayFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;
EXPORT_DS							:= DEDUP(SORT(Alpha_Base_DS,DID),DID);

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, lzFilePathGatewayFile);
