/*
 * The following script calls the Address_Shell.Address_Attributes_Service requesting a flat layout
 */

#workunit('name','Address_Shell');

IMPORT Address_Shell, RiskWise, Risk_Indicators, iesp, ut;

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
threads := 30;

roxieIP := riskwise.shortcuts.prod_batch_analytics_roxie;
// roxieIP := riskwise.shortcuts.dev192;
// roxieIP := riskwise.shortcuts.d5;
 
/* ***********************************************
 * Input Options:                                *
 *************************************************
 *  -Address Attributes Version: 0 or 1          *
 *  -Property Info Attributes Version: 0, 1 or 2 *
 *  -ERC Attributes Version: 0: Hardcoded in 		 *
 *		since ERC should no longer be used				 *
 *************************************************/
Address_Attributes_Version := 1;
Property_Info_Attributes_Version := 2;

inFile := '~bpahl::in::sewer_examples';

headerRecords := 0; // Number of header rows on the input file

isCSV := TRUE; // Set to TRUE for CSV, FALSE for flat inFile layout

outFile := '~bpahl::out::Address_Attributes_' + Address_Attributes_Version + '_PropInfoVersion_' + Property_Info_Attributes_Version + '_' + thorlib.wuid() + '.csv';

GatewaysIn := DATASET([
											{'erc', 'http://rw_score_dev:Password01@10.176.68.164:7726/WsGatewayEx?ver_=1.7'},
											{'reportservice', roxieIP}
											], Risk_Indicators.Layout_Gateways_In);
											
/* ***********************************************
 * Read Input File and Convert to Request Layout:*
 *************************************************/
layoutInput := RECORD
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
    STRING WorkPhone;
    STRING income;  
    STRING DLNumber;
    STRING DLState;													
    STRING BALANCE; 
    STRING CHARGEOFFD;  
    STRING FormerName;
    STRING EMAIL;  
    STRING employername;
    INTEGER historydateyyyymm;
END;

rawInput := IF(isCSV, DATASET(inFile, layoutInput, CSV(HEADING(headerRecords), QUOTE('"'))), DATASET(inFile, layoutInput, FLAT));
output(rawInput);

serviceInput := RECORD
	DATASET(iesp.addressattributesreport.t_AddressAttributesReportRequest) AddressAttributesReportRequest;
	DATASET(Risk_Indicators.Layout_Gateways_In) gateways;
	
	// This is a hidden ECL option to turn off ESDL and use a flat layout
	BOOLEAN ReturnFlatLayout := TRUE;
	
	// Hidden options for allowing us to easily request attributes
	STRING30 AddressBasedPRAttrVersion := '';
	STRING30 PropertyInfoAttrVersion := '';
	STRING30 ERCAttrVersion := '';
END;

serviceInput intoRequest(layoutInput le, UNSIGNED c) := TRANSFORM
	AccountNumber := le.Account;
	Address := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_Address,
																		SELF.StreetAddress1 := le.StreetAddress;
																		SELF.City := le.city;
																		SELF.State := le.state;
																		SELF.Zip5 := le.zip;
																		SELF := []
																		))[1];
	aarr := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.addressattributesreport.t_AddressAttributesReportRequest,
																					SELF.SearchBy.Address := Address;
																					SELF.User.AccountNumber := AccountNumber;
																					SELF.User.GLBPurpose := '1';
																					SELF.User.DLPurpose := '3';
																					SELF.User.DataRestrictionMask := '0000000000000101000000000';
																					SELF := []));
	
	SELF.AddressAttributesReportRequest := aarr;
	SELF.gateways := GatewaysIn;
	
	SELF.ReturnFlatLayout := TRUE; // We want a flat layout to write out to the file
	
	SELF.AddressBasedPRAttrVersion := 'AddressBasedPRAttrV' + Address_Attributes_Version;
	SELF.PropertyInfoAttrVersion := 'PropertyInfoAttrV' + Property_Info_Attributes_Version;
	SELF.ERCAttrVersion := 'ERCAttrV0'; //hardcoding this to 0 since ERC is no longer used, per Brenton.
	
	SELF := [];
END;

requestTemp := PROJECT(rawInput, intoRequest(LEFT, COUNTER));

request := IF(records > 0, CHOOSEN(requestTemp, records), requestTemp);

OUTPUT(COUNT(request), NAMED('Num_Records_On_Input'));

OUTPUT(CHOOSEN(request, eyeball), NAMED('Sample_Request'));

xlayout := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	Address_Shell.layoutPropertyCharacteristics;
	STRING200 errorcode;
END;

xlayout myFail(request le) := TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
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

slim := PROJECT(soapout, TRANSFORM(Address_Shell.layoutPropertyCharacteristics, SELF := LEFT));

results := Address_Shell.toLayoutModeling(slim);
OUTPUT(CHOOSEN(results, eyeball), NAMED('Sample_Modeling_Results'));
OUTPUT(results,, outFile, CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);