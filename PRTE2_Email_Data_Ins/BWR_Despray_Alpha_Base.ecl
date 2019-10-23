/* *******************************************************************************************************
PRTE2_Email_Data_Ins.BWR_Despray_Alpha_Base

Nov 2017 - re-write to new LZ and base layouts
******************************************************************************************************* */
// --------------------------------------------------------------------------------
//  PRTE2_Email_Data_Ins.Z_BWR_Despray_Base 
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT PRTE2_Email_Data_Ins, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Emails Despray');

fileVersion := PRTE2_Common.Constants.TodayString+'';
TempCSV					:= PRTE2_Email_Data_Ins.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 		:= 'Email_V2_Dev_AfterAdds'+fileVersion+'.csv';
EXPORT_DS	      := SORT(PRTE2_Email_Data_Ins.Files.Email_Base_DS,did,clean_email);
// desprayName 		:= 'Email_V2_Base_PROD_'+fileVersion+'.csv';
// EXPORT_DS	      := SORT(PRTE2_Email_Data_Ins.Files.Email_Base_DS_PROD,did,clean_email);

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Common.Constants.InsLandingZone;
lzFilePathGatewayFile	:= PRTE2_Email_Data_Ins.Constants.SourcePathForCSV + desprayName;
InsLandingPathPrefix 	:= PRTE2_Common.Constants.InsLandingPathPrefix;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

