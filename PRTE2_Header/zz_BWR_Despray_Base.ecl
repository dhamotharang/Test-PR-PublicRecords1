// PRTE2_Header.BWR_Despray_Base := 'todo';
//  - despray the Header Info base file for editing.

IMPORT PRTE2_Header as HDR;
IMPORT ut, PRTE2_Common;
#workunit('name', 'Boca CT Header Despray');

xdate	:= ut.GetDate;

// Choose if you want the DEV header records or the PROD records.
// CSV_NAME := 'Boca_Header_Alpha_New_Export_PROD_'+xdate+'.csv';
// Alpha_Base_DS := HDR.Files.HDR_BASE_ALPHA_DS_PROD;
CSV_NAME := 'Boca_Header_Alpha_New_Export_'+xdate+'.csv';
Alpha_Base_DS := HDR.Files.HDR_BASE_ALPHA_DS;

lzFilePathGatewayFile	:= HDR.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV								:= HDR.Files.HDR_CSV_FILE + '::' +  WORKUNIT;
EXPORT_DS							:= DEDUP(SORT(Alpha_Base_DS,DID),DID);

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, HDR.Constants.LandingZoneIP, lzFilePathGatewayFile);
