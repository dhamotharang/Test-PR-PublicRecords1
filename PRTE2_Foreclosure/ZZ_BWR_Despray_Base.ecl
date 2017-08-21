// PRTE2_Foreclosure.BWR_Despray_Base -
//  - despray the XRef CSV in the Full XRef Format

IMPORT PRTE2_Foreclosure as FRCL;
IMPORT PRTE2_PropertyScramble as SCR;
IMPORT ut;

#workunit('name', 'Boca CT Foreclosures Despray');

xdate	:= ut.GetDate;

lzFilePathGatewayFile	:= FRCL.Constants.SourcePathForFRCLCSV + 'Foreclosures_Export_'+xdate+'.csv';
TEMP_CSV_FILE					:= FRCL.Files.FRCL_CSV_FILE + '::' +  WORKUNIT;

FRCL_Base_SF_DS				:= FRCL.Files.Foreclosures_50k_Scramble_SF_DS;


//  start with FRCL_Base_SF_DS  OR  Foreclosures_50k_Scramble_SF_DS below
EXPORT_DS := PROJECT(FRCL_Base_SF_DS,FRCL.Constants.Gateway_Reduce(LEFT));
// FRCL_Scramble_DblChk_DS := SCR.Scramble_PChar.DoubleCheckRecords;
// EXPORT_DS := FRCL_Scramble_DblChk_DS;

outputXRefAsCSV			:= OUTPUT(EXPORT_DS,,
                              TEMP_CSV_FILE,
															CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM),
															OVERWRITE);
															
deSprayCSV 					:= FileServices.DeSpray(TEMP_CSV_FILE,
	                                          FRCL.Constants.LandingZoneIP,
																					  lzFilePathGatewayFile,
																					  -1,,,TRUE);
																						
deleteCSVThorFile		:= FileServices.DeleteLogicalFile(TEMP_CSV_FILE);
																						
sequentialSteps := SEQUENTIAL(outputXRefAsCSV, 
															deSprayCSV,
  														deleteCSVThorFile
															);
sequentialSteps;