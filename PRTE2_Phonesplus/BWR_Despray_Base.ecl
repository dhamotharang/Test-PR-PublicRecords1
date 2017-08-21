// --------------------------------------------------------------------------------
//  PRTE2_Phonesplus.BWR_Despray_Base 
//  This is for despraying base data to csv file
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Phonesplus, PRTE2_Common;
#workunit('name', 'Boca PRTE2 PhonesPlus Despray');

dateString			:= ut.GetDate;

desprayName := 'PhonesPlus_Csv_DEV_'+dateString+'.csv';
EXPORT_DS		:=	PRTE2_Phonesplus.Files.PhonesPlus_CSV_SF_DS;

// desprayName	:= 'PhonesPlus_Base_DEV_'+dateString+'.csv';
// EXPORT_DS		:=	PRTE2_Phonesplus.Files.PhonesPlus_Base_SF_DS;

// desprayName	:= 'PhonesPlus_Base_PROD_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Phonesplus.Files.PhonesPlus_Base_SF_DS_PROD,l_did); //Prod file.

// desprayName 				:= 'PhonesPlus_Csv_DEV_'+dateString+'.csv';
// EXPORT_DS	:=	PRTE2_Phonesplus.u_Files.INITIAL_PPLUS_CSV_DS; 							// New initial data 
// EXPORT_DS	:=	PRTE2_Phonesplus.u_Files.INITIAL_PPLUS_CSV_update1_DS; 			// New initial data after update1


LandingZoneIP 	:= PRTE2_Phonesplus.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Phonesplus.Files.FILE_DESPRAY_CSV + '::' +  WORKUNIT;
lzFilePathGatewayFile	:= PRTE2_Phonesplus.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);
