IMPORT PRTE2_Common, PRTE2_Gong_Ins, PRTE2_Gong_Ins.Utilities;

CSVName := 'Linda_Dups_With_Addr_Issues.csv';
dateString := PRTE2_Common.Constants.TodayString+'';
desprayName	:= 'Gong_Ins_Base_PROD_Dedpd_Phones_'+dateString+'.csv';

Files := PRTE2_Gong_Ins.Files;
Constants := PRTE2_Gong_Ins.Constants;
Layouts := PRTE2_Gong_Ins.Layouts;
FILE_SPRAY := PRTE2_Gong_Ins.Files.MasterSprayPrefix + PRTE2_Gong_Ins.Files.Gong_Suffix +'_LindaDeduped';
SourcePathForCSV := Constants.SourcePathForCSV;

sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,						// file LZ
																					SourcePathForCSV+CSVName, 					// path to file on landing zone
																					8192,												// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,			// line separator(s)
																					Constants.CSVSprayQuote,					// text quote character
																					ThorLib.Group(),								// destination THOR cluster
																					FILE_SPRAY,
																					-1,												// -1 means no timeout
																						,												// use default ESP server IP port
																						,												// use default maximum connections
																					TRUE,												// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE, // replicate if in PROD
																					FALSE												// do not compress
																					);																					 
SEQUENTIAL(sprayFile);
Sprayed	:= DATASET(FILE_SPRAY, PRTE2_Gong_Ins.Utilities.U_Layouts.LindaPartialLayout,
                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));									 
SprayedDedup := DEDUP(SORT(Sprayed,phone10),phone10); //Linda's Data File
SortedLindas := SORT(SprayedDedup,did);

SortedBase := SORT(PRTE2_Gong_Ins.Utilities.U_Files.Gong_Base_CSV_DS_PROD,did); //OLD Prod file.

JIDX_LAY := RECORD
		UNSIGNED6 jIdx := 0;
END;

GLayoutLinda := {JIDX_LAY, SortedLindas};
GLayoutBase := {JIDX_LAY, SortedBase};

GLinda := group(sort(PROJECT(SortedLindas,gLayoutLinda), did), did);
GBase := group(sort(PROJECT(SortedBase,GLayoutBase), did), did);
GLindaNum := UNGROUP(PROJECT(GLinda,TRANSFORM({GLinda},SELF.jIDX := COUNTER, SELF := LEFT)));
GBaseNum := UNGROUP(PROJECT(GBase,TRANSFORM({GBase},SELF.jIDX := COUNTER, SELF := LEFT)));

// Testing and audit --------------------------------------
Count(Sprayed);
Count(SprayedDedup);
Count(SortedBase);
CHOOSEN(SortedLindas,1000);
CHOOSEN(SortedBase,1000);
CHOOSEN(GLindaNum,1000);
CHOOSEN(GBaseNum,1000);
// Testing and audit --------------------------------------

// turns out there were two records in current base that were second phones for two people.
Test := JOIN(GBaseNum,GLindaNum,
						(UNSIGNED)LEFT.did = (UNSIGNED)RIGHT.did AND LEFT.jIdx = RIGHT.jIdx,
						TRANSFORM({GBaseNum},
						SELF.phone10 := IF(RIGHT.phone10='',LEFT.phone10,RIGHT.phone10);
						SELF := LEFT)
						,LEFT ONLY
						);

NewBaseIdx := JOIN(GBaseNum,GLindaNum,
						(UNSIGNED)LEFT.did = (UNSIGNED)RIGHT.did AND LEFT.jIdx = RIGHT.jIdx,
						TRANSFORM({GBaseNum},
						SELF.phone10 := IF(RIGHT.phone10='',LEFT.phone10,RIGHT.phone10);
						SELF := LEFT)
						,LEFT OUTER
						);
						
// Testing and audit --------------------------------------
Test;
NewBaseIdx;
Count(SortedBase);
COUNT(NewBaseIdx);
SortedLindas((INTEGER)did IN [888809012415,888809045527]);
SortedBase(did IN [888809012415,888809045527]);
NewBaseIdx(did IN [888809012415,888809045527]);
// At this point I have confirmed that the two records that didn't exist in Linda's file simply kept their phone numbers.
// Testing and audit --------------------------------------

EXPORT_DS := PROJECT(NewBaseIdx,PRTE2_Gong_Ins.Layouts.Alpha_CSV_Layout);
EXPORT_DS;

LandingZoneIP 			:= PRTE2_Gong_Ins.Constants.LandingZoneIP;
TempCSV					:= PRTE2_Gong_Ins.Files.FILE_SPRAY+'x2';
lzFilePathGatewayFile := PRTE2_Gong_Ins.Constants.SourcePathForCSV + desprayName;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, LandingZoneIP, lzFilePathGatewayFile);