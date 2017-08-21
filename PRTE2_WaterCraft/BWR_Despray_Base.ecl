// PRTE2_WaterCraft.BWR_Despray_Base 
// --------------------------------------------------------------
// Use to despray the existing main (all data) base file
IMPORT PRTE2_Watercraft;
IMPORT ut, PRTE2_Common;
#WORKUNIT ('NAME', 'CT Watercraft_base_despray CSV');

dateString	:= ut.GetDate + '';
DEV_DS							:= PRTE2_Watercraft._Datasets.All;
PROD_DS							:= PRTE2_Watercraft._Datasets.All_Prod;

//***** Alter Values in here *******************************************
desprayName := 'WatercraftV2_base_despray_Prod_'+dateString+'.csv';
// ORIG_DS							:= DEV_DS;
ORIG_DS							:= PROD_DS;
//***** END: Alter Values in here **************************************

lzFilePathBaseFile	:= PRTE2_Watercraft._LandingZoneConfig.AllData.Dir + desprayName;
LandingZoneIP 			:= PRTE2_Watercraft._LandingZoneConfig.IP;
PRTE2_Watercraft._Layouts.BaseInput_Slim_Common transformToSlim(PRTE2_Watercraft._Layouts.Base L) := TRANSFORM
		SELF := L;
		SELF := [];
END;
	
ExportDS := PROJECT( ORIG_DS, transformToSlim(LEFT) );
TempCSV							:= PRTE2_Watercraft._Files.EXPORT_CSV_FILE;
// ---------------------------------------------------------------------------------
PRTE2_Common.DesprayCSV(ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile);