IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;

#OPTION('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');

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
// Use default list of allowed sources
// AllowedSourcesDataset_List := [];
// AllowedSourcesDataset_List:=	[MDR.SourceTools.src_Bankruptcy,MDR.SourceTools.src_Accurint_Crim_Court];	
AllowedSourcesDataset_List:=	[];	
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset_List := [];

email_list:='karthik.reddy@lexisnexisrisk.com';

logical_file_type:='CSV';
//Get_FCRA_Consumer_InputFile := Kel_Shell_QA_UI.Get_Input_File(InputFile_LogicalName, InputFile_Dali, File_Type, Records_to_Run);															

FCRA_Consumer:= Kel_Shell_QA_UI.FCRA_Consumer(  Query_Environment,
																							  InputFile_LogicalName,
																								logical_file_type,
																								InputFile_Dali,
																							  Records_to_Run,
																							  GLBA,
																								DPPA,
																								DataPermissionMask, 
																								DataRestrictionMask,
																								Intended_Purpose, 
																								histDate,
																								Score_threshold,
																								Output_Master_Results,
																								Output_SALT_Profile,
																								AllowedSourcesDataset_List,
																								ExcludeSourcesDataset_List,
																								email_list);

// execute_type:= 'executeNow';
// execute_type:=  'scheduleCron';
// cron_time :='0 10 19 * *';
// IF(execute_type='executeNow',

sprayMessage:='failed';
dfuWUID:='W20200915-111742';
dfuStatus:='finished';

if(trim(sprayMessage,left,right) <> '', Kel_Shell_QA_UI.File_spray_notification_macro(email_list, dfuWUID, dfuStatus));

if(trim(sprayMessage,left,right) = '', FCRA_Consumer):FAILURE(FileServices.SendEmail(email_list,'KAT Notification','Your job has failed. The failed workunit is:' + workunit + FailMessage));


// IF(execute_type='scheduleCron',FCRA_Consumer): WHEN(CRON(cron_time)), 
// FAILURE(FileServices.SendEmail(email_list,'KEL SHELL QA UI run job','The failed workunit is:' + workunit + FailMessage));

									
EXPORT BWR_FCRA_Consumer := 'todo';