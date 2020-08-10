IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;

//settings
Query_Environment:=Kel_Shell_QA_UI.Constants.BOCA_DEV_ROXIE;
InputFile_Dali:=Kel_Shell_QA_UI.Constants.Boca_Dataland;
File_Type:= 'CSV';
Records_to_Run:=10;
InputFile_LogicalName:=Kel_Shell_QA_UI.Constants.nonFCRA_Consumer_InputFile;

GLBA := 1;
DPPA := 1;
DataPermissionMask := '0000000001101';  
DataRestrictionMask := '0000000000000000000000000000000000000000000000000'; 

// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
histDate := '0';
// histDate := '20190116';
// histDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
// Output_Master_Results := FALSE;
Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
// Output_SALT_Profile := FALSE;
Output_SALT_Profile := TRUE;


Get_nonFCRA_Consumer_InputFile := Kel_Shell_QA_UI.Get_Input_File(InputFile_LogicalName, InputFile_Dali, File_Type, Records_to_Run);															

nonFCRA_Consumer:= Kel_Shell_QA_UI.nonFCRA_Consumer( Query_Environment,
                                                     InputFile_LogicalName,
																										 Records_to_Run,
																										 GLBA,
																										 DPPA,
																										 DataPermissionMask,
																										 DataRestrictionMask,
																										 LexIdSourceOptout,
																										 TransactionId,
																										 BatchUID,
																										 GCID,
																										 histDate,
																										 Score_threshold,
																										 Output_Master_Results,
																										 Output_SALT_Profile
                                                    );

EXPORT BWR_nonFCRA_Consumer := 'todo';