// BWR_Scramble_LNProperty  ====================================================================
// Scrambling only happens to new production data coming in...
// So this Assumes that the gateway file has been loaded in and exists in HPCC
// pointed to by PRTE2_LNProperty.Files.LNP_Gateway_Base_SF_DS
// =======================================================================================
// W20131217-174210

IMPORT PRTE2_LNProperty as LNP;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
IMPORT ut;
#OPTION('multiplePersistInstances',FALSE);
#workunit('name', 'Boca CT LN_Property Scramble');
xdate	:= ut.GetDate;
// ******************************************************************************
getFileName(STRING base) := LNP.Constants.SourcePathForLNPCSV + base + xdate + '.csv';
OUTCSV ( DS, CSVName) := FUNCTIONMACRO
	RETURN OUTPUT(DS,,CSVName,CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM),OVERWRITE);
ENDMACRO;
addWU(STRING name) := name + '::' + WORKUNIT;

CSV_Name_1 			:= addWU(SCR.Files.CSV_1);
CSV_Name_1a			:= addWU(SCR.Files.CSV_1a);
CSV_Name_BAPR		:= addWU('~PRCT::in::propertyscramble_custtest::BAPREVIEW');
CSV_Name_2a 		:= addWU(SCR.Files.CSV_2a);
CSV_Name_2 			:= addWU(SCR.Files.CSV_2);
CSV_Name_3 			:= addWU(SCR.Files.CSV_3);

// The following link starts with the Gateway data, scrambles it and returns the results in spreadsheet format
BaseFile 					:= SCR.Scramble_LNP.BaseFile;					//Original Sprayed Gateway data (plus counter)
Initial_Prepared 	:= SCR.Scramble_LNP.INITIAL_DATA;			//Original Sprayed with counters and XRec's added
DblChkPre_DS 			:= SCR.Scramble_LNP.DoubleCheckRecords;	//Pre-Check, removed blanks, but not separated to move/no-move
PostPreDedup_DS 	:= SCR.Scramble_LNP.DblCheckPreDedup;	//Post-Check, but pre-dedup
DblChkPost_DS 		:= SCR.Scramble_LNP.DoubleCheckPost; 	//Post-Check
Spreadsheet_DS 		:= SCR.Scramble_LNP.DS_Spreadsheet;		//Full Scrambled Spreadsheet
output1						:= OUTCSV(DblChkPre_DS,CSV_Name_1);
output1a					:= OUTCSV(Initial_Prepared,CSV_Name_1a);
output2a					:= OUTCSV(PostPreDedup_DS,CSV_Name_2a);
output2						:= OUTCSV(DblChkPost_DS,CSV_Name_2);
output3						:= OUTCSV(Spreadsheet_DS,CSV_Name_3);
outputBAPR				:= OUTCSV(BaseFile,CSV_Name_BAPR);
outputAllAsCSV 		:= SEQUENTIAL(output1, output1a, output2a, output2, output3,outputBAPR);
Steps := SCR.Scramble_LNP.AllSteps;

LZone 					:= LNP.Constants.LandingZoneIP;
deSpray1				:= FileServices.DeSpray(CSV_Name_1,LZone,getFileName('LNProperty_Pre_Scramble_Check_'),-1,,,TRUE);
deSpray1a				:= FileServices.DeSpray(CSV_Name_1a,LZone,getFileName('LNProperty_Initial_Plus_Counters_'),-1,,,TRUE);
deSpray2a				:= FileServices.DeSpray(CSV_Name_2a,LZone,getFileName('LNProperty_Post_Scramble_PreDedup_'),-1,,,TRUE);
deSpray2				:= FileServices.DeSpray(CSV_Name_2,LZone,getFileName('LNProperty_Post_Scramble_Check_'),-1,,,TRUE);
deSpray3				:= FileServices.DeSpray(CSV_Name_3,LZone,getFileName('LNProperty_Scrambled_'),-1,,,TRUE);
deSpray1BAP			:= FileServices.DeSpray(CSV_Name_BAPR,LZone,getFileName('LNProperty_BAP_Base_Review_'),-1,,,TRUE);
deSprayALL := SEQUENTIAL(deSpray1, deSpray1a, deSpray2a, deSpray2, deSpray3,deSpray1BAP);
																						
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

