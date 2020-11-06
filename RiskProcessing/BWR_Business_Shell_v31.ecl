#workunit('name', 'Business_Shell_V31');

IMPORT Business_Risk_BIP, Cortera, Data_Services, RiskWise; 

eyeball := 10;

Threads := 30;
RecordsToRun := ALL; // Set to ALL to run all, otherwise set to the number of records from the inputFile you wish to run

// Business Shell 2.1 and higher accepts YYYYMM, YYYYMMDD, and YYYYMMDDTTTT dates. HistDate can be in any of these forms.
histDate := 0; // Set to 0 to use the HistoryDateYYYYMM that is on the inputFile, set to anything other than 0 to use that history date for every record overwriting what was on the inputFile

// This set's what level to run the Business Shell at.  Options are:
link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.Default; // Searches at the default level (SeleID)
// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.PowID; // Searches at the PowID level
// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.ProxID; // Searches at the ProxID level
// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.SeleID; // Searches at the SeleID level
// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.OrgID; // Searches at the OrgID level
// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.UltID; // Searches at the UltID level

BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.Default; // Append Nothing, use what was input
// BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.AllBlankFields; // Append any missing BII with our "best" company information
// BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest; // Overwrite any input BII with our "best" company information

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

dataPermissionMask := '00000000000000000000'; // Default - does not allow SBFE data
// dataPermissionMask := '00000000000100000000'; // Allow SBFE data

IncludeExperian := FALSE; // By default, Experian data is not allowed
// IncludeExperian := TRUE; // Override the Experian data restriction and include Experian in results 

Allowed_Sources := Business_Risk_BIP.Constants.Default_AllowedSources; // By default, do NOT include DNB DMI data
// Allowed_Sources := Business_Risk_BIP.Constants.AllowDNBDMI; // Include DNB DMI data. NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY.

Include_AuthRep_In_BIPAppend := FALSE; // Prevent the Authorized Rep from being used to determine the BIP IDs for the company.
// Include_AuthRep_In_BIPAppend := TRUE; // Include the Authorized Rep in determining the BIP IDs for the company.

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; 

BusShellVersion := 31; // business shell version 31 is the most recent version 

useRetrotestData := TRUE;   // Use Cortera Retrotest data.
// useRetrotestData := FALSE;  // Don't use Cortera Retrotest data.

// Typically we want to process as "Retrotest" only those Cortera Retrotest records whose historydate
// is earlier than 201705 since we have good Cortera in-house records on or after that date. But
// if we want to process all records as "Retrotest", set ignore201705ArchiveDateThreshold to TRUE.
ignore201705ArchiveDateThreshold := FALSE;
// ignore201705ArchiveDateThreshold := TRUE;

inputFileName := Data_Services.foreign_prod + 'hmccarl::in::bshell_test_inputs';

// Specify the Cortera Retrotest file, if applicable.
InputRetrotestFile := '~thor::cortera::retrotester::results::lnretro_linkid_20170920_1_output.txt';
// Set InputRetrotestFile := '' if we don't want to read from a Cortera Retrotest file.

outputFile := '~modeling::out::business_shell_v31_results_' + ThorLib.wuid();

InputFileLayout := RECORD
	STRING AccountNumber;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING Addr;
	STRING City;
	STRING State;
	STRING Zip;
	STRING BusinessPhone;
	STRING TaxIdNumber;
	STRING BusinessIPAddress;
	STRING RepresentativeFirstName;
	STRING RepresentativeMiddleName;
	STRING RepresentativeLastName;
	STRING RepresentativeNameSuffix;
	STRING RepresentativeAddr;
	STRING RepresentativeCity;
	STRING RepresentativeState;
	STRING RepresentativeZip;
	STRING RepresentativeSSN;
	STRING RepresentativeDOB;
	STRING RepresentativeAge;
	STRING RepresentativeDLNumber;
	STRING RepresentativeDLState;
	STRING RepresentativeHomePhone;
	STRING RepresentativeEmailAddress;
	STRING RepresentativeFormerLastName;
	INTEGER HistoryDate; //Business Shell 2.1 accepts YYYYMM, YYYMMDD, and YYYYMMDDTTTT dates. historyDate can be in any of these forms.
	UNSIGNED6 PowID;
	UNSIGNED6 ProxID;
	UNSIGNED6 SeleID;
	UNSIGNED6 OrgID;
	UNSIGNED6 UltID;
	STRING SIC_Code;
	STRING NAIC_Code;
END;

InputFile := CHOOSEN(DATASET(inputFileName, InputFileLayout, CSV(QUOTE('"'))), RecordsToRun);

OUTPUT(CHOOSEN(InputFile, eyeball), NAMED('Sample_Raw_Input'));
OUTPUT(COUNT(InputFile), NAMED('Total_Raw_Input_Records'));

// Now read the file generated by Cortera's Retrotester process.
ds_inputRetrotesterFile := IF( InputRetrotestFile = '' OR NOT useRetrotestData,
      DATASET( [], Cortera.layout_Retrotest_raw ),
      DATASET( InputRetrotestFile, Cortera.layout_Retrotest_raw, CSV( HEADING(0), QUOTE('"') ) )
    );
    
// Transform to SOAP layout.	
SOAPLayout := RECORD
	INTEGER Seq;
	STRING AcctNo;
	STRING CompanyName;
	STRING AltCompanyName;
	STRING StreetAddress1;
	STRING StreetAddress2;
	STRING City;
	STRING State;
	STRING Zip9;
	STRING Prim_Range;
	STRING PreDir;
	STRING Prim_Name;
	STRING Addr_Suffix;
	STRING PostDir;
	STRING Unit_Desig;
	STRING Sec_Range;
	STRING Zip5;
	STRING Zip4;
	STRING Lat;
	STRING Long;
	STRING Addr_Type; 
	STRING Addr_Status;
	STRING County;
	STRING Geo_Block;
	STRING FEIN;
	STRING Phone10;
	STRING IPAddr;
	STRING CompanyURL;
	STRING Rep_FullName;
	STRING Rep_NameTitle;
	STRING Rep_FirstName;
	STRING Rep_MiddleName;
	STRING Rep_LastName;
	STRING Rep_NameSuffix;
	STRING Rep_FormerLastName;
	STRING Rep_StreetAddress1;
	STRING Rep_StreetAddress2;
	STRING Rep_City;
	STRING Rep_State;
	STRING Rep_Zip;
	STRING Rep_Prim_Range;
	STRING Rep_PreDir;
	STRING Rep_Prim_Name;
	STRING Rep_Addr_Suffix;
	STRING Rep_PostDir;
	STRING Rep_Unit_Desig;
	STRING Rep_Sec_Range;
	STRING Rep_Zip5;
	STRING Rep_Zip4;
	STRING Rep_Lat;
	STRING Rep_Long;
	STRING Rep_Addr_Type;
	STRING Rep_Addr_Status;
	STRING Rep_County;
	STRING Rep_Geo_Block;
	STRING Rep_SSN;
	STRING Rep_DateOfBirth;
	STRING Rep_Phone10;
	STRING Rep_Age;
	STRING Rep_DLNumber;
	STRING Rep_DLState;
	STRING Rep_Email;
	INTEGER Rep_LexID;
	INTEGER DPPA_Purpose;
	INTEGER GLBA_Purpose;
	STRING Data_Restriction_Mask;
	STRING Data_Permission_Mask;
	INTEGER MarketingMode;
	INTEGER HistoryDate;
	INTEGER LinkSearchLevel;
	INTEGER BIPBestAppend;
	STRING SIC_Code;
	STRING NAIC_Code;
	UNSIGNED1 BusShellVersion;
	UNSIGNED6 PowID;
	UNSIGNED6 ProxID;
	UNSIGNED6 SeleID;
	UNSIGNED6 OrgID;
	UNSIGNED6 UltID;
	BOOLEAN OverrideExperianRestriction;
	STRING AllowedSources;
	BOOLEAN IncludeAuthRepInBIPAppend;
	BOOLEAN CorteraRetrotest;
	DATASET(Cortera.layout_Retrotest_raw) CorteraRetrotestRecords;
END;

SOAPLayout intoSOAP(InputFile le) := TRANSFORM
	SELF.AcctNo := le.AccountNumber;
	SELF.CompanyName := le.CompanyName;
	SELF.AltCompanyName := le.AlternateCompanyName;
	SELF.StreetAddress1 := le.Addr;
	SELF.City := le.City;
	SELF.State := le.State;
	SELF.Zip9 := le.Zip;
	SELF.FEIN := le.TaxIdNumber;
	SELF.Phone10 := le.BusinessPhone;
	SELF.IPAddr := le.BusinessIPAddress;
	SELF.Rep_FirstName := le.RepresentativeFirstName;
	SELF.Rep_MiddleName := le.RepresentativeMiddleName;
	SELF.Rep_LastName := le.RepresentativeLastName;
	SELF.Rep_NameSuffix := le.RepresentativeNameSuffix;
	SELF.Rep_FormerLastName := le.RepresentativeFormerLastName;
	SELF.Rep_StreetAddress1 := le.RepresentativeAddr;
	SELF.Rep_City := le.RepresentativeCity;
	SELF.Rep_State := le.RepresentativeState;
	SELF.Rep_Zip := le.RepresentativeZip;
	SELF.Rep_SSN := le.RepresentativeSSN;
	SELF.Rep_DateOfBirth := le.RepresentativeDOB;
	SELF.Rep_Phone10 := le.RepresentativeHomePhone;
	SELF.Rep_Age := le.RepresentativeAge;
	SELF.Rep_DLNumber := le.RepresentativeDLNumber;
	SELF.Rep_DLState := le.RepresentativeDLState;
	SELF.Rep_Email := le.RepresentativeEmailAddress;
	
	SELF.DPPA_Purpose := 3;
	SELF.GLBA_Purpose := 1;
	SELF.Data_Restriction_Mask := '0000000000000000000000000';
	SELF.Data_Permission_Mask := dataPermissionMask;
	SELF.HistoryDate := IF(histDate <= 0, le.HistoryDate, histDate);
	SELF.MarketingMode := Marketing_Mode;
	SELF.LinkSearchLevel := link_Search_Level;
	SELF.SIC_Code := le.SIC_Code;
	SELF.NAIC_Code := le.NAIC_Code;
	SELF.BIPBestAppend := BIPBestAppend;
	SELF.BusShellVersion := BusShellVersion;
	SELF.PowID := le.PowID;
	SELF.ProxID := le.ProxID;
	SELF.SeleID :=le.SeleID;
	SELF.OrgID := le.OrgID;
	SELF.UltID := le.UltID;
	SELF.OverrideExperianRestriction := IncludeExperian;
	SELF.AllowedSources := Allowed_Sources;
	SELF.IncludeAuthRepInBIPAppend := Include_AuthRep_In_BIPAppend;
	SELF.CorteraRetrotest := useRetrotestData AND ( ( le.historydate != 0 AND (INTEGER)(((STRING)le.historydate)[1..6]) < 201705 ) OR ignore201705ArchiveDateThreshold );
	SELF.CorteraRetrotestRecords := DATASET([],Cortera.layout_Retrotest_raw); // Set as null for now.
	SELF := [];
END;

InputBusShell := DISTRIBUTE(PROJECT(InputFile, intoSOAP(LEFT)), RANDOM());

SOAPLayout xfm_AttachRetrotestRecs(SOAPLayout le, DATASET(Cortera.layout_Retrotest_raw) ri) :=
  TRANSFORM
    SELF.CorteraRetrotestRecords := ri;
    SELF := le;
    SELF := [];
  END;

InputBusShell_withRetrotestRecs :=
		DENORMALIZE(
    InputBusShell, ds_inputRetrotesterFile,
    LEFT.acctno = RIGHT.acctno,
				GROUP,
    xfm_AttachRetrotestRecs(LEFT,ROWS(RIGHT))
		);

OUTPUT(CHOOSEN(InputBusShell, eyeball), NAMED('Sample_InputBusShell'));
OUTPUT(CHOOSEN(InputBusShell_withRetrotestRecs, eyeball), NAMED('Sample_withRetrotestRecs'));

xLayout := RECORD
	Business_Risk_BIP.Layouts.OutputLayout;
	STRING200 ErrorCode := '';
END;

xLayout myFail(SOAPLayout le) := TRANSFORM
	SELF.ErrorCode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.Input_Echo.AcctNo := le.AcctNo;
	SELF := [];
END;

SOAPBusShell := SOAPCALL(InputBusShell_withRetrotestRecs,
												RoxieIP,
												'Business_Risk_BIP.Business_Shell_Service',
												{InputBusShell_withRetrotestRecs},
												DATASET(xLayout),
												PARALLEL(threads),
												RETRY(3), TIMEOUT(300),
												onFail(myFail(LEFT)));

BusShell := SOAPBusShell (errorcode = '');
BusShellErr := SOAPBusShell (errorcode <> '');
OUTPUT(CHOOSEN(BusShell, eyeball), NAMED('Sample_Shell_Results_BusShell'));
OUTPUT(CHOOSEN(BusShellErr, eyeball), NAMED('Sample_Shell_Errors_BusShell'));
OUTPUT(COUNT(BusShellErr), NAMED('Total_Shell_Errors_BusShell'));

//This Returns any inputs that resulted in an error or whose result was dropped
BusShellErr_Inputs := JOIN(DISTRIBUTE(InputFile, HASH64(AccountNumber)), DISTRIBUTE(BusShell, HASH64(Input_Echo.AcctNo)), LEFT.AccountNumber = RIGHT.Input_Echo.AcctNo, TRANSFORM(InputFileLayout, SELF := LEFT), LEFT ONLY, LOCAL); 
OUTPUT(CHOOSEN(BusShellErr_Inputs, Eyeball), NAMED('Sample_Error_Inputs_BusShell'));
OUTPUT(BusShellErr_Inputs,, outputFile + '_Error_Inputs.csv', CSV(QUOTE('"')), EXPIRE(30), OVERWRITE);

BusShellFinal := BusShell;
OUTPUT(CHOOSEN(BusShellFinal, eyeball), NAMED('Sample_Final_BusShell'));
OUTPUT(COUNT(BusShellFinal), NAMED('Total_Final_BusShell'));
OUTPUT(BusShellFinal,, outputFile + '_BusShell.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);

SASBusShellFinal := Business_Risk_BIP.to_OutputLayout_SAS_v31(PROJECT(BusShellFinal, TRANSFORM(Business_Risk_BIP.Layouts.OutputLayout, SELF := LEFT)));
OUTPUT(CHOOSEN(SASBusShellFinal, eyeball), NAMED('Sample_Final_SAS_BusShell'));
OUTPUT(SASBusShellFinal,, outputFile + '_SAS_Layout_BusShell.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
