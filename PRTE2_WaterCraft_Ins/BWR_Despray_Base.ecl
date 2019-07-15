// PRTE2_WaterCraft_Ins.BWR_Despray_Base
// --------------------------------------------------------------
// Use to despray the existing main (all data) base file
IMPORT PRTE2_WaterCraft_Ins;
IMPORT PRTE2_Common;
#WORKUNIT ('NAME', 'CT Watercraft_base_despray CSV');

dateString	:= PRTE2_Common.Constants.TodayString + '';
//***** Alter Values in here *******************************************
// desprayName 			:= 'WatercraftV3_base_Dev_'+dateString+'.csv';
// ExportDS					:= PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal;		// saved in internal file in slim layout
desprayName 			:= 'WatercraftV3_base_Prod_'+dateString+'.csv';
ExportDS					:= PRTE2_WaterCraft_Ins.Datasets.All_Slim_Internal_Prod;		// saved in internal file in slim layout
//***** END: Alter Values in here **************************************

lzFilePathBaseFile := PRTE2_WaterCraft_Ins.Constants.SourcePathForCSV + desprayName;
LandingZoneIP 			:= PRTE2_WaterCraft_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_WaterCraft_Ins.Files.EXPORT_CSV_FILE;
// ---------------------------------------------------------------------------------
PRTE2_Common.DesprayCSV(ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile);
