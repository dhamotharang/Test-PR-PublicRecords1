// --------------------------------------------------------------------------------
//  PRTE2_Email_Data.Z_BWR_Despray_Base 
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Email_Data, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Emails Despray');

dateString			:= ut.GetDate;
TempCSV					:= PRTE2_Email_Data.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;

desprayName 		:= 'Email_Data_Despray_newBase'+dateString+'.csv';
// DS := DATASET('~prte::ct::base::email_alpha_generated::email_data', PRTE2_Email_Data.Layouts.base,THOR);                    // 44,399
// DS := DATASET('~prte::ct::base::email_alpha_generated::email_data_addNancyMissing', PRTE2_Email_Data.Layouts.base,THOR);    //2082
DS := DATASET('~prte::ct::base::email_alpha_generated::email_data_All_withTestData', PRTE2_Email_Data.Layouts.base,THOR);    //47,377

// EXPORT_DS	      := PRTE2_Email_Data.Files.FINAL_DS + DS;  //46,544
// EXPORT_DS	      := PRTE2_Email_Data.Files.Alpha_12_DS_PROD + DS;  //47,389
EXPORT_DS	      := DS;  //47,377

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Common.Constants.EDATA11;
lzFilePathGatewayFile	:= PRTE2_Email_Data.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

