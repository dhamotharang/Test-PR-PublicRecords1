// Open as BWR Script - Use to despray the existing main (all data) base file
IMPORT PRTE2_Email;

STRING lzDirectory := '20130827_prct/';
STRING fileVersion := ut.GetDate;
STRING lzFileName  := 'EMAIL_DATA_DESPRAY_'+fileVersion+'.csv';
STRING lzFilePathNewData := PRTE2_Email._constants.LZ_Path_LindaCain+lzDirectory+lzFileName;

outputBaseAsCSV			:= OUTPUT(PRTE2_Email._files.File_Email_Base_DS,,
                              PRTE2_Email._constants.Email_Base_CSV,
															CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM));
															
deSprayCSV 					:= FileServices.DeSpray(PRTE2_Email._constants.Email_Base_CSV,
	                                          PRTE2_Email._constants.EDATA11,
																					  lzFilePathNewData,
																					  -1,,,TRUE);
																						
deleteCSVThorFile		:= FileServices.DeleteLogicalFile(PRTE2_Email._constants.Email_Base_CSV);
																						
sequentialSteps := SEQUENTIAL(outputBaseAsCSV, deSprayCSV, deleteCSVThorFile);
sequentialSteps;