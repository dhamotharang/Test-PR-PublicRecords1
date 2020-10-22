IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;

#OPTION('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');

//settings
Query_Environment:=Kel_Shell_QA_UI.Constants.BOCA_DEV_ROXIE;
InputFile_Dali:=Kel_Shell_QA_UI.Constants.Boca_Dataland;
File_Type:= 'CSV';
Records_to_Run:=10;
InputFile_LogicalName:=Kel_Shell_QA_UI.Constants.Business_InputFile;

GLBA := 1;
DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
DataPermissionMask  := '00000000000000000000000000000000000000000000000000'; 
DataRestrictionMask := '00100000000000000000000000000000000000000000000000'; 

// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
historyDate := '0';
// historyDate := '20190118';
// historyDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// Score_threshold := 90;

// BIP Append options
BIPAppend_Score_Threshold := 75; // Default score threshold for BIP Append. Valid values are 51-100.
BIPAppend_Weight_Threshold := 0;
BIPAppend_PrimForce := FALSE; // Set to TRUE to require an exact match on prim range in the BIP Append.
BIPAppend_ReAppend := TRUE; // Set to FALSE to avoid re-appending BIP IDs if BIP IDs are populated on the input file.
BIPAppend_Include_AuthRep := FALSE; // Determines whether Auth Rep data is used in BIP Append

// Output additional file in Master Layout
// Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
// Output_Master_Results := FALSE;
Output_Master_Results := TRUE; 

// Toggle to include/exclude SALT profile of results file
// Output_SALT_Profile := FALSE;
Output_SALT_Profile := TRUE;

Exclude_Consumer_Attributes := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.

AllowedSources := ''; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.

// Use default list of allowed sources
// AllowedSourcesDataset_List := [];
// AllowedSourcesDataset_List:=	[MDR.SourceTools.src_Bankruptcy,MDR.SourceTools.src_Accurint_Crim_Court];	
AllowedSourcesDataset_List:=	[];	
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset_List := [];

IsMarketing:= FALSE;

email_list:='karthik.reddy@lexisnexisrisk.com';

logical_file_type:='CSV';
// Get_Business_InputFile := Kel_Shell_QA_UI.Get_Input_File(InputFile_LogicalName,
                                                         // InputFile_Dali,
																												 // File_Type, 
																												 // Records_to_Run
																												 // );
																												 
Business:= Kel_Shell_QA_UI.Business( Query_Environment,
                                     InputFile_LogicalName, 
																		 logical_file_type,
																		 InputFile_Dali,
																		 Records_to_Run,
																		 GLBA, 
																		 DPPA,
																		 DataPermissionMask,
																		 DataRestrictionMask,
																		 LexIdSourceOptout,
																		 TransactionId,
																		 BatchUID,
																		 GCID, 
																		 historyDate,
																		 Score_threshold,
																		 BIPAppend_Score_Threshold, 
																		 BIPAppend_Weight_Threshold,
																		 BIPAppend_PrimForce, 
																		 BIPAppend_ReAppend, 
																		 BIPAppend_Include_AuthRep,
																		 Output_Master_Results,
																		 Output_SALT_Profile,
																		 Exclude_Consumer_Attributes,
																		 AllowedSources,
																		 OverrideExperianRestriction,
																		 AllowedSourcesDataset_List,
																		 ExcludeSourcesDataset_List,
																		 IsMarketing,
																		 email_list
																		);
																		
// execute_type:= 'executeNow';
// execute_type:=  'scheduleCron';
// cron_time :='0 10 19 * *';

// IF(execute_type='executeNow',
                      // Business):FAILURE(FileServices.SendEmail(email_list,'KEL SHELL QA UI run job','The failed workunit is:' + workunit + FailMessage));

cron_time :='0 10 19 * *';

sprayMessage:='failed';
dfuWUID:='W20200915-111742';
dfuStatus:='finished';

if(trim(sprayMessage,left,right) <> '', Kel_Shell_QA_UI.File_spray_notification_macro(email_list, dfuWUID, dfuStatus));

if(trim(sprayMessage,left,right) = '', Business): WHEN(CRON(cron_time)), 
FAILURE(FileServices.SendEmail(email_list,'KAT Notification','Your job has failed. The failed workunit is:' + workunit + FailMessage));

	

EXPORT BWR_Business_NonMarketing_ScheduleCron := 'todo';