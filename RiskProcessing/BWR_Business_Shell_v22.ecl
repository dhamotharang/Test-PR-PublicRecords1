#workunit('name', 'Business_Shell_V22');

IMPORT Business_Risk_BIP, RiskProcessing, Risk_Indicators, RiskWise, UT;

eyeball := 100;

Threads := 30;
RecordsToRun := 0; // Set to 0 to run all, otherwise set to the number of records from the inputFile you wish to run

//Business Shell 2.1 accepts YYYYMM, YYYYMMDD, and YYYYMMDDTTTT dates. HistDate can be in any of these forms.
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

dataPermissionMask := ''; // Default - does not allow SBFE data
// dataPermissionMask := '000000000001'; // Allow SBFE data

IncludeExperian := FALSE; // By default, Experian data is not allowed
// IncludeExperian := TRUE; // Override the Experian data restriction and include Experian in results 

Allowed_Sources := Business_Risk_BIP.Constants.Default_AllowedSources; // By default, do NOT include DNB DMI data
// Allowed_Sources := Business_Risk_BIP.Constants.AllowDNBDMI; // Include DNB DMI data. NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY.

Include_AuthRep_In_BIPAppend := FALSE; // Prevent the Authorized Rep from being used to determine the BIP IDs for the company.
// Include_AuthRep_In_BIPAppend := TRUE; // Include the Authorized Rep in determining the BIP IDs for the company.

RoxieIP := RiskWise.shortcuts.prod_batch_neutral;

BusShellVersion := 22; //business shell version 22 is the most recent business shell version and should be the default version run (use bwr_business_shell_v2 for v2 by modeler request ONLY)

inputFileName := '~hmccarl::in::bshell_test_inputs';

outputFile := '~lweiner::out::business_shell_v22_results_' + ThorLib.wuid();

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

InputFile := IF(RecordsToRun <= 0, DATASET(inputFileName, InputFileLayout, CSV(QUOTE('"'))),
																	 CHOOSEN(DATASET(inputFileName, InputFileLayout, CSV(QUOTE('"'))), RecordsToRun));

OUTPUT(CHOOSEN(InputFile, eyeball), NAMED('Sample_Raw_Input'));
OUTPUT(COUNT(InputFile), NAMED('Total_Raw_Input_Records'));

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
END;

SOAPLayout intoSOAP(InputFile le) := TRANSFORM
	SELF.AcctNo := le.AccountNumber;
	SELF.CompanyName := le.CompanyName;
	SELF.AltCompanyName := le.AlternateCompanyName;
	SELF.StreetAddress1 := le.Addr;
	// SELF.StreetAddress2;
	SELF.City := le.City;
	SELF.State := le.State;
	SELF.Zip9 := le.Zip;
	// SELF.Prim_Range;
	// SELF.PreDir;
	// SELF.Prim_Name;
	// SELF.Addr_Suffix;
	// SELF.PostDir;
	// SELF.Unit_Desig;
	// SELF.Sec_Range;
	// SELF.Zip5;
	// SELF.Zip4;
	// SELF.Lat;
	// SELF.Long;
	// SELF.Addr_Type; 
	// SELF.Addr_Status;
	// SELF.County;
	// SELF.Geo_Block;
	SELF.FEIN := le.TaxIdNumber;
	SELF.Phone10 := le.BusinessPhone;
	SELF.IPAddr := le.BusinessIPAddress;
	// SELF.CompanyURL;
	// SELF.Rep_FullName;
	// SELF.Rep_NameTitle;
	SELF.Rep_FirstName := le.RepresentativeFirstName;
	SELF.Rep_MiddleName := le.RepresentativeMiddleName;
	SELF.Rep_LastName := le.RepresentativeLastName;
	SELF.Rep_NameSuffix := le.RepresentativeNameSuffix;
	SELF.Rep_FormerLastName := le.RepresentativeFormerLastName;
	SELF.Rep_StreetAddress1 := le.RepresentativeAddr;
	// SELF.Rep_StreetAddress2;
	SELF.Rep_City := le.RepresentativeCity;
	SELF.Rep_State := le.RepresentativeState;
	SELF.Rep_Zip := le.RepresentativeZip;
	// SELF.Rep_Prim_Range;
	// SELF.Rep_PreDir;
	// SELF.Rep_Prim_Name;
	// SELF.Rep_Addr_Suffix;
	// SELF.Rep_PostDir;
	// SELF.Rep_Unit_Desig;
	// SELF.Rep_Sec_Range;
	// SELF.Rep_Zip5;
	// SELF.Rep_Zip4;
	// SELF.Rep_Lat;
	// SELF.Rep_Long;
	// SELF.Rep_Addr_Type;
	// SELF.Rep_Addr_Status;
	// SELF.Rep_County;
	// SELF.Rep_Geo_Block;
	SELF.Rep_SSN := le.RepresentativeSSN;
	SELF.Rep_DateOfBirth := le.RepresentativeDOB;
	SELF.Rep_Phone10 := le.RepresentativeHomePhone;
	SELF.Rep_Age := le.RepresentativeAge;
	SELF.Rep_DLNumber := le.RepresentativeDLNumber;
	SELF.Rep_DLState := le.RepresentativeDLState;
	SELF.Rep_Email := le.RepresentativeEmailAddress;
	
	SELF.DPPA_Purpose := 1;
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
	SELF := [];
END;

InputBusShell := DISTRIBUTE(PROJECT(InputFile, intoSOAP(LEFT)), RANDOM());

OUTPUT(CHOOSEN(InputBusShell, eyeball), NAMED('Sample_InputBusShell'));

xLayout := RECORD
	Business_Risk_BIP.Layouts.OutputLayout;
	STRING200 ErrorCode := '';
END;

xLayout myFail(SOAPLayout le) := TRANSFORM
	SELF.ErrorCode := FAILCODE + ' ' + FAILMESSAGE;
	SELF.Input_Echo.AcctNo := le.AcctNo;
	SELF := [];
END;

SOAPBusShell := SOAPCALL(InputBusShell,
												RoxieIP,
												'Business_Risk_BIP.Business_Shell_Service',
												{InputBusShell},
												DATASET(xLayout),
												XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
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

SASBusShellFinal := Business_Risk_BIP.to_OutputLayout_SAS_v22(PROJECT(BusShellFinal, TRANSFORM(Business_Risk_BIP.Layouts.OutputLayout, SELF := LEFT)));
OUTPUT(CHOOSEN(SASBusShellFinal, eyeball), NAMED('Sample_Final_SAS_BusShell'));
OUTPUT(SASBusShellFinal,, outputFile + '_SAS_Layout_BusShell.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);