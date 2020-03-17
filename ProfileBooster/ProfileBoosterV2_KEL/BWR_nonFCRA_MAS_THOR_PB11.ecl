#WORKUNIT('name', 'NonFCRA MAS THOR ProfileBoosterV1.1');
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('multiplePersistInstances',FALSE);
// #OPTION('defaultSkewError', 1);

//Ensure to check the RecordsToRun below to see if that is how many you want to run. 

IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL12 AS KEL;

	InputFile := '~pb11::in::carvana_customer_sample_200127_in.csv';

	prii_layout := RECORD
		STRING Account;
		STRING FirstName;
		STRING MiddleName;
		STRING LastName;
		STRING StreetAddress;
		STRING City;
		STRING State;
		STRING Zip;
		STRING HomePhone;
		STRING SSN;
		STRING DateOfBirth;
		// STRING WorkPhone;
		// STRING income;  
		// string DLNumber;
		// string DLState;													
		// string BALANCE; 
		// string CHARGEOFFD;  
		// string FormerName;
		// string EMAIL;  
		// string employername;
		string historydate;
		unsigned did;
	END;

// Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
histDate := '0';
// histDate := (STRING)STD.Date.Today(); // Run with today's date

Score_threshold := 80;
// RecordsToRun := 0;
RecordsToRun := 100;
eyeball := 100;

// runUsingInfo := 1; //pii only
runUsingInfo := 2; //LexID only
// runUsingInfo := 3; //both PII and LexID

// selectedMode := 1;  //current
selectedMode := 2;  //archive
// selectedMode := 3;  //archive with todays date

mapInputData := MAP(runUsingInfo = 1 => 'PIIOnly',
                    runUsingInfo = 2 => 'LexIDOnly',
                    runUsingInfo = 3 => 'BothPIILexID',
                    'Unknown');
mapModeText := MAP(selectedMode = 1 => 'CurrentMode',
										selectedMode = 2 => 'ArchiveMode',
										selectedMode = 3 => 'ArchiveCurrentDate',
										'Unknown');
STRING8 today := (STRING8)Std.Date.Today();

outputFile := TRIM('~jfrancis::out::' + today + '_' + thorlib.wuid() + '_PB1_1_' + TRIM(mapInputData) + '_' + TRIM(mapModeText));

p_in := DATASET([{'1','JACK','RICHARD','FRANCIS','12384 FREMONT LN','ZIMMERMAN','MN','55398','5128318833','465759977','19800319','20190101',847892904}], prii_layout);//, thor);
// p_in := DATASET(InputFile, prii_layout, thor);
p := IF (RecordsToRun = 0, p_in, CHOOSEN (p_in, RecordsToRun));

PP1 := PROJECT(P, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout, 
	SELF.historydate := LEFT.historydate;
	SELF.lexid := (STRING)LEFT.did;
	SELF.G_ProcUID := COUNTER;
	SELF.Account := LEFT.Account;
	SELF := LEFT;
	SELF := [];
	));	
// PP := DISTRIBUTE(PP1, RANDOM());
PP := PP1;

myCFG := MODULE(ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile)
END;

GLBA := 1; 
DPPA := 1; 
DataRestrictionMask						:= '00000000000000000000000000000000000000000000000000';
DataPermissionMask 						:= '11111111111111111111111111111111111111111111111111';  

Options := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT INTEGER ScoreThreshold := Score_threshold;
	EXPORT BOOLEAN OutputMasterResults := FALSE;
	EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
END;

ResultSet:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetAttrsV11(PP, Options); 
// OUTPUT(ResultSet,,OutputFile, thor);
OUTPUT(ResultSet,,OutputFile, CSV(HEADING(single), QUOTE('"')));
