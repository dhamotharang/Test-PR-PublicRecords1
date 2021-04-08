IMPORT PublicRecords_KEL, RiskWise, STD, Gateway, SALT38, SALTRoutines, Business_Risk_BIP;
#workunit('name','MAS Business and SBFE');
/* ***********************************************

***********       FILE OPTIONS        ***********

* ************************************************/
InputFile := '~mas::uatsamples::business_nfcra_100k_07102019.csv'; //100k file
// InputFile := '~mas::uatsamples::business_nfcra_1m_07092019.csv'; //1m file
OutputFile := '~blptemp::out::shell31_with_mas_output'; // by default ThorLib.WUID() will be appended to the end of the file name
/* ***********************************************

*****            RUNTIME OPTIONS            *****

* ************************************************/
// RoxieIP := RiskWise.shortcuts.Dev156;
RoxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;

Threads := 1;
RecordsToRun := 5; // Number of records to run through the BWR. Set to 0 to run all.
eyeball := 5; // Number of records to view in the BWR outputs.
Output_Files := FALSE; // Outputs any applicable CSV files for the BWR (Business Shell results, MAS Results, MAS + SBFE Results)
historyDate := '999999'; // Universally Set the History Date YYYYMMDD for ALL records. Set to 0 to use the History Date located on each record of the input file
Output_Master_Results := FALSE; // Master results are for R&D/QA purposes ONLY. This should only be set to TRUE for internal use.
// BIP Append options
Score_threshold := 80;
BIPAppend_Score_Threshold := 75; // Default score threshold for BIP Append. Valid values are 51-100.
BIPAppend_Weight_Threshold := 0;
BIPAppend_PrimForce := FALSE; // Set to TRUE to require an exact match on prim range in the BIP Append.
BIPAppend_ReAppend := TRUE; // Set to FALSE to avoid re-appending BIP IDs if BIP IDs are populated on the input file.
BIPAppend_Include_AuthRep := FALSE; // Determines whether Auth Rep data is used in BIP Append
// Business Options
BusinessShellVersion := 31; // Set which Business Shell version you want to run. By default for this BWR, it should be 31.
Exclude_Consumer_Attributes := FALSE; //if TRUE, bypasses consumer logic and sets all consumer shell fields to blank/0.
AllowedSources := Business_Risk_BIP.Constants.Default_AllowedSources; // Stubbing this out for use in settings output for now. To be used to turn on DNBDMI by setting to 'DNBDMI'
OverrideExperianRestriction := FALSE; // Stubbing this out for use in settings output for now. To be used to control whether Experian Business Data (EBR and CRDB) is returned.
LinkSearchLevel := Business_Risk_BIP.Constants.LinkSearch.Default; // Searches at the default level (SeleID)
BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.Default; // Append Nothing, use what was input
MarketingMode := FALSE; // This product is not being run for marketing, allow all normal sources
/* ***********************************************

*****  PERMISSIBLE USE OPTIONS   *****

* ************************************************/
/* Data Setting 	NonFCRA 	
DRMFares = 0 //FARES - bit 1
DRMExperian =	0 - //FARES bit 6
DRMTransUnion =	0 //TCH - bit 10
DRMADVO =	0 //ADVO bit 12
DRMExperianFCRA =	0 //ECHF bit 14
DRMCortera = 0 // Cortera Header and Tradelines Bit 42
DRMExperianEBR/Bus = 1 // Experian EBR Bit 3
DPMSSN =	0 //use_DeathMasterSSAUpdates - bit 10
DPMFDN =	0 //use_FDNContributoryData - bit 11
DPMDL =	0 //use_InsuranceDLData - bit 13
DPMDNBDMI = 0
DPMSBFE = 0 // SBFE - Bit 12 in Data Permission Mask
GLBA 	= 1 
DPPA 	= 3 
*/
GLBA := 1;
DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
DataPermissionMask  := '00000000000100000000000000000000000000000000000000'; // SBFE should always be on
DataRestrictionMask := '00100000000000000000000000000000000000000000000000'; 
// CCPA Options;
LexIdSourceOptout := 1;
TransactionId := '';
BatchUID := '';
GCID := 0;

// Use default list of allowed sources
AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

/* ***********************************************

*****            BEGIN BWR CODE            *****

* ************************************************/
prii_layout := RECORD
	STRING AccountNumber;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING StreetAddressLine1;
	STRING StreetAddressLine2;
	STRING City1;
	STRING State1;
	STRING Zip1;
	STRING BusinessPhone;
	STRING BusinessTIN;
	STRING BusinessIPAddress;
	STRING BusinessURL;
	STRING BusinessEmailAddress;
	STRING Rep1FirstName;
	STRING Rep1MiddleName;
	STRING Rep1LastName;
	STRING Rep1NameSuffix;
	STRING Rep1StreetAddressLine1;
	STRING Rep1StreetAddressLine2;
	STRING Rep1City;
	STRING Rep1State;
	STRING Rep1Zip;
	STRING Rep1SSN;
	STRING Rep1DOB;
	STRING Rep1Age;
	STRING Rep1DLNumber;
	STRING Rep1DLState;
	STRING Rep1HomePhone;
	STRING Rep1EmailAddress;
	STRING Rep1FormerLastName;
	STRING Rep1LexID;
	STRING ArchiveDate;
	STRING PowID;
	STRING ProxID;
	STRING SeleID;
	STRING OrgID;
	STRING UltID;
	STRING SIC_Code;
	STRING NAIC_Code;
	STRING Rep2FirstName;
	STRING Rep2MiddleName;
	STRING Rep2LastName;
	STRING Rep2NameSuffix;
	STRING Rep2StreetAddressLine1;
	STRING Rep2StreetAddressLine2;
	STRING Rep2City;
	STRING Rep2State;
	STRING Rep2Zip;
	STRING Rep2SSN;
	STRING Rep2DOB;
	STRING Rep2Age;
	STRING Rep2DLNumber;
	STRING Rep2DLState;
	STRING Rep2HomePhone;
	STRING Rep2EmailAddress;
	STRING Rep2FormerLastName;
	STRING Rep2LexID;
	STRING Rep3FirstName;
	STRING Rep3MiddleName;
	STRING Rep3LastName;
	STRING Rep3NameSuffix;
	STRING Rep3StreetAddressLine1;
	STRING Rep3StreetAddressLine2;
	STRING Rep3City;
	STRING Rep3State;
	STRING Rep3Zip;
	STRING Rep3SSN;
	STRING Rep3DOB;
	STRING Rep3Age;
	STRING Rep3DLNumber;
	STRING Rep3DLState;
	STRING Rep3HomePhone;
	STRING Rep3EmailAddress;
	STRING Rep3FormerLastName;
	STRING Rep3LexID;
	STRING Rep4FirstName;
	STRING Rep4MiddleName;
	STRING Rep4LastName;
	STRING Rep4NameSuffix;
	STRING Rep4StreetAddressLine1;
	STRING Rep4StreetAddressLine2;
	STRING Rep4City;
	STRING Rep4State;
	STRING Rep4Zip;
	STRING Rep4SSN;
	STRING Rep4DOB;
	STRING Rep4Age;
	STRING Rep4DLNumber;
	STRING Rep4DLState;
	STRING Rep4HomePhone;
	STRING Rep4EmailAddress;
	STRING Rep4FormerLastName;
	STRING Rep4LexID;
	STRING Rep5FirstName;
	STRING Rep5MiddleName;
	STRING Rep5LastName;
	STRING Rep5NameSuffix;
	STRING Rep5StreetAddressLine1;
	STRING Rep5StreetAddressLine2;
	STRING Rep5City;
	STRING Rep5State;
	STRING Rep5Zip;
	STRING Rep5SSN;
	STRING Rep5DOB;
	STRING Rep5Age;
	STRING Rep5DLNumber;
	STRING Rep5DLState;
	STRING Rep5HomePhone;
	STRING Rep5EmailAddress;
	STRING Rep5FormerLastName;
	STRING Rep5LexID;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded;
END;

inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));//with heading last 1 record never runs
OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));
// inDataReady := PROJECT(inDataRecs(AccountNumber NOT IN ['Account', 'SBFEExtract2016_0013010111WBD0101_3439841667_003']), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
inDataReady := PROJECT(inDataRecs(AccountNumber != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.ArchiveDate := IF(historyDate = '0', LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	// SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
    UNSIGNED4 Seq;
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN ExcludeConsumerAttributes;
	BOOLEAN IsMarketing;
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendReAppend;
	BOOLEAN BIPAppendIncludeAuthRep;
  BOOLEAN OverrideExperianRestriction;
	
	UNSIGNED1 LexIdSourceOptout;
  STRING _TransactionId;
  STRING _BatchUID;
  UNSIGNED6 _GCID;
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := historyDate;
	EXPORT STRING InputFileName := InputFile;
	EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
	EXPORT STRING Data_Permission_Mask := DataPermissionMask;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
	EXPORT STRING Allowed_Sources := AllowedSources; // Controls inclusion of DNBDMI data
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
	EXPORT UNSIGNED BusinessLexIDThreshold := BIPAppend_Score_Threshold;
	EXPORT UNSIGNED BusinessLexIDWeightThreshold := BIPAppend_Weight_Threshold;
	EXPORT BOOLEAN BusinessLexIDPrimForce := BIPAppend_PrimForce;
	EXPORT BOOLEAN BusinessLexIDReAppend := BIPAppend_ReAppend;
	EXPORT BOOLEAN BusinessLexIDIncludeAuthRep := BIPAppend_Include_AuthRep;
END;

/* ***********************************************

*****        PREPPING MAS INPUT        *****

* ************************************************/
layout_MAS_Business_Service_output := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
    UNSIGNED4 Seq := 0;
    #IF(Output_Master_Results)
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
    #END
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

soapLayout intoMAS(inDataReadyDist le, INTEGER c):= TRANSFORM 
    SELF.Seq := c;
	// The inquiry delta base which feeds the 1 day inq attrs is not needed for the input rep 1 at this point. for now we only run this delta base code in the nonFCRA service 
	
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
	SELF.IsMarketing := MarketingMode;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.AllowedSourcesDataset := AllowedSourcesDataset;
	SELF.ExcludeSourcesDataset := ExcludeSourcesDataset;
	SELF.ExcludeConsumerAttributes := Exclude_Consumer_Attributes;
	SELF.BIPAppendScoreThreshold := Settings.BusinessLexIDThreshold;
	SELF.BIPAppendWeightThreshold := Settings.BusinessLexIDWeightThreshold;
	SELF.BIPAppendPrimForce := Settings.BusinessLexIDPrimForce;
	SELF.BIPAppendReAppend := Settings.BusinessLexIDReAppend;
	SELF.BIPAppendIncludeAuthRep := Settings.BusinessLexIDIncludeAuthRep;
	SELF.LexIdSourceOptout := LexIdSourceOptout;
	SELF._TransactionId := TransactionId;
	SELF._BatchUID := BatchUID;
	SELF._GCID := GCID;	
END;

soap_in := PROJECT(inDataReadyDist, intoMAS(LEFT, COUNTER));

OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_MAS_Input'));

layout_MAS_Business_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

/* ******************************************************

***** PREPPING BUSINESS SHELL INPUT *****

* *******************************************************/
Business_Shell_soapLayout := RECORD
UNSIGNED4	Seq                  ;
STRING200	AcctNo               ;
// Company Fields               
STRING120	CompanyName          ;
STRING120	AltCompanyName       ;
STRING120	StreetAddress1       ;
STRING120	StreetAddress2       ;
STRING25	City                 ;
STRING2		State                ;
STRING9		Zip9                 ;
STRING10	Prim_Range           ;
STRING2		PreDir               ;
STRING28	Prim_Name            ;
STRING4		Addr_Suffix          ;
STRING2		PostDir              ;
STRING10	Unit_Desig           ;
STRING8		Sec_Range            ;
STRING5		Zip5                 ;
STRING4		Zip4                 ;
STRING10	Lat                  ;
STRING11	Long                 ;
STRING1		Addr_Type            ;
STRING4		Addr_Status          ;
STRING30	County               ;
STRING7		Geo_Block            ;
STRING11	FEIN                 ;
STRING10	Phone10              ;
STRING45	IPAddr               ;
STRING120	CompanyURL           ;
STRING10   SIC_Code              ;
STRING10   NAIC_Code             ;
UNSIGNED6  Bus_LexID             ;
STRING60   Bus_Structure         ;
STRING5   	Years_in_Business    ;
STRING8    Bus_Start_Date        ;
STRING9    Yearly_Revenue        ;
STRING10   Fax_Number            ;
// Authorized Representative Fields 
STRING120	Rep_FullName         ;
STRING5		Rep_NameTitle        ;
STRING20	Rep_FirstName        ;
STRING20	Rep_MiddleName       ;
STRING20	Rep_LastName         ;
STRING5		Rep_NameSuffix       ;
STRING20	Rep_FormerLastName   ;
STRING120	Rep_StreetAddress1   ;
STRING120	Rep_StreetAddress2   ;
STRING25	Rep_City             ;
STRING2		Rep_State            ;
STRING9		Rep_Zip              ;
STRING10	Rep_Prim_Range       ;
STRING2		Rep_PreDir           ;
STRING28	Rep_Prim_Name        ;
STRING4		Rep_Addr_Suffix      ;
STRING2		Rep_PostDir          ;
STRING10	Rep_Unit_Desig       ;
STRING8		Rep_Sec_Range        ;
STRING5		Rep_Zip5             ;
STRING4		Rep_Zip4             ;
STRING10	Rep_Lat              ;
STRING11	Rep_Long             ;
STRING1		Rep_Addr_Type        ;
STRING4		Rep_Addr_Status      ;
STRING3		Rep_County           ;
STRING7		Rep_Geo_Block        ;
STRING9		Rep_SSN              ;
STRING8		Rep_DateOfBirth      ;
STRING10	Rep_Phone10          ;
STRING3		Rep_Age              ;
STRING25	Rep_DLNumber         ;
STRING2		Rep_DLState          ;
STRING100	Rep_Email            ;
UNSIGNED6	Rep_LexID            ;
STRING50	Rep_BusinessTitle    ;
// Authorized Representative 2 Fields
STRING120	Rep2_FullName         ;
STRING5		Rep2_NameTitle        ;
STRING20	Rep2_FirstName        ;
STRING20	Rep2_MiddleName       ;
STRING20	Rep2_LastName         ;
STRING5		Rep2_NameSuffix       ;
STRING20	Rep2_FormerLastName   ;
STRING120	Rep2_StreetAddress1   ;
STRING120	Rep2_StreetAddress2   ;
STRING25	Rep2_City             ;
STRING2		Rep2_State            ;
STRING9		Rep2_Zip              ;
STRING10	Rep2_Prim_Range       ;
STRING2		Rep2_PreDir           ;
STRING28	Rep2_Prim_Name        ;
STRING4		Rep2_Addr_Suffix      ;
STRING2		Rep2_PostDir          ;
STRING10	Rep2_Unit_Desig       ;
STRING8		Rep2_Sec_Range        ;
STRING5		Rep2_Zip5             ;
STRING4		Rep2_Zip4             ;
STRING10	Rep2_Lat              ;
STRING11	Rep2_Long             ;
STRING1		Rep2_Addr_Type        ;
STRING4		Rep2_Addr_Status      ;
STRING3		Rep2_County           ;
STRING7		Rep2_Geo_Block        ;
STRING9		Rep2_SSN              ;
STRING8		Rep2_DateOfBirth      ;
STRING10	Rep2_Phone10          ;
STRING3		Rep2_Age              ;
STRING25	Rep2_DLNumber         ;
STRING2		Rep2_DLState          ;
STRING100	Rep2_Email            ;
UNSIGNED6	Rep2_LexID            ;
STRING50	Rep2_BusinessTitle    ;
// Authorized Representative 3 Fields
STRING120	Rep3_FullName         ;
STRING5		Rep3_NameTitle        ;
STRING20	Rep3_FirstName        ;
STRING20	Rep3_MiddleName       ;
STRING20	Rep3_LastName         ;
STRING5		Rep3_NameSuffix       ;
STRING20	Rep3_FormerLastName   ;
STRING120	Rep3_StreetAddress1   ;
STRING120	Rep3_StreetAddress2   ;
STRING25	Rep3_City             ;
STRING2		Rep3_State            ;
STRING9		Rep3_Zip              ;
STRING10	Rep3_Prim_Range       ;
STRING2		Rep3_PreDir           ;
STRING28	Rep3_Prim_Name        ;
STRING4		Rep3_Addr_Suffix      ;
STRING2		Rep3_PostDir          ;
STRING10	Rep3_Unit_Desig       ;
STRING8		Rep3_Sec_Range        ;
STRING5		Rep3_Zip5             ;
STRING4		Rep3_Zip4             ;
STRING10	Rep3_Lat              ;
STRING11	Rep3_Long             ;
STRING1		Rep3_Addr_Type        ;
STRING4		Rep3_Addr_Status      ;
STRING3		Rep3_County           ;
STRING7		Rep3_Geo_Block        ;
STRING9		Rep3_SSN              ;
STRING8		Rep3_DateOfBirth      ;
STRING10	Rep3_Phone10          ;
STRING3		Rep3_Age              ;
STRING25	Rep3_DLNumber         ;
STRING2		Rep3_DLState          ;
STRING100	Rep3_Email            ;
UNSIGNED6	Rep3_LexID            ;
STRING50	Rep3_BusinessTitle    ;
// Authorized Representative 4 Fields
STRING120	Rep4_FullName         ;
STRING5		Rep4_NameTitle        ;
STRING20	Rep4_FirstName        ;
STRING20	Rep4_MiddleName       ;
STRING20	Rep4_LastName         ;
STRING5		Rep4_NameSuffix       ;
STRING20	Rep4_FormerLastName   ;
STRING120	Rep4_StreetAddress1   ;
STRING120	Rep4_StreetAddress2   ;
STRING25	Rep4_City             ;
STRING2		Rep4_State            ;
STRING9		Rep4_Zip              ;
STRING10	Rep4_Prim_Range       ;
STRING2		Rep4_PreDir           ;
STRING28	Rep4_Prim_Name        ;
STRING4		Rep4_Addr_Suffix      ;
STRING2		Rep4_PostDir          ;
STRING10	Rep4_Unit_Desig       ;
STRING8		Rep4_Sec_Range        ;
STRING5		Rep4_Zip5             ;
STRING4		Rep4_Zip4             ;
STRING10	Rep4_Lat              ;
STRING11	Rep4_Long             ;
STRING1		Rep4_Addr_Type        ;
STRING4		Rep4_Addr_Status      ;
STRING3		Rep4_County           ;
STRING7		Rep4_Geo_Block        ;
STRING9		Rep4_SSN              ;
STRING8		Rep4_DateOfBirth      ;
STRING10	Rep4_Phone10          ;
STRING3		Rep4_Age              ;
STRING25	Rep4_DLNumber         ;
STRING2		Rep4_DLState          ;
STRING100	Rep4_Email            ;
UNSIGNED6	Rep4_LexID            ;
STRING50	Rep4_BusinessTitle    ;
// Authorized Representative 5 Fields
STRING120	Rep5_FullName         ;
STRING5		Rep5_NameTitle        ;
STRING20	Rep5_FirstName        ;
STRING20	Rep5_MiddleName       ;
STRING20	Rep5_LastName         ;
STRING5		Rep5_NameSuffix       ;
STRING20	Rep5_FormerLastName   ;
STRING120	Rep5_StreetAddress1   ;
STRING120	Rep5_StreetAddress2   ;
STRING25	Rep5_City             ;
STRING2		Rep5_State            ;
STRING9		Rep5_Zip              ;
STRING10	Rep5_Prim_Range       ;
STRING2		Rep5_PreDir           ;
STRING28	Rep5_Prim_Name        ;
STRING4		Rep5_Addr_Suffix      ;
STRING2		Rep5_PostDir          ;
STRING10	Rep5_Unit_Desig       ;
STRING8		Rep5_Sec_Range        ;
STRING5		Rep5_Zip5             ;
STRING4		Rep5_Zip4             ;
STRING10	Rep5_Lat              ;
STRING11	Rep5_Long             ;
STRING1		Rep5_Addr_Type        ;
STRING4		Rep5_Addr_Status      ;
STRING3		Rep5_County           ;
STRING7		Rep5_Geo_Block        ;
STRING9		Rep5_SSN              ;
STRING8		Rep5_DateOfBirth      ;
STRING10	Rep5_Phone10          ;
STRING3		Rep5_Age              ;
STRING25	Rep5_DLNumber         ;
STRING2		Rep5_DLState          ;
STRING100	Rep5_Email            ;
UNSIGNED6	Rep5_LexID            ;
STRING50	Rep5_BusinessTitle    ;
UNSIGNED1	DPPA_Purpose         ;
UNSIGNED1	GLBA_Purpose         ;
STRING5	IndustryClass_In         := Business_Risk_BIP.Constants.Default_IndustryClass;
STRING Data_Restriction_Mask;
STRING Data_Permission_Mask;
UNSIGNED6	HistoryDate          ;
UNSIGNED1	LinkSearchLevel      := Business_Risk_BIP.Constants.LinkSearch.Default;
UNSIGNED1	MarketingMode        := Business_Risk_BIP.Constants.Default_MarketingMode;
UNSIGNED1	BusShellVersion      ;
UNSIGNED6	PowID                ;
UNSIGNED6	ProxID               ;
UNSIGNED6	SeleID               ;
UNSIGNED6	OrgID                ;
UNSIGNED6	UltID                ;
STRING50	AllowedSources       ;
UNSIGNED1 BIPBestAppend		     ;
UNSIGNED1 OFAC_Version		     ;
REAL Global_Watchlist_Threshold	 ;
UNSIGNED1 KeepLargeBusinesses    ;
BOOLEAN IncludeTargusGateway     ;
BOOLEAN RunTargusGateway         ;
BOOLEAN OverrideExperianRestriction ;
BOOLEAN IncludeAuthRepInBIPAppend   ;
BOOLEAN CorteraRetrotest := FALSE   ;
//CCPA fields
unsigned1 LexIdSourceOptout := 1 ;
string TransactionID := ''       ;
string BatchUID := ''            ;
unsigned6 GlobalCompanyId := 0   ;
end;

Business_Shell_soapLayout intoBusinessShell(inDataReadyDist le, INTEGER c) := TRANSFORM
    SELF.Seq := c;
	SELF.AcctNo := le.AccountNumber;
	SELF.CompanyName := le.CompanyName;
	SELF.AltCompanyName := le.AlternateCompanyName;
	SELF.StreetAddress1 := le.StreetAddressLine1;
	SELF.StreetAddress2 := le.StreetAddressLine2;
	SELF.City := le.City1;
	SELF.State := le.State1;
	SELF.Zip5 := le.Zip1[1..5];
	SELF.FEIN := le.BusinessTIN;
	SELF.Phone10 := le.BusinessPhone;
	SELF.IPAddr := le.BusinessIPAddress;
	SELF.Rep_FirstName := le.Rep1FirstName;
	SELF.Rep_MiddleName := le.Rep1MiddleName;
	SELF.Rep_LastName := le.Rep1LastName;
	SELF.Rep_NameSuffix := le.Rep1NameSuffix;
	SELF.Rep_StreetAddress1 := le.Rep1StreetAddressLine1;
	SELF.Rep_StreetAddress2 := le.Rep1StreetAddressLine2;
	SELF.Rep_City := le.Rep1City;
	SELF.Rep_State := le.Rep1State;
	SELF.Rep_Zip := le.Rep1Zip;
	SELF.Rep_SSN := le.Rep1SSN;
	SELF.Rep_DateOfBirth := le.Rep1DOB;
	SELF.Rep_Phone10 := le.Rep1HomePhone;
	SELF.DPPA_Purpose := DPPA;
	SELF.GLBA_Purpose := GLBA;
	SELF.Data_Restriction_Mask := DataRestrictionMask;
	SELF.Data_Permission_Mask := DataPermissionMask;
	SELF.HistoryDate := (UNSIGNED)le.ArchiveDate;
	SELF.MarketingMode := IF(MarketingMode = TRUE, 1, 0);
	SELF.LinkSearchLevel := LinkSearchLevel;
	SELF.SIC_Code := le.SIC_Code;
	SELF.NAIC_Code := le.NAIC_Code;
	SELF.BIPBestAppend := BIPBestAppend;
	SELF.BusShellVersion := BusinessShellVersion;
	SELF.PowID := (INTEGER)le.PowID;
	SELF.ProxID := (INTEGER)le.ProxID;
	SELF.SeleID :=(INTEGER)le.SeleID;
	SELF.OrgID := (INTEGER)le.OrgID;
	SELF.UltID := (INTEGER)le.UltID;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
	SELF.AllowedSources := Settings.Allowed_Sources;
	SELF.IncludeAuthRepInBIPAppend := Settings.BusinessLexIDIncludeAuthRep;
    SELF.LexIdSourceOptout := LexIdSourceOptout;
	SELF.TransactionId := TransactionId;
	SELF.BatchUID := BatchUID;
	SELF.GlobalCompanyId := GCID;	
	SELF := [];
END;

Business_Shell_soap_in := PROJECT(inDataReadyDist, intoBusinessShell(LEFT, COUNTER));

OUTPUT(CHOOSEN(Business_Shell_soap_in, eyeball), NAMED('Sample_Business_Shell_Input'));

Business_Shell_Output_Layout := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
    Business_Risk_BIP.Layouts.OutputLayout.Input_Echo Input_Echo;
    Business_Risk_BIP.Layouts.OutputLayout.SBFE SBFE;
	STRING ErrorCode := '';
END;


Business_Shell_Output_Layout busFail(Business_Shell_soap_in le) := TRANSFORM
	SELF.ErrorCode := FAILMESSAGE;
	SELF := [];
END;

/* ***********************************************************

***** MAKE SOAPCALLS TO BOTH SERVICES *****

* ************************************************************/
MAS_Results := SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_Business_nonFCRA_Service',
				{soap_in}, 
				DATASET(layout_MAS_Business_Service_output),
				XPATH('*'),
				RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));
        
layout_MAS_Business_Service_output getSeq(MAS_Results L, soap_in R) := TRANSFORM
SELF.Seq := R.Seq;
SELF := L;
END;

MAS_Results_w_Seq := JOIN(MAS_Results, soap_in, LEFT.results.p_inpacct = RIGHT.input[1].accountnumber, getSeq(LEFT,RIGHT));


BusinessShell_Results := SOAPCALL(Business_Shell_soap_in, 
				RoxieIP,
				'business_risk_bip.business_shell_service',
				{Business_Shell_soap_in}, 
				DATASET(Business_Shell_Output_Layout),
				RETRY(2), TIMEOUT(300),
				PARALLEL(threads),
        		onFail(busFail(LEFT)));
 
MAS_Output := OUTPUT(MAS_Results, NAMED('MAS_Results'));
BusinessShell_Output := OUTPUT(BusinessShell_Results, NAMED('Business_Shell_Results'));

 CombinedLayout := RECORD
    RECORDOF(MAS_Results);
    RECORDOF(BusinessShell_Results) - input_echo - time_ms;
 END;
 
 MASandSBFE := JOIN(MAS_Results_w_Seq, BusinessShell_Results, 
 LEFT.Seq = RIGHT.input_echo.Seq, 
 TRANSFORM(CombinedLayout, SELF := LEFT, SELF := RIGHT));
 
MAS_with_SBFE_Output := OUTPUT(MASandSBFE, NAMED('MAS_With_SBFE_Results'));
 
SEQUENTIAL(MAS_Output, PARALLEL(BusinessShell_Output, MAS_with_SBFE_Output)); // This can be commented out to increase performance for a small amount of transactions (<10k)

#IF(Output_Files)
OUTPUT(MAS_Results,, OutputFile + '_MAS_Results' + ThorLib.WUID() +'.csv', CSV(HEADING(single), QUOTE('"')), expire(45));
OUTPUT(BusinessShell_Results,, OutputFile + '_Business_Shell_Results'+ ThorLib.WUID() +'.csv', CSV(HEADING(single), QUOTE('"')), expire(45));
OUTPUT(MASandSBFE,, OutputFile + '_MAS_With_SBFE_Results' + ThorLib.WUID() +'.csv', CSV(HEADING(single), QUOTE('"')), expire(45));
#END

