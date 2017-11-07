/* *** Note that Netacuity is turned ON *** needs to use Cert gateway  
But Model does use Netacuity! */
#workunit('name','Order Score');

import risk_indicators, riskwise, ut, iesp, Models;
//pos 25 of drm must be 0 and pos 11 of dpm must be 1
unsigned record_limit := 0;    //number of records to read from input file; 0 means ALL
unsigned1 threads := 30;  //number of parallel soap calls to make [1..30]
unsigned1 eyeball := 100;
string datapermissionmask := '000000000010'; //position 11 turns on FDN data
string DataRestrictionMask := '0000000000000000000000000';	// byte 6, if 1, restricts experian, byte 8, if 1, restricts equifax, 12 restricts ADVO
unsigned1 glba := 1;
unsigned1 dppa := 3;

roxieIP := Riskwise.shortcuts.prod_batch_neutral; 

//==============  Program uses Consumer Data Only  ====================
InputFile  := ut.foreign_prod + 'jpyon::in::go_6063_btst_input_in';
outfile_name := '~akoenen::out::test_order_score_out_'+ thorlib.wuid();	// this will output your work unit number in your filename
outfile_name_err := '~akoenen::out::test_order_score_out::error:'+ thorlib.wuid();	// this will output your work unit number in your filename
outfile_name_miss := '~akoenen::out::test_order_score_out::misses:'+ thorlib.wuid();
//==============  Program uses Consumer Data Only  ====================
//==================  bt-st input file layout  ========================
BTST_in := record
    string30 	accountnumber := '';
    string30 	firstname := '';
	  string30 	middlename := '';
    string30 	lastname := '';
	  string5	suffix := '';
    string120	streetaddress := '';
    string25 	city := '';
    string2 	state := '';
    string5 	zip := '';
	  string25	country := '';
    string9 	ssn := '';
    string8 	dateofbirth := '';
	  unsigned1	age := 0;       // not used
    string20 	dlnumber := '';
    string2 	dlstate := '';
	  string100	email := '';
	  string120	ipaddress := '';
	  string10 	homephone := '';
    string10 	workphone := '';
	  string100	employername := '';
    string30	formername := '';
    string30 	firstname2 := '';
	  string30 	middlename2 := '';
    string30 	lastname2 := '';
	  string5	suffix2 := '';
    string120	streetaddress2 := '';
    string25 	city2 := '';
    string2 	state2 := '';
    string5 	zip2 := '';
	  string25	country2 := '';
    string9 	ssn2 := '';
    string8 	dateofbirth2 := '';
	  unsigned1	age2 := 0;       // not used
    string20 	dlnumber2 := '';
    string2 	dlstate2 := '';
	  string100	email2 := '';
	  string120	ipaddress2 := '';
	  string10 	homephone2 := '';
    string10 	workphone2 := '';
	  string100	employername2 := '';
    string30	formername2 := '';
    string 	historydate := '';
		string TypeofOrder := ''; //NEW FIELD!!!!!
		string DeviceProviderScore1 := '';//NEW FIELD!!!!!
		string DeviceProviderScore2 := '';//NEW FIELD!!!!!
		string DeviceProviderScore3 := '';//NEW FIELD!!!!!
		string DeviceProviderScore4 := '';//NEW FIELD!!!!!
		integer seq := 0; //leave empty
		string old_acct := '';
end;

Input := IF(record_limit <= 0, DATASET(inputFile, BTST_in, csv(quote('"'))),
                            CHOOSEN(DATASET(inputFile, BTST_in,CSV(QUOTE('"'))), record_limit));

BTST_in Getseq(BTST_in le, integer c) := transform
	self.accountnumber := (string) c;
	self.old_acct := le.accountnumber;
	self := le;
end;

SeqInput := PROJECT(Input(firstname != 'firstname'), Getseq(LEFT, COUNTER));

output(SeqInput, named('SeqInput'));
	
soapLayout := RECORD
	DATASET(iesp.orderscore.t_OrderScoreRequest) OrderScoreRequest := DATASET([], iesp.orderscore.t_OrderScoreRequest);
	INTEGER HistoryDateYYYYMM := 999999;
	STRING historyDateTimeStamp := '';
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
		boolean ExcludeIbehavior;  // temporary field until end of July 2017

END;

soapLayout intoSOAP(Input le, UNSIGNED4 c) := TRANSFORM
self.ExcludeIbehavior := true;  // set this back to false if they would like to include this data for their test

	imputeTest:= if(Stringlib.StringToUppercase(le.typeofOrder) = Risk_Indicators.iid_constants.dIGITALorder,Risk_Indicators.iid_constants.DigitalOrder, Risk_Indicators.iid_constants.PhysicalOrder);
	imputeTest2 := if(imputeTest = Risk_Indicators.iid_constants.dIGITALorder, '1', '0');

	BillTo2 := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.orderscore.t_OrderScoreBillToSearchBy,
						SELF.Name.first  := LE.firstname;
						SELF.Name.middle  := LE.middlename;
						SELF.Name.Last  := le.lastname;
						SELF.Address.StreetAddress1 := (trim(le.streetaddress));
						SELF.Address.city := le.city;
						SELF.Address.State := le.State;
						SELF.Address.Zip5 := le.Zip;
						self.EmailAddress := le.email;
						self.Phone10  := le.homephone;
						self.DriverLicenseNumber  := le.dlnumber;
						self.DriverLicenseState  := le.dlstate;
						self.SSN  := le.ssn;
						self.IPAddress := if(le.ipaddress != '', le.ipaddress, ''); //pOPULATE FOR NET ACUITY
						self.DOB.Year := (integer)le.dateofbirth[1..4];
						SELF.DOB.Month := (integer)le.dateofbirth[5..6];
						SELF.DOB.Day := (integer)le.dateofbirth[7..8];
						SELF := []))[1];
		ShipTo2:= PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.orderscore.t_OrderScoreShipToSearchBy,
						SELF.Name.first  := LE.firstname2;
						SELF.Name.middle  := LE.middlename2;					
						SELF.Name.Last  := le.lastname2;
						SELF.Address.StreetAddress1 := (trim(le.streetaddress2));
						SELF.Address.city := le.city2;
						SELF.Address.State := le.state2;
						SELF.Address.Zip5 := le.zip2;
						self.EmailAddress := le.email2;
						self.Phone10  := le.homephone2;
						self.DriverLicenseNumber  := le.dlnumber2;
						self.DriverLicenseState  := le.dlstate2;
						self.SSN  := le.ssn2;
						self.DOB.Year := (integer)le.dateofbirth2[1..4];
						SELF.DOB.Month := (integer)le.dateofbirth2[5..6];
						SELF.DOB.Day := (integer)le.dateofbirth2[7..8];
						SELF := []))[1];

	
	option := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.orderscore.t_OrderScoreOption,
						SELF.IncludeModels.OrderScore := 'osn1504_0';
						//SELF.AttributesVersionRequest := dataset([{'identityv4'},{'relationshipv4'},{'velocityv4'}], iesp.share.t_StringArrayItem);				
						SELF.DeviceProviderScore1 := le.DeviceProviderScore1; 
						SELF.DeviceProviderScore2 := le.DeviceProviderScore2;
						SELF.DeviceProviderScore3 := le.DeviceProviderScore3; 
						SELF.DeviceProviderScore4 := le.DeviceProviderScore4;	
						SELF.OrderType := imputeTest; //DIGITAL OR PHYSICAL
						SELF := []));
	
	users := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.share.t_User,
						SELF.DataRestrictionMask := DataRestrictionMask;
						SELF.DataPermissionMask := datapermissionmask;
						SELF.AccountNumber := le.AccountNumber;
						SELF.GLBPurpose := (string)glba;
						SELF.DLPurpose := (string) dppa;
						SELF.TestDataEnabled := FALSE;
						SELF.OutcomeTrackingOptOut := TRUE;
						SELF := []));
	
	SELF.OrderScoreRequest := PROJECT(ut.ds_oneRecord, TRANSFORM(iesp.orderscore.t_OrderScoreRequest, 
						SELF.SearchBy.BillTo := BillTo2;
						SELF.SearchBy.ShipTo := ShipTo2;						
						SELF.Options := option[1];
						SELF.User := users[1];
						SELF := []));

  // self.historydateyyyymm := (unsigned) le.historydate[..6];
	  self.historydateyyyymm := map(
			regexfind('^\\d{8} \\d{8}$', le.historydate) => (unsigned)le.historydate[..6],
			regexfind('^\\d{8}$',        le.historydate) => (unsigned)le.historydate[..6],
			                                                (unsigned)le.historydate
	);
	
  self.historyDateTimeStamp := map(
      le.historydate in ['', '999999']             => '',  // leave timestamp blank, query will populate it with the current date   	
			regexfind('^\\d{8} \\d{8}$', le.historydate) => le.historydate,
			regexfind('^\\d{8}$',        le.historydate) => le.historydate +   ' 00000100',
			regexfind('^\\d{6}$',        le.historydate) => le.historydate + '01 00000100',		                                                
			                                                le.historydate
	);
	//self.gateways := riskwise.shortcuts.gw_empty;
	SELF.Gateways := riskwise.shortcuts.gw_netacuityv4 +
	riskwise.shortcuts.gw_delta_prod;
END;
soapInput_nonDist := PROJECT(SeqInput, intoSOAP(LEFT, COUNTER));//DISTRIBUTE(PROJECT(Input, intoSOAP(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(soapInput_nonDist, eyeball), NAMED('Sample_SOAP_Input'));
soapInput := DISTRIBUTE (soapInput_nonDist, RANDOM());

xlayout := RECORD
	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSOut_wAcct ;
	STRING errorcode;
END;

xlayout myFail(soapInput le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	
	SELF := [];
END;

soapResults_raw := SOAPCALL(soapInput, 
				roxieIP,
				'Models.OrderScore_Service', 
				{soapInput}, 
				DATASET(xlayout),
        RETRY(5), TIMEOUT(500), //literal,
        // XPATH('Models.OrderScore_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

soap_Results := soapResults_raw(errorcode='');  // filter out the intermediate logging rows from the response
OUTPUT(CHOOSEN(soap_Results, eyeball), NAMED('Sample_SOAP_Results'));
output(soapResults_raw(errorcode !=''), named('errors'));

xlayoutSeq := RECORD
	iesp.orderscore.t_OrderScoreResponse;
	STRING errorcode;
	STRING Accountnumber;
	string seq;
END;

soapResults := JOIN(SeqInput, soap_Results, 
	left.AccountNumber = right.AccountNumber,
	transform(xlayoutSeq, 
		self.seq := right.accountnumber, 
		self.accountnumber := left.old_acct,
		self := right));

Layout_OrderScore := RECORD
//bill to	
	string30 AccountNumber;
	STRING62 Fullname;
	STRING15 First;
	STRING15 Middle;
	STRING20 Last;
	STRING6 Suffix;
	string3 prefix             ;
	string10 StNum       ;
	string2 PreDir ;
	string28 StName         ;
	string4 stsuffix       ;
	string2 postdir;
	string8 unitdesig    ;
	string8 unitNum         ;
	STRING50 Address1;
	STRING50 Address12;
	string25 city               ;
	string2 state              ;
	string5 zip5               ;
	string4 zip4               ;
	string18 county             ;
	string9 postalco         ;
	string50 stcityzip       ;
	string10 phone10            ;
	string50 emailaddr          ;
	string32 ipaddr             ;
	string9 ssn                ;
	string15 drlc               ;
	string2 drlcSt            ;
	string4 dobyear            ;
	string2 dobmonth           ;
	string2 dobday             ;
		//ship to
	STRING62 Fullname2;
	STRING15 First2;
	STRING15 Middle2;
	STRING20 Last2;
	STRING6 Suffix2;
	string3 prefix2             ;
	string10 StNum2       ;
	string2 PreDir2 ;
	string28 StName2         ;
	string4 stsuffix2       ;
	string2 postdir2;
	string8 unitdesig2    ;
	string8 unitNum2         ;
	STRING50 Address2;
	STRING50 Address22;
	string25 city2               ;
	string2 state2              ;
	string5 zip52               ;
	string4 zip42               ;
	string18 county2             ;
	string9 postalco2         ;
	string50 stcityzip2       ;
	string10 phone102            ;
	string50 emailaddr2          ;
	string32 ipaddr2             ;
	string9 ssn2                ;
	string15 drlc2               ;
	string2 drlcSt2           ;
	string4 dobyear2            ;
	string2 dobmonth2           ;
	string2 dobday2             ;
	//bill to fields
	STRING62 verFull;
	STRING15 verFirst;
	STRING15 verMiddle;
	STRING20 verLast;
	STRING6 verSuffix;
	string3 verprefix             ;
	string10 verStNum       ;
	string2 verPreDir ;
	string28 verStName         ;
	string4 verstsuffix       ;
	string2 verpostdir;
	string8 verunitdesig    ;
	string8 verunitNum         ;
	STRING50 verAddress1;
	STRING50 verAddress12;
	string25 vercity               ;
	string2 verstate              ;
	string5 verzip5               ;
	string4 verzip4               ;
	string18 vercounty             ;
	string9 verpostalco         ;
	string50 verstcityzip       ;
	//bill to corrected
	STRING62 corrFull;
	STRING15 corrFirst;
	STRING15 corrMiddle;
	STRING20 corrLast;
	STRING6 corrSuffix;
	string3 corrprefix             ;
	string10 corrStNum       ;
	string2 corrPreDir ;
	string28 corrStName         ;
	string4 corrStsuffix       ;
	string2 corrpostdir;
	string8 corrunitdesig    ;
	string8 corrunitNum         ;
	STRING50 corrAddress1;
	STRING50 corrAddress12;
	string25 corrcity               ;
	string2 corrstate              ;
	string5 corrzip5               ;
	string4 corrzip4               ;
	string18 corrcounty             ;
	string9 corrpostalco         ;
	string50 corrstcityzip       ;
	string10 corrphone            ;
	string9 corrssn                ;
	//bill to extras	
	string10 phnameaddr        ;
	string1 phonetype              ;
	string1 dwelltype           ;
	string6 sic                    ;
	string2 nas                    ;
	string2 nap                    ;
	string3 areacode               ;
	string4 areayear           ;
	string2 areamonth          ;
	string2 areaday            ;
	//verified ship to
	STRING62 verFull2;
	STRING15 verFirst2;
	STRING15 verMiddle2;
	STRING20 verLast2;
	STRING6 verSuffix2;
	string3 verprefix2             ;
	string10 verStNum2       ;
	string2 verPreDir2 ;
	string28 verStName2         ;
	string4 verstsuffix2       ;
	string2 verpostdir2;
	string8 verunitdesig2    ;
	string8 verunitNum2         ;
	STRING50 verAddress2;
	STRING50 verAddress22;
	string25 vercity2               ;
	string2 verstate2              ;
	string5 verzip52               ;
	string4 verzip42               ;
	string18 vercounty2             ;
	string9 verpostalco2         ;
	string50 verstcityzip2       ;
	//corrected	ship to
	STRING62 corrFull2;
	STRING15 corrFirst2;
	STRING15 corrMiddle2;
	STRING20 corrLast2;
	STRING6 corrSuffix2;
	string3 corrprefix2             ;
	string10 corrStNum2       ;
	string2 corrPreDir2 ;
	string28 corrStName2         ;
	string4 corrstsuffix2       ;
	string2 corrpostdir2;
	string8 corrunitdesig2    ;
	string8 corrunitNum2         ;
	STRING50 corrAddress2;
	STRING50 corrAddress22;
	string25 corrcity2               ;
	string2 corrstate2              ;
	string5 corrzip52               ;
	string4 corrzip42               ;
	string18 corrcounty2             ;
	string9 corrpostalco2         ;
	string50 corrstcityzip2       ;
	string10 corrphone2            ;
	string9 corrssn2                ;
	//ship to extras	
	string10 phnameaddr2       ;
	string1 phonetype2              ;
	string1 dwelltype2           ;
	string6 sic2                    ;
	string2 nas2                    ;
	string2 nap2                    ;
	string3 areacode2               ;
	string4 areayear2           ;
	string2 areamonth2          ;
	string2 areaday2            ;
	//ip
	STRING5   iparea;
	STRING2   iproutetyp;
	STRING50  secdomain;
	STRING1   ipcontinen;
	STRING5   topdomain;
	STRING9   ipzip;
	STRING2   ipstate;
	STRING2   ipcountry;
	//model info
	string10 modelname                ;
	string10 modeltype                ;
	STRING3 modelscore               ;
	string6 riname                   ;
	string4 ricode                   ;
	string150  ridesc                   ;
	string2 riseq               ;
	string6 riname2                  ;
	string4 ricode2                  ;
	string150  ridesc2                  ;
	string2 riseq2              ;
	string6 riname3                  ;
	string4 ricode3                  ;
	string150  ridesc3                  ;
	string2 riseq3              ;
	string6 riname4                  ;
	string4 ricode4                  ;
	string150  ridesc4                  ;
	string2 riseq4              ;
	string6 riname5                  ;
	string4 ricode5                  ;
	string150  ridesc5                  ;
	string2 riseq5              ;
	string6 riname6                  ;
	string4 ricode6                  ;
	string150  ridesc6                  ;
	string2 riseq6              ;
	string6 riname7                  ;
	string4 ricode7                  ;
	string150  ridesc7                  ;
	string2 riseq7              ;
	string6 riname8                  ;
	string4 ricode8                  ;
	string150  ridesc8                  ;
	string2 riseq8              ;
	string6 riname9                  ;
	string4 ricode9                  ;
	string150  ridesc9                  ;
	string2 riseq9              ;
	string6 riname10                 ;
	string4 ricode10                 ;
	string150  ridesc10                 ;
	string2 riseq10             ;
	string6 riname11                 ;
	string4 ricode11                 ;
	string150  ridesc11                 ;
	string2 riseq11             ;
	string6 riname12                 ;
	string4 ricode12                 ;
	string150  ridesc12                 ;
	string2 riseq12             ;

	string seq;
	string200 errorcode;
end;

Layout_OrderScore flatten(xlayoutSeq le) := transform
	self.accountnumber := le.accountnumber;
	//bill to
	self.Fullname:=	le.result.inputecho.BillTo.Name.Full ; 
	self.First:=le.result.inputecho.BillTo.Name.First ; 
	self.Middle:=	le.result.inputecho.BillTo.Name.Middle ; 
	self.Last:=le.result.inputecho.BillTo.Name.Last ; 
	self.Suffix:=	le.result.inputecho.BillTo.Name.Suffix ; 
	self.Prefix:=	le.result.inputecho.BillTo.Name.Prefix ;
	self.Address1:=	le.result.inputecho.BillTo.Address.StreetAddress1 ;
	self.Address12:=le.result.inputecho.BillTo.Address.StreetAddress2 ; 	
	self.StNum:=	le.result.inputecho.BillTo.Address.StreetNumber ; 
	self.StName:=le.result.inputecho.BillTo.Address.StreetName ; 
	self.stsuffix:=le.result.inputecho.BillTo.Address.StreetSuffix ;
	self.PreDir:=	le.result.inputecho.BillTo.Address.StreetPreDirection ; 		
	self.postdir:=	le.result.inputecho.BillTo.Address.StreetPostDirection ; 
	self.unitdesig:=le.result.inputecho.BillTo.Address.UnitDesignation ; 
	self.unitNum:=le.result.inputecho.BillTo.Address.UnitNumber ; 
	self.county:=	le.result.inputecho.BillTo.Address.county ; 	
	self.PostalCo:=	le.result.inputecho.BillTo.Address.PostalCode ;
	self.stcityzip:=le.result.inputecho.BillTo.Address.StateCityZip ; 
	self.city:=	le.result.inputecho.BillTo.Address.City ;
	self.State:=le.result.inputecho.BillTo.Address.State ; 
	self.Zip5:=le.result.inputecho.BillTo.Address.Zip5 ; 	
	self.zip4:=le.result.inputecho.BillTo.Address.Zip4 ; 
	self.phone10:=le.result.inputecho.BillTo.Phone10 ; 
	self.ssn:=le.result.inputecho.BillTo.SSN ; 
	self.emailaddr:=le.result.inputecho.BillTo.EmailAddress ;
	self.ipaddr:=le.result.inputecho.BillTo.IPAddress ;
	self.drlc:=le.result.inputecho.BillTo.DriverLicenseNumber ; 
	self.drlcSt:=	le.result.inputecho.BillTo.DriverLicenseState ;
	self.dobyear := (string)le.result.inputecho.BillTo.DOB.Year ;  
	self.dobmonth :=(string)le.result.inputecho.BillTo.DOB.month; 
	self.dobday :=(string)le.result.inputecho.BillTo.DOB.day ;
// bill to verified
	self.verFull:=	le.result.BillTo.VerifiedInput.Name.Full ; 
	self.verFirst:=le.result.BillTo.VerifiedInput.Name.First ; 
	self.verMiddle:=	le.result.BillTo.VerifiedInput.Name.Middle ; 
	self.verLast:=le.result.BillTo.VerifiedInput.Name.Last ; 
	self.verSuffix:=	le.result.BillTo.VerifiedInput.Name.Suffix ; 
	self.verPrefix:=	le.result.BillTo.VerifiedInput.Name.Prefix ;
	self.verAddress1:=	le.result.BillTo.VerifiedInput.Address.StreetAddress1 ;
	self.verAddress12:=le.result.BillTo.VerifiedInput.Address.StreetAddress2 ; 	
	self.verStNum:=	le.result.BillTo.VerifiedInput.Address.StreetNumber ; 
	self.verStName:=le.result.BillTo.VerifiedInput.Address.StreetName ; 
	self.verstsuffix:=le.result.BillTo.VerifiedInput.Address.StreetSuffix ;
	self.verPreDir:=	le.result.BillTo.VerifiedInput.Address.StreetPreDirection ; 		
	self.verpostdir:=	le.result.BillTo.VerifiedInput.Address.StreetPostDirection ; 
	self.verunitdesig:=le.result.BillTo.VerifiedInput.Address.UnitDesignation ; 
	self.verunitNum:=le.result.BillTo.VerifiedInput.Address.UnitNumber ; 
	 self.vercounty:=	le.result.BillTo.VerifiedInput.Address.county ; 	
	self.verPostalCo:=	le.result.BillTo.VerifiedInput.Address.PostalCode ;
	self.verstcityzip:=le.result.BillTo.VerifiedInput.Address.StateCityZip ; 
	self.verCity:=	le.result.BillTo.VerifiedInput.Address.City ;
	self.verState:=le.result.BillTo.VerifiedInput.Address.State ; 
	 self.verZip5:=le.result.BillTo.VerifiedInput.Address.Zip5 ; 	
	self.verzip4:=le.result.BillTo.VerifiedInput.Address.Zip4 ; 
// bill to corrected
	self.corrFull:=	le.result.BillTo.InputCorrected.Name.Full ; 
	self.corrFirst:=le.result.BillTo.InputCorrected.Name.First ; 
	self.corrMiddle:=	le.result.BillTo.InputCorrected.Name.Middle ; 
	self.corrLast:=le.result.BillTo.InputCorrected.Name.Last ; 
	self.corrSuffix:=	le.result.BillTo.InputCorrected.Name.Suffix ; 
	self.corrPrefix:=	le.result.BillTo.InputCorrected.Name.Prefix ;
	self.corrAddress1:=	le.result.BillTo.InputCorrected.Address.StreetAddress1 ;
	self.corrAddress12:=le.result.BillTo.InputCorrected.Address.StreetAddress2 ; 	
	self.corrStNum:=	le.result.BillTo.InputCorrected.Address.StreetNumber ; 
	self.corrStName:=le.result.BillTo.InputCorrected.Address.StreetName ; 
	self.corrStsuffix:=le.result.BillTo.InputCorrected.Address.StreetSuffix ;
	self.corrPreDir:=	le.result.BillTo.InputCorrected.Address.StreetPreDirection ; 		
	self.corrpostdir:=	le.result.BillTo.InputCorrected.Address.StreetPostDirection ; 
	self.corrunitdesig:=le.result.BillTo.InputCorrected.Address.UnitDesignation ; 
	self.corrunitNum:=le.result.BillTo.InputCorrected.Address.UnitNumber ; 
	self.corrcounty:=	le.result.BillTo.InputCorrected.Address.county ; 	
	self.corrPostalCo:=	le.result.BillTo.InputCorrected.Address.PostalCode ;
	self.corrstcityzip:=le.result.BillTo.InputCorrected.Address.StateCityZip ; 
	self.corrCity:=	le.result.BillTo.InputCorrected.Address.City ;
	self.corrState:=le.result.BillTo.InputCorrected.Address.State ; 
	self.corrZip5:=le.result.BillTo.InputCorrected.Address.Zip5 ; 	
	self.corrzip4:=le.result.BillTo.InputCorrected.Address.Zip4 ; 
	self.corrphone:=le.result.BillTo.InputCorrected.Phone10 ; 	
	self.corrssn:=le.result.BillTo.InputCorrected.SSN ; 
//extras	
	self.phnameaddr := le.Result.BillTo.PhoneOfNameAddress;
	self.nas := le.Result.BillTo.NameAddressSSNSummary;
	self.nap := le.Result.BillTo.NameAddressPhoneSummary;
	self.sic := le.Result.BillTo.SIC ;
	self.phonetype := le.Result.BillTo.PhoneType;
	self.dwelltype := le.Result.BillTo.DwellingType;
	SELF.areacode := (string) le.Result.BillTo.NewAreaCode.AreaCode;
	SELF.areayear:= (string) le.Result.BillTo.NewAreaCode.EffectiveDate.year;
	SELF.areamonth := (string) le.Result.BillTo.NewAreaCode.EffectiveDate.Month;
	SELF.areaday := (string) le.Result.BillTo.NewAreaCode.EffectiveDate.day;

//ship to
	self.Fullname2:=	le.result.inputecho.ShipTo.Name.Full ; 
	self.First2:=le.result.inputecho.ShipTo.Name.First ; 
	self.Middle2:=	le.result.inputecho.ShipTo.Name.Middle ; 
	self.Last2:=le.result.inputecho.ShipTo.Name.Last ; 
	self.Suffix2:=	le.result.inputecho.ShipTo.Name.Suffix ; 
	self.Prefix2:=	le.result.inputecho.ShipTo.Name.Prefix ;
	self.Address2 :=	le.result.inputecho.ShipTo.Address.StreetAddress1 ;
	self.Address22:=le.result.inputecho.ShipTo.Address.StreetAddress2 ; 	
	self.StNum2:=	le.result.inputecho.ShipTo.Address.StreetNumber ; 
	self.StName2:=le.result.inputecho.ShipTo.Address.StreetName ; 
	self.stsuffix2:=le.result.inputecho.ShipTo.Address.StreetSuffix ;
	self.PreDir2:=	le.result.inputecho.ShipTo.Address.StreetPreDirection ; 		
	self.postdir2:=	le.result.inputecho.ShipTo.Address.StreetPostDirection ; 
	self.unitdesig2:=le.result.inputecho.ShipTo.Address.UnitDesignation ; 
	self.unitNum2:=le.result.inputecho.ShipTo.Address.UnitNumber ; 
	self.county2:=	le.result.inputecho.ShipTo.Address.county ; 	
	self.PostalCo2:=	le.result.inputecho.ShipTo.Address.PostalCode ;
	self.stcityzip2:=le.result.inputecho.ShipTo.Address.StateCityZip ; 
	self.city2:=	le.result.inputecho.ShipTo.Address.City ;
	self.State2:=le.result.inputecho.ShipTo.Address.State ; 
	self.Zip52:=le.result.inputecho.ShipTo.Address.Zip5 ; 	
	self.zip42:=le.result.inputecho.ShipTo.Address.Zip4 ; 
	self.phone102:=le.result.inputecho.ShipTo.Phone10 ; 
	self.ssn2:=le.result.inputecho.ShipTo.SSN ; 
	self.emailaddr2:=le.result.inputecho.ShipTo.EmailAddress ;
	self.drlc2:=le.result.inputecho.ShipTo.DriverLicenseNumber ; 
	self.drlcSt2:=	le.result.inputecho.ShipTo.DriverLicenseState ;
	self.dobyear2 := (string)le.result.inputecho.ShipTo.DOB.Year ;  
	self.dobmonth2 :=(string)le.result.inputecho.ShipTo.DOB.month; 
	self.dobday2 :=(string)le.result.inputecho.ShipTo.DOB.day ;
//ship to verified
	self.verFull2:=	le.result.ShipTo.VerifiedInput.Name.Full ; 
	self.verFirst2:=le.result.ShipTo.VerifiedInput.Name.First ; 
	self.verMiddle2:=	le.result.ShipTo.VerifiedInput.Name.Middle ; 
	self.verLast2:=le.result.ShipTo.VerifiedInput.Name.Last ; 
	self.verSuffix2:=	le.result.ShipTo.VerifiedInput.Name.Suffix ; 
	self.verPrefix2:=	le.result.ShipTo.VerifiedInput.Name.Prefix ;
	self.verAddress2:=	le.result.ShipTo.VerifiedInput.Address.StreetAddress1 ;
	self.verAddress22:=le.result.ShipTo.VerifiedInput.Address.StreetAddress2 ; 	
	self.verStNum2:=	le.result.ShipTo.VerifiedInput.Address.StreetNumber ; 
	self.verStName2:=le.result.ShipTo.VerifiedInput.Address.StreetName ; 
	self.verstsuffix2:=le.result.ShipTo.VerifiedInput.Address.StreetSuffix ;
	self.verPreDir2:=	le.result.ShipTo.VerifiedInput.Address.StreetPreDirection ; 		
	self.verpostdir2:=	le.result.ShipTo.VerifiedInput.Address.StreetPostDirection ; 
	self.verunitdesig2:=le.result.ShipTo.VerifiedInput.Address.UnitDesignation ; 
	self.verunitNum2:=le.result.ShipTo.VerifiedInput.Address.UnitNumber ; 
	self.vercounty2:=	le.result.ShipTo.VerifiedInput.Address.county ; 	
	self.verPostalCo2:=	le.result.ShipTo.VerifiedInput.Address.PostalCode ;
	self.verstcityzip2:=le.result.ShipTo.VerifiedInput.Address.StateCityZip ; 
	self.verCity2:=	le.result.ShipTo.VerifiedInput.Address.City ;
	self.verState2:=le.result.ShipTo.VerifiedInput.Address.State ; 
	self.verZip52:=le.result.ShipTo.VerifiedInput.Address.Zip5 ; 	
	self.verzip42:=le.result.ShipTo.VerifiedInput.Address.Zip4 ; 
	// ship to corrected
	self.corrFull2:=	le.result.ShipTo.InputCorrected.Name.Full ; 
	self.corrFirst2:=le.result.ShipTo.InputCorrected.Name.First ; 
	self.corrMiddle2:=	le.result.ShipTo.InputCorrected.Name.Middle ; 
	self.corrLast2:=le.result.ShipTo.InputCorrected.Name.Last ; 
	self.corrSuffix2:=	le.result.ShipTo.InputCorrected.Name.Suffix ; 
	self.corrPrefix2:=	le.result.ShipTo.InputCorrected.Name.Prefix ;
	self.corrAddress2:=	le.result.ShipTo.InputCorrected.Address.StreetAddress1 ;
	self.corrAddress22:=le.result.ShipTo.InputCorrected.Address.StreetAddress2 ; 	
	self.corrStNum2:=	le.result.ShipTo.InputCorrected.Address.StreetNumber ; 
	self.corrStName2:=le.result.ShipTo.InputCorrected.Address.StreetName ; 
	self.corrstsuffix2:=le.result.ShipTo.InputCorrected.Address.StreetSuffix ;
	self.corrPreDir2:=	le.result.ShipTo.InputCorrected.Address.StreetPreDirection ; 		
	self.corrpostdir2:=	le.result.ShipTo.InputCorrected.Address.StreetPostDirection ; 
	self.corrunitdesig2:=le.result.ShipTo.InputCorrected.Address.UnitDesignation ; 
	self.corrunitNum2:=le.result.ShipTo.InputCorrected.Address.UnitNumber ; 
	 self.corrcounty2:=	le.result.ShipTo.InputCorrected.Address.county ; 	
	self.corrPostalCo2:=	le.result.ShipTo.InputCorrected.Address.PostalCode ;
	self.corrstcityzip2:=le.result.ShipTo.InputCorrected.Address.StateCityZip ; 
	self.corrCity2:=	le.result.ShipTo.InputCorrected.Address.City ;
	self.corrState2:=le.result.ShipTo.InputCorrected.Address.State ; 
	self.corrZip52:=le.result.ShipTo.InputCorrected.Address.Zip5 ; 	
	self.corrzip42:=le.result.ShipTo.InputCorrected.Address.Zip4 ; 
	self.corrphone2:=le.result.ShipTo.InputCorrected.Phone10 ; 	
	self.corrssn2:=le.result.ShipTo.InputCorrected.SSN ;	
//extras
	self.phnameaddr2 := le. Result.ShipTo.PhoneOfNameAddress;
	self.nas2 := le.Result.ShipTo.NameAddressSSNSummary;
	self.nap2 := le.Result.ShipTo.NameAddressPhoneSummary;
	self.sic2 := le.Result.ShipTo.SIC ;
	self.phonetype2 := le.Result.ShipTo.PhoneType;
	self.dwelltype2 := le.Result.ShipTo.DwellingType;		
	SELF.areacode2 := (string) le.Result.ShipTo.NewAreaCode.AreaCode;
	SELF.areayear2:= (string) le.Result.ShipTo.NewAreaCode.EffectiveDate.year;
	SELF.areamonth2 := (string) le.Result.ShipTo.NewAreaCode.EffectiveDate.Month;
	SELF.areaday2 := (string) le.Result.ShipTo.NewAreaCode.EffectiveDate.day;
	
	//bill to score info
	bt_reasons := le.Result.models.scores[1].riskindicatorsets(Name='BillTo');
	self.ricode := bt_reasons[1].RiskIndicators[1].RiskCode;
	self.ridesc := bt_reasons[1].RiskIndicators[1].Description;
	self.riseq := (string)bt_reasons[1].RiskIndicators[1].sequence;
	self.ricode2 := bt_reasons[1].RiskIndicators[2].RiskCode;
	self.ridesc2 := bt_reasons[1].RiskIndicators[2].Description;
	self.riseq2 := (string)bt_reasons[1].RiskIndicators[2].sequence;
	self.ricode3 := bt_reasons[1].RiskIndicators[3].RiskCode;
	self.ridesc3 := bt_reasons[1].RiskIndicators[3].Description;
	self.riseq3 := (string)bt_reasons[1].RiskIndicators[3].sequence;
	self.ricode4 := bt_reasons[1].RiskIndicators[4].RiskCode;
	self.ridesc4 := bt_reasons[1].RiskIndicators[4].Description;
	self.riseq4 := (string)bt_reasons[1].RiskIndicators[4].sequence;
	self.ricode5 := bt_reasons[1].RiskIndicators[5].RiskCode;
	self.ridesc5 := bt_reasons[1].RiskIndicators[5].Description;
	self.riseq5 := (string)bt_reasons[1].RiskIndicators[5].sequence;
	self.ricode6 := bt_reasons[1].RiskIndicators[6].RiskCode;
	self.ridesc6 := bt_reasons[1].RiskIndicators[6].Description;
	self.riseq6 :=(string) bt_reasons[1].RiskIndicators[6].sequence;
	//ship to score info
	st_reasons := le.Result.models.scores[1].riskindicatorsets(Name='ShipTo');
	self.ricode7 := st_reasons[1].RiskIndicators[1].RiskCode;
	self.ridesc7 := st_reasons[1].RiskIndicators[1].Description;
	self.riseq7 := (string)st_reasons[1].RiskIndicators[1].sequence;
	self.ricode8 := st_reasons[1].RiskIndicators[2].RiskCode;
	self.ridesc8 := st_reasons[1].RiskIndicators[2].Description;
	self.riseq8 := (string)st_reasons[1].RiskIndicators[2].sequence;
	self.ricode9 := st_reasons[1].RiskIndicators[3].RiskCode;
	self.ridesc9 := st_reasons[1].RiskIndicators[3].Description;
	self.riseq9 := (string)st_reasons[1].RiskIndicators[3].sequence;
	self.ricode10 := st_reasons[1].RiskIndicators[4].RiskCode;
	self.ridesc10 := st_reasons[1].RiskIndicators[4].Description;
	self.riseq10 := (string)st_reasons[1].RiskIndicators[4].sequence;
	self.ricode11 := st_reasons[1].RiskIndicators[5].RiskCode;
	self.ridesc11 := st_reasons[1].RiskIndicators[5].Description;
	self.riseq11 := (string)st_reasons[1].RiskIndicators[5].sequence;
	self.ricode12 := st_reasons[1].RiskIndicators[6].RiskCode;
	self.ridesc12 := st_reasons[1].RiskIndicators[6].Description;
	self.riseq12 := (string)st_reasons[1].RiskIndicators[6].sequence;
	self.modeltype := le.Result.models.scores[1]._Type;
	self.modelscore := (string) le.Result.models.scores[1].Value;
	self.ipcontinen := le.Result.IPAddressID.Continent;
	self.iproutetyp := le.Result.IPAddressID.RoutingType ;
	self.topdomain := le.Result.IPAddressID.TopLevelDomain;
	self.iparea := le.Result.IPAddressID.AreaCode;
	self.secdomain := le.Result.IPAddressID.SecondLevelDomain;
	self.ipcountry := le.Result.IPAddressID.Country;
	self.ipstate := le.Result.IPAddressID.State;
	self.ipzip := le.Result.IPAddressID.Zip;
	self.seq := (string) le.seq;
	self := [];
end;

soap_out  := project(soapresults,flatten(left));
soap_out_sorted := sort(soap_out, (integer) seq);

final_out := record
	Layout_OrderScore -seq -errorcode;
end;
//modeling wants the output in same structure as input
soap_final_out := project(soap_out_sorted, transform(final_out, self := left));

output(choosen(soap_final_out,eyeball),named('output'));
output(soap_final_out,,outfile_name, CSV(heading(single), quote('"')), overwrite);
output(soapResults_raw(errorcode !=''),,outfile_name_err, CSV(heading(single), quote('"')), overwrite);
output(choosen(soapResults_raw(errorcode !=''),20), named('errors__'));

TMPMiss := record
		BTST_in -seq -old_acct;
end;	

misses := join(soap_out_sorted, SeqInput,
	(string) left.seq = (string) right.accountnumber,
	transform(recordof(SeqInput), self.accountnumber := right.old_acct, self := right),
	right only);

	
missedInput := project(misses, transform(TMPMiss, self := left));
	
output(choosen(missedInput, 10), named('missedInput'));	
output(missedInput,,outfile_name_miss, CSV(heading(single), quote('"')));
	
