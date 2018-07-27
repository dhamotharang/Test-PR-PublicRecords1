IMPORT PRTE2_Common, PRTE2_Gong_Ins;

CSVName := 'Linda_Dups_With_Addr_Issues.csv';
dateString := PRTE2_Common.Constants.TodayString+'';
desprayName	:= 'Gong_Ins_Base_PROD_Deduped_'+dateString+'.csv';

Files := PRTE2_Gong_Ins.Files;
Constants := PRTE2_Gong_Ins.Constants;
Layouts := PRTE2_Gong_Ins.Layouts;
FILE_SPRAY := Files.FILE_SPRAY;
SourcePathForCSV := Constants.SourcePathForCSV;

sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,						// file LZ
																					SourcePathForCSV+CSVName, 					// path to file on landing zone
																					8192,																// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,		// line separator(s)
																					Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Group(),									// destination THOR cluster
																					Files.FILE_SPRAY,
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					FALSE												  			// do not compress
																					);																					 

Sprayed	:= DATASET(FILE_SPRAY, PRTE2_Gong_Ins.Utilities.U_Layouts.LindaPartialLayout,
                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));									 
SprayedDedup := DEDUP(SORT(Sprayed,did),did); //Linda's Data File
// July 2018 - NOTE: we had LexID dups from before - remove those from each file before we do this
BaseDS := DEDUP(SORT(Files.Gong_Base_CSV_DS_PROD,did),did); //Prod file.
delSprayedFile  := FileServices.DeleteLogicalFile (FILE_SPRAY);

NewBase := JOIN(BaseDS,SprayedDedup,
										LEFT.did = (UNSIGNED)RIGHT.did,
										TRANSFORM({BaseDS}, SELF.phone10 := RIGHT.phone10, SELF := LEFT),
										LEFT OUTER);
EXPORT_DS := SORT(NewBase,did);

// Just for double checking - we should have no lost records after this
NewBase2 := DEDUP(SORT(EXPORT_DS,phone10),phone10);

// desprayName	:= 'Gong_Ins_Base_DEV_'+dateString+'.csv';
// EXPORT_DS		:=	SORT(PRTE2_Gong_Ins.Files.Gong_Base_CSV_DS,did);

LandingZoneIP 	:= PRTE2_Gong_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Gong_Ins.Files.FILE_SPRAY+'x2';
lzFilePathGatewayFile	:= PRTE2_Gong_Ins.Constants.SourcePathForCSV + desprayName;

desprayStep := PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);

SEQUENTIAL(sprayFile,
							OUTPUT(Choosen(Sprayed,500)),
							OUTPUT(Choosen(BaseDS,500)),
							OUTPUT(Choosen(EXPORT_DS,500)),
							OUTPUT(Choosen(NewBase2,500)),
							OUTPUT(COUNT(Sprayed),NAMED('C_Sprayed')),
							OUTPUT(COUNT(SprayedDedup),NAMED('C_SprayedDedup')),
							OUTPUT(COUNT(BaseDS),NAMED('C_BaseDS')),
							OUTPUT(COUNT(EXPORT_DS),NAMED('C_EXPORT_DS')),
							OUTPUT(COUNT(NewBase2),NAMED('C_NewBase2')),
					 desprayStep, delSprayedFile
					);

		
