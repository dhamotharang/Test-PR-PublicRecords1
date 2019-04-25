/*
 * The following script calls the Address_Shell.Address_Attributes_Service requesting a flat layout
 */

#workunit('name','Address_Shell');

IMPORT Address_Shell, RiskWise, Risk_Indicators, iesp, ut,scoring_project_pip;

/* ***********************************************
 * Options:                                      *
 *************************************************
 *  -Eyeball: Sample number of records to show   *
 *  -Records: 0 for All, otherwise number of recs*
 *  -Threads: 1 through 30 parrallel threads     *
 *  -RoxieIP: Location of the Address_Shell      *
 *************************************************/
eyeball := 100;
records := 0;
threads := 2;

roxieIP := riskwise.shortcuts.prod_batch_neutral;
// roxieIP := riskwise.shortcuts.dev192;
// roxieIP := riskwise.shortcuts.dev196;
// roxieIP := riskwise.shortcuts.d5;
 
/* ***********************************************
 * Input Options:                                *
 *************************************************
 *  -Address Attributes Version: 0 or 1          *
 *  -Property Info Attributes Version: 0, 1 or 2 *
 *  -ERC Attributes Version: 0 or 1              *
 *************************************************/
Address_Attributes_Version := 1;
Property_Info_Attributes_Version := 1;     //V1 or V2
ERC_Attributes_Version := 0;

inFile := scoring_project_pip.Input_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_infile;

headerRecords := 1; // Number of header rows on the input file

isCSV := FALSE; // Set to TRUE for CSV, FALSE for flat inFile layout
DRM :=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.DRM;
GLB :=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.GLB;  
DLPurpose:=scoring_project_pip.User_Settings_Module.AddressShell_Attributes_V1_BATCH_Generic_settings.DLPurpose;

outFile := '~ScoringQA::out::AddressShell_Address_Attributes_Redo__PRVersion_' + Address_Attributes_Version + '_PropInfoVersion_' + Property_Info_Attributes_Version + '_' + thorlib.wuid();

GatewaysIn := DATASET([
											{'erc', ''},
											{'reportservice', roxieIP}
											], Risk_Indicators.Layout_Gateways_In);
											
/* ***********************************************
 * Read Input File and Convert to Request Layout:*
 *************************************************/
layoutInput := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

rawInput := IF(isCSV, DATASET(inFile, layoutInput, CSV(HEADING(headerRecords), QUOTE('"'))), DATASET(inFile, layoutInput, FLAT));

serviceInput := RECORD
	string seq;
	string acctno;
	DATASET(iesp.addressattributesreport.t_AddressAttributesReportRequest) AddressAttributesReportRequest;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	
	// This is a hidden ECL option to turn off ESDL and use a flat layout
	BOOLEAN ReturnFlatLayout := TRUE;
		STRING50 DataRestrictionMask;	
	// Hidden options for allowing us to easily request attributes
	STRING30 AddressBasedPRAttrVersion := '';
	STRING30 PropertyInfoAttrVersion := '';
	STRING30 ERCAttrVersion := '';
END;

serviceInput intoRequest(layoutInput le, UNSIGNED c) := TRANSFORM
	self.seq := (string)c;	
	self.acctno :=(string)le.AccountNumber;
	AccountNumber := le.AccountNumber;
	Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address,
																		SELF.StreetAddress1 := le.StreetAddress;
																		SELF.City := le.city;
																		SELF.State := le.state;
																		SELF.Zip5 := le.zip;
																		SELF := []
																		))[1];
	aarr := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.addressattributesreport.t_AddressAttributesReportRequest,
																					SELF.SearchBy.Address := Address;
																					SELF.User.AccountNumber := (string)le.AccountNumber;
																					SELF.User.GLBpurpose :=(string)GLB;
																					SELF.User.DataRestrictionMask :=(string)DRM;
																					SELF.User.DLPurpose :=(string)DLPurpose;
																					SELF := []));
	
	SELF.AddressAttributesReportRequest := aarr;
	SELF.gateways := GatewaysIn;
	
	SELF.ReturnFlatLayout := TRUE; // We want a flat layout to write out to the file
	SELF.DataRestrictionMask := DRM;
	SELF.AddressBasedPRAttrVersion := 'AddressBasedPRAttrV' + Address_Attributes_Version;
	SELF.PropertyInfoAttrVersion := 'PropertyInfoAttrV' + Property_Info_Attributes_Version;
	SELF.ERCAttrVersion := 'ERCAttrV' + ERC_Attributes_Version;
	
	SELF := [];
END;

requestTemp := DISTRIBUTE(PROJECT(rawInput, intoRequest(LEFT, COUNTER)), RANDOM());

request := IF(records > 0, CHOOSEN(requestTemp, records), requestTemp);

OUTPUT(COUNT(request), NAMED('Num_Records_On_Input'));

OUTPUT(CHOOSEN(request, eyeball), NAMED('Sample_Request'));

xlayout := RECORD
	string acctno;
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	Address_Shell.layoutPropertyCharacteristics;
	STRING200 errorcode;
END;

xlayout myFail(request le) := TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
		self.acctno := le.acctno;
	SELF := le;
	SELF := [];
END;

soapout := SOAPCALL(request, 
										RoxieIP, 
										'Address_Shell.Address_Attributes_Service', 
										{request}, 
										DATASET(xlayout), 
										PARALLEL(threads),
										onFail(myFail(LEFT)));
OUTPUT(COUNT(soapout), NAMED('Num_Records_From_SOAP'));
OUTPUT(CHOOSEN(soapout, eyeball), NAMED('Sample_Soap_Results'));

// slim := PROJECT(soapout, TRANSFORM(Address_Shell.layoutPropertyCharacteristics, SELF := LEFT));

// results := Address_Shell.toLayoutModeling(slim);
// OUTPUT(CHOOSEN(results, eyeball), NAMED('Sample_Modeling_Results'));
OUTPUT(soapout,, outFile, thor, EXPIRE(30), OVERWRITE);