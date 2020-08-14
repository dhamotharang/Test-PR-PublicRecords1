IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;

//settings
Query_Environment:=Kel_Shell_QA_UI.Constants.BOCA_DEV_ROXIE;
InputFile_Dali:=Kel_Shell_QA_UI.Constants.Boca_Dataland;
File_Type:= 'CSV';
Records_to_Run:=10;
InputFile_LogicalName:=Kel_Shell_QA_UI.Constants.FCRA_Consumer_InputFile;

GLBA := 0; // FCRA isn't GLBA restricted
DPPA := 0; // FCRA isn't DPPA restricted
DataPermissionMask := '0000000000000';  
DataRestrictionMask := '1000010000000100000000000000000000000000000000000'; 

// Inteded Purpose for FCRA. Stubbing this out for now so it can be used in the settings output for now.
Intended_Purpose := ''; 
// Intended_Purpose := 'PRESCREENING'; 

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

Get_FCRA_Consumer_InputFile := Kel_Shell_QA_UI.Get_Input_File(InputFile_LogicalName, InputFile_Dali, File_Type, Records_to_Run);															

FCRA_Consumer:= Kel_Shell_QA_UI.FCRA_Consumer(  Query_Environment,
																							  InputFile_LogicalName,
																							  Records_to_Run,
																							  GLBA,
																								DPPA,
																								DataPermissionMask, 
																								DataRestrictionMask,
																								Intended_Purpose, 
																								histDate,
																								Score_threshold,
																								Output_Master_Results,
																								Output_SALT_Profile);

EXPORT BWR_FCRA_Consumer := 'todo';