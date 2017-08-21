/* Generic FunctionMacro to handle despray logic - what you need to do is something like this:
dateString	:= ut.GetDate;
desprayName := 'WatercraftV2_base_despray_'+dateString+'_Final.csv';
lzFilePathBaseFile	:= PRTE2_Common.Constants_Aging.Dev_Aging_File_Dir + desprayName;
LandingZoneIP 			:= PRTE2_Common.Constants_Aging.DevLandingZoneIP;
ExportDS						:= PRTE2_Watercraft._Datasets.All;
TempCSV							:= PRTE2_Watercraft._Files.EXPORT_CSV_FILE;
PRTE2_Common.DesprayCSV(ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile);
*/

EXPORT DesprayCSV ( ExportDS, TempCSV, LandingZoneIP, lzFilePathBaseFile) := FUNCTIONMACRO

			outputBaseAsCSV			:= OUTPUT(ExportDS,,
																		TempCSV,
																		CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM));
																		
			deSprayCSV 					:= NOTHOR(FileServices.DeSpray(TempCSV,
																									LandingZoneIP,
																									lzFilePathBaseFile,
																									-1,,,TRUE));
																									
			deleteCSVThorFile		:= NOTHOR(FileServices.DeleteLogicalFile(TempCSV));
																									
			sequentialSteps := SEQUENTIAL(outputBaseAsCSV, deSprayCSV, deleteCSVThorFile);
			
			return sequentialSteps;

ENDMACRO;
