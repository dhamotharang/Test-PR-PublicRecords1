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

	InputFile := '~jfrancis::in::pb20::sample_100k_qa_clean.csv';
  headerRecords := 1; // Number of header rows on the input file
  prii_layout := RECORD
   STRING AccountNumber;
   STRING FirstName;
   STRING MiddleName;
   STRING LastName;
   STRING StreetAddress;
   STRING CITY;
   STRING State;
   STRING Zip;  
   STRING HomePhone;
   STRING SSN := '';
   STRING DOB := '';
   // STRING field3 := '';
   // STRING field4 := '';
   // STRING field5 := '';
   // STRING field6 := '';
   // STRING field7 := '';
   // STRING field8 := '';
   // STRING field9 := '';
   // STRING field10 := '';
   // STRING field11 := '';
   STRING historydate := '201901';  
   INTEGER7 did := 0;
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


p_in := DATASET([{'1','SAFIATOU','','DRAME','16 BRYANT ST NW','WASHINGTON','DC','20001','','','','20190131',681800322}], prii_layout);//, thor);
// p_in := DATASET(InputFile, prii_layout, thor);
p := IF (RecordsToRun = 0, p_in, CHOOSEN (p_in, RecordsToRun));
OUTPUT(p_in, named('p_in'));

// PP1 := PROJECT(P, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout, 
PP1 := PROJECT(P, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
	SELF.P_InpArchDt := LEFT.historydate;
	SELF.P_InpLexID := (INTEGER7)LEFT.did;
	SELF.P_LexID := (INTEGER7)LEFT.did;
	// SELF.G_ProcUID := 1;
	SELF.G_ProcUID := COUNTER;
	SELF.P_InpAcct := LEFT.AccountNumber;
  SELF.P_InpClnArchDt := LEFT.historydate;
	SELF := LEFT;
	SELF := [];
	));	
OUTPUT(PP1, named('PP1'));
PP := DISTRIBUTE(PP1, RANDOM());
// PP := PP1;
OUTPUT(PP, named('PP'));

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

// ResultSet:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetAttrsV11(PP, Options); 
ResultSet:= ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetPB11Attributes(PP, Options); 
// OUTPUT(ResultSet,,OutputFile, thor); W20200515-153410
OUTPUT(ResultSet,,OutputFile, CSV(HEADING(single), QUOTE('"')));
