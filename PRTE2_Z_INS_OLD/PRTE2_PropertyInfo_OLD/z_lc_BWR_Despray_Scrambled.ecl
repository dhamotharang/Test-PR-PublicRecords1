//* Despray_Scrambled Property Info Data
// Builder window code for de-spraying the scrambled Property Info Data to
// a specified file on the landing zone.
//* change the file name on line 10 before submitting *//
IMPORT PRTE2,PRTE2_PropertyInfo,_control,ut;

string unixland := '10.194.72.226';
LandingZoneIP :=  unixland;
LandingZoneDir := '/data/Custtest/PropertyInfo/';

CurrentDate				  			:= ut.GetDate;
lzFilePathBaseFile	:= LandingZoneDir + 'propertyinfo_'+CurrentDate+'.csv';

PII_Scrambled       := '~prte::in::custtest::csv::scrambled::propertyinfo9b';
PII_Scrambled_DS := DATASET(PII_Scrambled,
									PRTE2.layouts.batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
				
PII_Scrambled_Desprayed   := '~prte::in::custtest::desprayed' +  '::' + 'csv' + '::' +  WORKUNIT;

outputPIIAsCSV			:= OUTPUT(PII_Scrambled_DS,,
                              PII_Scrambled_Desprayed,
															CSV(HEADING(1), QUOTE('"'), MAXLENGTH(32768)));
															
deSprayCSV 					:= FileServices.DeSpray(PII_Scrambled_Desprayed,
	                                          LandingZoneIP,
																					  lzFilePathBaseFile,
																					  -1,,,TRUE);
																						
deleteCSVThorFile		:= FileServices.DeleteLogicalFile(PII_Scrambled_Desprayed);
																						
sequentialSteps := SEQUENTIAL(outputPIIAsCSV, deSprayCSV, deleteCSVThorFile);
sequentialSteps;