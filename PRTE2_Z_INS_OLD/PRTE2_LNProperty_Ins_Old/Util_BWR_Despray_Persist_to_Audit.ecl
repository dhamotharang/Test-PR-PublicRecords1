// Util_BWR_Despray_Persist_to_Audit 

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT ut;
#workunit('name', 'Boca CT LNProperty Despray');

xdate	:= ut.GetDate;

TEMP_CSV_FILE					:= LNP.Files.LNP_CSV_FILE + '::' +  WORKUNIT;

lzFilePathGatewayFile	:= LNP.Constants.SourcePathForLNPCSV + 'LN_Property_PERSIST_'+xdate+'.csv';

LNP_PERSIST_DS				:= LNP.Files.LNP_GetHeader_Persist;

// EXPORT_DS := PROJECT(LNP_Base_SF_DS, LNP.Constants.Gateway_Reduce(LEFT));

outputXRefAsCSV			:= OUTPUT(LNP_PERSIST_DS,,
                              TEMP_CSV_FILE,
															CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM),
															OVERWRITE);
															
deSprayCSV 					:= FileServices.DeSpray(TEMP_CSV_FILE,
	                                          LNP.Constants.LandingZoneIP,
																					  lzFilePathGatewayFile,
																					  -1,,,TRUE);
																						
deleteCSVThorFile		:= FileServices.DeleteLogicalFile(TEMP_CSV_FILE);
																						
sequentialSteps := SEQUENTIAL(outputXRefAsCSV, 
															deSprayCSV,
  														deleteCSVThorFile
															);
sequentialSteps;