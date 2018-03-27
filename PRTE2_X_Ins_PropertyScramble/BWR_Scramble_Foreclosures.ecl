// BWR_Scramble_Foreclosures ====================================================================
// Scrambling only happens to new production data coming in...
// So this Assumes that the gateway file has been loaded in and exists in HPCC
// pointed to by PRTE2_Foreclosure.Files.FRCL_Gateway_Base_SF_DS
// =======================================================================================
// W20131211-170959
// W20131217-170437

IMPORT PRTE2_Foreclosure as FRCL;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT ut;
#OPTION('multiplePersistInstances',FALSE);
#workunit('name', 'Boca CT Foreclosures Scramble');
xdate	:= ut.GetDate;
// ******************************************************************************
getFileName(STRING base) := FRCL.Constants.SourcePathForFRCLCSV + base + xdate + '.csv';
OUTCSV ( DS, CSVName) := FUNCTIONMACRO
	RETURN OUTPUT(DS,,CSVName,CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM),OVERWRITE);
ENDMACRO;
addWU(STRING name) := name + '::' + WORKUNIT;

FileName1 			:= getFileName('Foreclosure_Pre_Scramble_Check_');
FileName1a 			:= getFileName('Foreclosure_Initial_Plus_Counters_');
FileName2a 			:= getFileName('Foreclosure_Post_Scramble_PreDedup_');
FileName2 			:= getFileName('Foreclosure_Post_Scramble_Check_');
FileName3 			:= getFileName('Foreclosure_Scrambled_');
CSV_Name_1 			:= addWU(SCR.Files.CSV_1);
CSV_Name_1a			:= addWU(SCR.Files.CSV_1a);
CSV_Name_2a 		:= addWU(SCR.Files.CSV_2a);
CSV_Name_2 			:= addWU(SCR.Files.CSV_2);
CSV_Name_3 			:= addWU(SCR.Files.CSV_3);

// The following link starts with the Gateway data, scrambles it and returns the results in spreadsheet format
BaseFile 					:= SCR.Scramble_Foreclosures.BaseFile;					//Original Sprayed Gateway data
Initial_Prepared 	:= SCR.Scramble_Foreclosures.INITIAL_DATA;			//Original Sprayed with counters and XRec's added
DblChkPre_DS 			:= SCR.Scramble_Foreclosures.DoubleCheckRecords; //Pre-Check, removed blanks, but not separated to move/no-move
PostPreDedup_DS 	:= SCR.Scramble_Foreclosures.DblCheckPreDedup;	//Post-Check, but pre-dedup
DblChkPost_DS 		:= SCR.Scramble_Foreclosures.DoubleCheckPost; 	//Post-Check
Spreadsheet_DS 		:= SCR.Scramble_Foreclosures.DS_Spreadsheet;		//Full Scrambled Spreadsheet
output1						:= OUTCSV(DblChkPre_DS,CSV_Name_1);
output1a					:= OUTCSV(Initial_Prepared,CSV_Name_1a);
output2a					:= OUTCSV(PostPreDedup_DS,CSV_Name_2a);
output2						:= OUTCSV(DblChkPost_DS,CSV_Name_2);
output3						:= OUTCSV(Spreadsheet_DS,CSV_Name_3);
outputAllAsCSV 		:= SEQUENTIAL(output1, output1a, output2a, output2, output3);

Steps := SCR.Scramble_Foreclosures.AllSteps;

LZone 					:= FRCL.Constants.LandingZoneIP;
deSpray1				:= FileServices.DeSpray(CSV_Name_1,LZone,FileName1,-1,,,TRUE);
deSpray1a				:= FileServices.DeSpray(CSV_Name_1a,LZone,FileName1a,-1,,,TRUE);
deSpray2a				:= FileServices.DeSpray(CSV_Name_2a,LZone,FileName2a,-1,,,TRUE);
deSpray2				:= FileServices.DeSpray(CSV_Name_2,LZone,FileName2,-1,,,TRUE);
deSpray3				:= FileServices.DeSpray(CSV_Name_3,LZone,FileName3,-1,,,TRUE);
deSprayALL := SEQUENTIAL(deSpray1, deSpray1a, deSpray2a, deSpray2, deSpray3);
																						
deleteCSV1			:= FileServices.DeleteLogicalFile(CSV_Name_1);
deleteCSV1a			:= FileServices.DeleteLogicalFile(CSV_Name_1a);
deleteCSV2a			:= FileServices.DeleteLogicalFile(CSV_Name_2a);
deleteCSV2			:= FileServices.DeleteLogicalFile(CSV_Name_2);
deleteCSV3			:= FileServices.DeleteLogicalFile(CSV_Name_3);
deleteALL := SEQUENTIAL(deleteCSV1, deleteCSV1a, deleteCSV2a, deleteCSV2, deleteCSV3);

sequentialSteps := SEQUENTIAL(Steps,
															outputAllAsCSV, 
															deSprayALL,
  														deleteALL
															);
sequentialSteps;

