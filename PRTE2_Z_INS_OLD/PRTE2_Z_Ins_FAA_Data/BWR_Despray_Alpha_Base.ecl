// --------------------------------------------------------------------------------
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_FAA_Data, PRTE2_Common;
#workunit('name', 'Boca PRTE2 FAA Despray');

dateString			:= ut.GetDate+'';
TempCSV_aircraft_reg	:= PRTE2_FAA_Data.Files.FILE_DESPRAY_aircraft_reg_CSV + '::' +  WORKUNIT;
TempCSV_airmen	      := PRTE2_FAA_Data.Files.FILE_DESPRAY_airmen_CSV + '::' +  WORKUNIT;
TempCSV_airmen_certs	:= PRTE2_FAA_Data.Files.FILE_DESPRAY_airmen_certs_CSV + '::' +  WORKUNIT;

desprayName_aircraft_reg 		:= 'FAA_Data_Despray_newBase_aircraft_reg'+dateString+'.csv';
desprayName_airmen 		      := 'FAA_Data_Despray_newBase_airmen'+dateString+'.csv';
desprayName_airmen_certs 		:= 'FAA_Data_Despray_newBase_airmen_certs'+dateString+'.csv';

EXPORT_aircraft_reg_DS	    := PRTE2_FAA_Data.files.FAA_aircraft_reg_Base_SF_DS;
EXPORT_airmen_DS	          := PRTE2_FAA_Data.files.FAA_airmen_Base_SF_DS;
EXPORT_airmen_certs_DS	    := PRTE2_FAA_Data.files.FAA_airmen_certs_Base_SF_DS;

// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Common.Constants.EDATA11;

lzFilePathGatewayFile_aircraft_reg	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_aircraft_reg;
lzFilePathGatewayFile_airmen      	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_airmen;
lzFilePathGatewayFile_airmen_certs	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_airmen_certs;

PRTE2_Common.DesprayCSV(EXPORT_aircraft_reg_DS, TempCSV_airmen, LandingZoneIP, lzFilePathGatewayFile_aircraft_reg);
PRTE2_Common.DesprayCSV(EXPORT_airmen_DS, TempCSV_airmen, LandingZoneIP, lzFilePathGatewayFile_airmen);
PRTE2_Common.DesprayCSV(EXPORT_airmen_certs_DS, TempCSV_airmen_certs, LandingZoneIP, lzFilePathGatewayFile_airmen_certs);

