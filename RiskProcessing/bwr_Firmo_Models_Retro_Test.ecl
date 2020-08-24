/*This is a retro test script used to run SeleIDs through the business shell and then taking those results and running them through the three
   three firomgraphic models to return three model results returned in a combined layout listed by SeleID. */

IMPORT Business_Risk_BIP, RiskProcessing, Risk_Indicators, RiskWise, UT, Models_QA;

eyeball := 25;

Threads := 30;
RecordsToRun := 0; // Set to 0 to run all, otherwise set to the number of records from the inputFile you wish to run

//Business Shell 2.1 accepts YYYYMM, YYYYMMDD, and YYYYMMDDTTTT dates. HistDate can be in any of these forms.
histDate := 201709;

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

//Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
 Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

DPPApurpose := 1;
GLBApurpose := 1;

DataRestrictionMask := '0000000000000000000000000';
dataPermissionMask := '0000000000000'; // Default - does not allow SBFE data
// dataPermissionMask := '000000000001'; // Allow SBFE data

IncludeExperian := FALSE; // By default, Experian data is not allowed
// IncludeExperian := TRUE; // Override the Experian data restriction and include Experian in results 

Allowed_Sources := Business_Risk_BIP.Constants.Default_AllowedSources; // By default, do NOT include DNB DMI data
// Allowed_Sources := Business_Risk_BIP.Constants.AllowDNBDMI; // Include DNB DMI data. NO CUSTOMERS CAN USE THIS, FOR RESEARCH PURPOSES ONLY.

Include_AuthRep_In_BIPAppend := FALSE; // Prevent the Authorized Rep from being used to determine the BIP IDs for the company.
// Include_AuthRep_In_BIPAppend := TRUE; // Include the Authorized Rep in determining the BIP IDs for the company.

RoxieIP := RiskWise.shortcuts.prod_batch_neutral;

BusShellVersion := 31; //this version is required to run this process

inputFileName := '~mmarshik::in::seleidset.csv';
// inputFileName := '~khuls::out::business_shell_manipulated_inputs_w20200113-065517';// manipulatted inputs 

outputFileName := '~mmarshik::out::';

in_file := RECORD
String seleid;	
end;

blahInputFile := IF(RecordsToRun <= 0, DATASET(inputFileName, in_file, csv(quote('"'))),
																	 CHOOSEN(DATASET(inputFileName, in_file, csv(quote('"'))), RecordsToRun));

OUTPUT(CHOOSEN(blahInputFile, eyeball), NAMED('Sample_Raw_BlahInput'));
OUTPUT(COUNT(blahInputFile), NAMED('Total_Raw_BlahInput_Records'));	

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

SOAPLayout intoSOAP(blahInputFile le, integer c) := TRANSFORM
	SELF.seq					:= c;
	SELF.DPPA_Purpose := DPPApurpose;
	SELF.GLBA_Purpose := GLBApurpose;
	SELF.Data_Restriction_Mask := DataRestrictionMask;
	SELF.Data_Permission_Mask := dataPermissionMask;
	SELF.HistoryDate := histDate;
	SELF.MarketingMode := Marketing_Mode;
	SELF.LinkSearchLevel := link_Search_Level;
	SELF.BIPBestAppend := BIPBestAppend;
	SELF.BusShellVersion := BusShellVersion;
	SELF.SeleID := (integer)le.SeleID;
	SELF.OverrideExperianRestriction := IncludeExperian;
	SELF.AllowedSources := Allowed_Sources;
	SELF.IncludeAuthRepInBIPAppend := Include_AuthRep_In_BIPAppend;
	SELF := [];
END;

InputBusShell := DISTRIBUTE(PROJECT(blahInputFile, intoSOAP(LEFT, COUNTER)), RANDOM());

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
												PARALLEL(threads),
												RETRY(3), TIMEOUT(300),
												onFail(myFail(LEFT)));

BusShell := SOAPBusShell (errorcode = '' and input_echo.seleid <> 0);
BusShellErr := SOAPBusShell (errorcode <> '');
OUTPUT(CHOOSEN(BusShellErr, eyeball), NAMED('Sample_BusShellErr'));
// OUTPUT (BusShellErr,, outputFileName + 'BusShellErrors.csv' + ThorLib.wuid(), CSV(HEADING(single), QUOTE('"')));

BusShellFinal := PROJECT(BusShell, TRANSFORM(Business_Risk_BIP.Layouts.Shell, SELF := LEFT, SELF := []));
OUTPUT(CHOOSEN(BusShellFinal, eyeball), NAMED('Sample_Final_BusShell'));
OUTPUT(COUNT(BusShellFinal), NAMED('Total_Final_BusShell'));

model_FRMS2003_1_0 := Models_QA.FRMS2003_1_0(BusShellFinal);
model_FRME2003_1_0  := Models_QA.FRME2003_1_0(BusShellFinal);
model_FRMI2003_1_0  := Models_QA.FRMI2003_1_0(BusShellFinal);

OUTPUT(CHOOSEN(model_FRMS2003_1_0, eyeball), NAMED('FRMS2003_1_0'));
OUTPUT(CHOOSEN (model_FRME2003_1_0, eyeball), NAMED('FRME2003_1_0'));
OUTPUT(CHOOSEN (model_FRMI2003_1_0, eyeball), NAMED('FRMI2003_1_0'));

Final_Result := RECORD

Unsigned6 SeleID;
Integer LNRS_Modeled_Marketing_Revenue;
String2 LNRS_Modeled_Marketing_Revenue_Code;
Integer LNRS_Modeled_Marketing_Employee_Count;
String2 LNRS_Modeled_Marketing_Employee_Count_Code;
String LNRS_Modeled_Marketing_Industry;
String70 LNRS_Modeled_Marketing_Industry_Code_Description;

END;

First_Join := join(model_FRMS2003_1_0, model_FRME2003_1_0, (left.seq = right.seq), 
                    transform (Final_result, self.SeleID := right.seq;
                                             self.LNRS_Modeled_Marketing_Revenue := (Integer)left.score, 
                                             self.LNRS_Modeled_Marketing_Revenue_Code := map(
																						 (integer)left.score >= 1 and (integer)left.score < 100000  => '10',
																						 (integer)left.score >= 100000 and (integer)left.score < 150000  => '20',
																						 (integer)left.score >= 150000 and (integer)left.score < 250000  => '30',
																						 (integer)left.score >= 250000 and (integer)left.score < 500000  => '40',
																						 (integer)left.score >= 500000 and (integer)left.score < 1000000  => '50',
																						 (integer)left.score >= 1000000 and (integer)left.score < 2500000  => '60',
																						 (integer)left.score >= 2500000 and (integer)left.score < 5000000  => '70',
																						 (integer)left.score >= 5000000 and (integer)left.score < 10000000  => '80',
																						 (integer)left.score > 10000000  => '90',
																						 '-1');
                                             self.LNRS_Modeled_Marketing_Employee_Count := (Integer)right.score;
                                             self.LNRS_Modeled_Marketing_Employee_Count_Code := map( 
																						 (integer)right.score >= 1 and (integer)right.score < 5 => '10', 
																						 (integer)right.score >= 5 and (integer)right.score < 10  => '20',
																						 (integer)right.score >= 10 and (integer)right.score < 20  => '30',
																						 (integer)right.score >= 20 and (integer)right.score < 50  => '40',
																						 (integer)right.score >= 50 and (integer)right.score < 100  => '50',
																						 (integer)right.score >= 100 and (integer)right.score < 250  => '60',
																						 (integer)right.score >= 250  => '70',
																						 '-1');
                                             self.LNRS_Modeled_Marketing_Industry := '';
																						 self.LNRS_Modeled_Marketing_Industry_Code_Description := '';),
                    left outer, atmost(1000));
                    
OUTPUT(CHOOSEN(First_Join, eyeball), NAMED('First_Join'));
                    
Second_Join := join(First_Join, model_FRMI2003_1_0, (left.SeleID = right.seq), 
                    transform (Final_result, self.LNRS_Modeled_Marketing_Industry := right.score; 
										self.LNRS_Modeled_Marketing_Industry_Code_Description := map(  
										(integer)right.score = 10  => 'Agriculture, Forestry, Mining And Fishing',
										(integer)right.score = 15  => 'Construction',
										(integer)right.score = 20  => 'Manufacturing',
										(integer)right.score = 40  => 'Transportation, Communications, Electric, Gas, And Sanitary Services',
										(integer)right.score = 50  => 'Wholesale Trade',
										(integer)right.score = 52  => 'Retail Trade', 
										(integer)right.score = 60  => 'Finance, Insurance, And Real Estate',
										(integer)right.score = 70  => 'Personal and Business Services',
										(integer)right.score = 80  => 'Medical, Legal and Accounting Services',
										(integer)right.score = 90  => 'Public Administration',
										'Unable to Calculate');
										self := left;),
                    left outer, atmost(1000));
                    
OUTPUT(CHOOSEN(Second_Join, eyeball), NAMED('Second_Join'));

Final_Join := join(Second_Join, InputBusShell, (left.SeleID = right.seq), 
                    transform (Final_result, 
                      self.SeleID := right.SeleID; 
                      self := left;),
                      left outer, atmost(1000));
                    
OUTPUT(CHOOSEN(Final_Join, eyeball), NAMED('Final_Results'));

OUTPUT (Final_Join,, outputFileName + 'Firmo_Models_Results.csv' + ThorLib.wuid(), CSV(HEADING(single), QUOTE('"')));
