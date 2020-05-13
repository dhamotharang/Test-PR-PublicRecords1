#WORKUNIT('name', 'NonFCRA MAS THOR ProfileBoosterV1.1');
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('multiplePersistInstances',TRUE);
#OPTION('defaultSkewError', 1);

//Ensure to check the RecordsToRun below to see if that is how many you want to run. 

IMPORT ProfileBooster.ProfileBoosterV2_KEL, ProfileBooster, STD, Risk_Indicators;
IMPORT KEL12 AS KEL;

	InputFile := '~pb11::in::carvana_customer_sample_200127_in.csv';
	// file := '~pb11::in::carvana_customer_sample_200113_in.csv';
	// file_name := file[(STD.Str.Find(file,'::',STD.Str.FindCount(file,'::'))+2)..LENGTH(file)];

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
// InputFile := '~temp::kel::consumer_nonfcra_100k_with_LexIDs.csv';
// prii_layout := RECORD
    // STRING Account             ;
    // STRING FirstName           ;
    // STRING MiddleName          ;
    // STRING LastName            ;
    // STRING StreetAddress       ;
    // STRING City                ;
    // STRING State               ;
    // STRING Zip                 ;
    // STRING HomePhone           ;
    // STRING SSN                 ;
    // STRING DateOfBirth         ;
    // STRING WorkPhone           ;
    // STRING Income              ;
    // STRING DLNumber            ;
    // STRING DLState             ;
    // STRING Balance             ;
    // STRING ChargeOffD          ;
    // STRING FormerName          ;
    // STRING Email               ;
    // STRING EmployerName        ;
    // STRING historydate;
    // STRING LexID;
    // STRING IPAddress;
    // STRING Perf;
    // STRING Proj;
// END;
// InputFile := '~thor400::profilebooster::ln_output_springleaf_layout_profboostertest.csv';
// InputFile := '~thor400::profilebooster::ln_output_springleaf_layout_profboostertest_100k.csv';
// prii_layout := RECORD
  // unsigned6 lexid;
  // string2 donotmail;
  // string2 verifiedssn;
  // string2 verifiedphone;
  // string3 prospecttimeonrecord;
  // string3 prospecttimelastupdate;
  // string2 prospectlastupdate12mo;
  // string3 prospectage;
  // string2 prospectgender;
  // string2 prospectmaritalstatus;
  // string2 prospectestimatedincomerange;
  // string2 prospectdeceased;
  // string2 prospectcollegeattending;
  // string2 prospectcollegeattended;
  // string2 prospectcollegeprogramtype;
  // string2 prospectcollegeprivate;
  // string2 prospectcollegetier;
  // string2 prospectbankingexperience;
  // string2 assetcurrowner;
  // string2 propcurrowner;
  // string3 propcurrownedcnt;
  // string7 propcurrownedassessedttl;
  // string7 propcurrownedavmttl;
  // string3 proptimelastsale;
  // string3 propeverownedcnt;
  // string3 propeversoldcnt;
  // string3 propsoldcnt12mo;
  // string5 propsoldratio;
  // string3 proppurchasecnt12mo;
  // string2 ppcurrowner;
  // string3 ppcurrownedcnt;
  // string3 ppcurrownedautocnt;
  // string3 ppcurrownedmtrcyclecnt;
  // string3 ppcurrownedaircrftcnt;
  // string3 ppcurrownedwtrcrftcnt;
  // string3 lifeevtimelastmove;
  // string2 lifeevnamechange;
  // string2 lifeevnamechangecnt12mo;
  // string3 lifeevtimefirstassetpurchase;
  // string3 lifeevtimelastassetpurchase;
  // string3 lifeeveverresidedcnt;
  // string5 lifeevlastmovetaxratiodiff;
  // string2 lifeevecontrajectory;
  // string2 lifeevecontrajectoryindex;
  // string2 rescurrownershipindex;
  // string7 rescurravmvalue;
  // string7 rescurravmvalue12mo;
  // string5 rescurravmratiodiff12mo;
  // string7 rescurravmvalue60mo;
  // string5 rescurravmratiodiff60mo;
  // string5 rescurravmcntyratio;
  // string5 rescurravmtractratio;
  // string5 rescurravmblockratio;
  // string2 rescurrdwelltype;
  // string2 rescurrdwelltypeindex;
  // string2 rescurrmortgagetype;
  // string7 rescurrmortgageamount;
  // string3 rescurrbusinesscnt;
  // string3 crtreccnt;
  // string3 crtreccnt12mo;
  // string3 crtrectimenewest;
  // string3 crtrecfelonycnt;
  // string3 crtrecfelonycnt12mo;
  // string3 crtrecfelonytimenewest;
  // string3 crtrecmsdmeancnt;
  // string3 crtrecmsdmeancnt12mo;
  // string3 crtrecmsdmeantimenewest;
  // string3 crtrecevictioncnt;
  // string3 crtrecevictioncnt12mo;
  // string3 crtrecevictiontimenewest;
  // string3 crtreclienjudgcnt;
  // string3 crtreclienjudgcnt12mo;
  // string3 crtreclienjudgtimenewest;
  // string7 crtreclienjudgamtttl;
  // string3 crtrecbkrptcnt;
  // string3 crtrecbkrptcnt12mo;
  // string3 crtrecbkrpttimenewest;
  // string2 crtrecseverityindex;
  // string2 occproflicense;
  // string2 occproflicensecategory;
  // string2 occbusinessassociation;
  // string3 occbusinessassociationtime;
  // string2 occbusinesstitleleadership;
  // string2 interestsportperson;
  // string3 hhteenagermmbrcnt;
  // string3 hhyoungadultmmbrcnt;
  // string3 hhmiddleagemmbrcnt;
  // string3 hhseniormmbrcnt;
  // string3 hhelderlymmbrcnt;
  // string3 hhcnt;
  // string2 hhestimatedincomerange;
  // string3 hhcollegeattendedmmbrcnt;
  // string3 hhcollege2yrattendedmmbrcnt;
  // string3 hhcollege4yrattendedmmbrcnt;
  // string3 hhcollegegradattendedmmbrcnt;
  // string3 hhcollegeprivatemmbrcnt;
  // string2 hhcollegetiermmbrhighest;
  // string3 hhpropcurrownermmbrcnt;
  // string3 hhpropcurrownedcnt;
  // string7 hhpropcurravmhighest;
  // string3 hhppcurrownedcnt;
  // string3 hhppcurrownedautocnt;
  // string3 hhppcurrownedmtrcyclecnt;
  // string3 hhppcurrownedaircrftcnt;
  // string3 hhppcurrownedwtrcrftcnt;
  // string3 hhcrtrecmmbrcnt;
  // string3 hhcrtrecmmbrcnt12mo;
  // string3 hhcrtrecfelonymmbrcnt;
  // string3 hhcrtrecfelonymmbrcnt12mo;
  // string3 hhcrtrecmsdmeanmmbrcnt;
  // string3 hhcrtrecmsdmeanmmbrcnt12mo;
  // string3 hhcrtrecevictionmmbrcnt;
  // string3 hhcrtrecevictionmmbrcnt12mo;
  // string3 hhcrtreclienjudgmmbrcnt;
  // string3 hhcrtreclienjudgmmbrcnt12mo;
  // string7 hhcrtreclienjudgamtttl;
  // string3 hhcrtrecbkrptmmbrcnt;
  // string3 hhcrtrecbkrptmmbrcnt12mo;
  // string3 hhcrtrecbkrptmmbrcnt24mo;
  // string3 hhoccproflicmmbrcnt;
  // string3 hhoccbusinessassocmmbrcnt;
  // string3 hhinterestsportpersonmmbrcnt;
  // string3 raateenagemmbrcnt;
  // string3 raayoungadultmmbrcnt;
  // string3 raamiddleagemmbrcnt;
  // string3 raaseniormmbrcnt;
  // string3 raaelderlymmbrcnt;
  // string3 raahhcnt;
  // string3 raammbrcnt;
  // string2 raamedincomerange;
  // string3 raacollegeattendedmmbrcnt;
  // string3 raacollege2yrattendedmmbrcnt;
  // string3 raacollege4yrattendedmmbrcnt;
  // string3 raacollegegradattendedmmbrcnt;
  // string3 raacollegeprivatemmbrcnt;
  // string3 raacollegetoptiermmbrcnt;
  // string3 raacollegemidtiermmbrcnt;
  // string3 raacollegelowtiermmbrcnt;
  // string3 raapropcurrownermmbrcnt;
  // string7 raapropowneravmhighest;
  // string7 raapropowneravmmed;
  // string3 raappcurrownermmbrcnt;
  // string3 raappcurrownerautommbrcnt;
  // string3 raappcurrownermtrcyclemmbrcnt;
  // string3 raappcurrowneraircrftmmbrcnt;
  // string3 raappcurrownerwtrcrftmmbrcnt;
  // string3 raacrtrecmmbrcnt;
  // string3 raacrtrecmmbrcnt12mo;
  // string3 raacrtrecfelonymmbrcnt;
  // string3 raacrtrecfelonymmbrcnt12mo;
  // string3 raacrtrecmsdmeanmmbrcnt;
  // string3 raacrtrecmsdmeanmmbrcnt12mo;
  // string3 raacrtrecevictionmmbrcnt;
  // string3 raacrtrecevictionmmbrcnt12mo;
  // string3 raacrtreclienjudgmmbrcnt;
  // string3 raacrtreclienjudgmmbrcnt12mo;
  // string7 raacrtreclienjudgamtmax;
  // string3 raacrtrecbkrptmmbrcnt36mo;
  // string3 raaoccproflicmmbrcnt;
  // string3 raaoccbusinessassocmmbrcnt;
  // string3 raainterestsportpersonmmbrcnt;
 // END;

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
PP := DISTRIBUTE(PP1, RANDOM());

myCFG := MODULE(ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile)
END;

GLBA := 1; 
DPPA := 0; 
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
