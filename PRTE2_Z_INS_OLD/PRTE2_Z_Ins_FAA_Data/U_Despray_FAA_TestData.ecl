// --------------------------------------------------------------------------------
//  This is for despraying base data to csv file 
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_FAA_Data, PRTE2_Common;
#workunit('name', 'Boca PRTE2 FAA Despray');

Files   := PRTE2_FAA_DATA.Files;
Layouts := PRTE2_FAA_DATA.Layouts;

dateString			:= ut.GetDate+'';
TempCSV_aircraft_reg	:= PRTE2_FAA_Data.Files.FILE_DESPRAY_aircraft_reg_CSV + '::TEMP::' +  WORKUNIT;
TempCSV_airmen	      := PRTE2_FAA_Data.Files.FILE_DESPRAY_airmen_CSV + '::TEMP::' +  WORKUNIT;
TempCSV_airmen_certs	:= PRTE2_FAA_Data.Files.FILE_DESPRAY_airmen_certs_CSV + '::TEMP::' +  WORKUNIT;

desprayName_aircraft_reg 		:= 'FAA_TestData_Despray_aircraft_reg'+dateString+'.csv';
desprayName_airmen 		      := 'FAA_TestData_Despray_airmen'+dateString+'.csv';
desprayName_airmen_certs 		:= 'FAA_TestData_Despray_airmen_certs'+dateString+'.csv';

EXPORT_aircraft_reg_DS	    := DATASET(PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp::qa::PRCT_Alpha_FAA_aircraft', Layouts.AlphaBase_aircraft_reg, THOR);
EXPORT_airmen_DS	          := DATASET(PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp::qa::PRCT_Alpha_FAA_airmen', Layouts.AlphaBase_airmen, THOR);
EXPORT_airmen_certs_DS	    := DATASET(PRTE2_FAA_DATA.Files.BASE_PREFIX_NAME+'::tmp::qa::PRCT_Alpha_FAA_airmen_certs', Layouts.AlphaBase_airmen_certs, THOR);


// NOTE: If Boca wants some other despray location edit these locations in the Constants ...
LandingZoneIP 	:= PRTE2_Common.Constants.EDATA11;

lzFilePathGatewayFile_aircraft_reg	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_aircraft_reg;
lzFilePathGatewayFile_airmen      	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_airmen;
lzFilePathGatewayFile_airmen_certs	:= PRTE2_FAA_Data.Constants.SourcePathForCSV + desprayName_airmen_certs;

PRTE2_Common.DesprayCSV(EXPORT_aircraft_reg_DS, TempCSV_airmen, LandingZoneIP, lzFilePathGatewayFile_aircraft_reg);
PRTE2_Common.DesprayCSV(EXPORT_airmen_DS, TempCSV_airmen, LandingZoneIP, lzFilePathGatewayFile_airmen);
PRTE2_Common.DesprayCSV(EXPORT_airmen_certs_DS, TempCSV_airmen_certs, LandingZoneIP, lzFilePathGatewayFile_airmen_certs);

