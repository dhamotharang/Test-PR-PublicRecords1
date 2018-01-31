
/* RiskProcessing.BWR_Business_InstantID_20 */

#workunit('name','Business InstantID 2.0');
#option ('hthorMemoryLimit', 1000);

IMPORT Business_Risk_BIP, BusinessInstantID20_Services, Gateway, iesp, Risk_Indicators, RiskWise, ut;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * BIID20ProductType: Denotes which version of the BIID 2.0 product   *
 *  to run. See comments immediately below for which value points to  *
 *  which product version. NOTE!!! The decision whether to run SBFE   *
 *  is determined solely by selecting the appropriate ProductType.    *
 * recordsToRun: Number of records to run through the service. Set    *
 *  to 0 to run all.                                                  *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * RoxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/

// BIID20ProductType := 3;  // BASE plus COMPLIANCE plus SBFE (***RESTRICTED: SBFE data***)
BIID20ProductType := 2;	// BASE plus COMPLIANCE (***DEFAULT***)
// BIID20ProductType := 1;	// BASE

// Set this to TRUE to force Experian data to be fetched, regardless of business rules.
_OverRideExperianRestriction := FALSE;
 
recordsToRun := 0; // Set to 0 (zero) to run all records.
eyeball      := 10;
threads      := 30;

RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
 // RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev192;                  // Development Roxie 192
// RoxieIP := RiskWise.shortcuts.Dev194;                  // Development Roxie 194

// Universally Set the History Date for ALL records. Set to 0 to use the History Date 
// located on each record of the input file.
historydate := 0;

// To process real time use this:
 // historydate := 999999; // e.g. YYYYMM; but can handle also YYYYMMDD, YYYYMMDDTTTT.

// SBFE/non-SBFE attributes for query behavior. NOTE: For the system to return SBFE data 
// and to perform calculations using SBFE data, the DataPermissionMask value must be set
// appropriately; this is done below based on which BIID20ProductType was selected.
includeSBFE := BIID20ProductType = 3;

DataPermissionMask := IF( includeSBFE, '0000000000010000', '0000000000000000' );
FilenameSuffix     := IF( includeSBFE, '_sbfe_', '_nonsbfe_');

GLBA := 1;
DPPA := 3;

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// File names.
inputFile := // ut.foreign_prod + 'jpyon::in::rbs_1179_bus_bus_con_f_s_in';
		ut.foreign_prod + 'jpyon::in::chase_7511_file2_biid_f_s_8byte_test_in';
outputFile := '~calbee::out::chase_7511_new_file2_test_biid_BIID20_results2' + FilenameSuffix + ThorLib.wuid();

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
 
// 1.  Read in BIID requests. 
//
// NOTE: If there is only one Auth Rep, then the layout below is standard such that
// Auth Reps 2-5 can be safely omitted from the input file; the file will still load.
layout := RECORD
	 string30  AccountNumber;
	 string100 CompanyName;
	 string100 AltCompanyName;
	 string50  Addr;
	 string30  City;
	 string2   State;
	 string9   Zip;
	 string10  BusinessPhone;
	 string9   TaxIdNumber;
	 string16  BusinessIPAddress;
	 string15  Rep1firstname;
	 string15  Rep1MiddleName;
	 string20  Rep1lastname;
	 string5   Rep1NameSuffix;
	 string50  Rep1Addr;
	 string30  Rep1City;
	 string2   Rep1State;
	 string9   Rep1Zip;
	 string9   Rep1SSN;
	 string8   Rep1DOB;
	 string3   Rep1Age;
	 string20  Rep1DLNumber;
	 string2   Rep1DLState;
	 string10  Rep1HomePhone;
	 string50  Rep1EmailAddress;
	 string20  Rep1FormerLastName; 
	 integer   HistoryDate; // Either YYYYMM, YYYYMMDD, YYYYMMDDTTTT
	 
	 string15  Rep2firstname := '';
	 string15  Rep2MiddleName := '';
	 string20  Rep2lastname := '';
	 string5   Rep2NameSuffix := '';
	 string50  Rep2Addr := '';
	 string30  Rep2City := '';
	 string2   Rep2State := '';
	 string9   Rep2Zip := '';
	 string9   Rep2SSN := '';
	 string8   Rep2DOB := '';
	 string3   Rep2Age := '';
	 string20  Rep2DLNumber := '';
	 string2   Rep2DLState := '';
	 string10  Rep2HomePhone := '';
	 string50  Rep2EmailAddress := '';
	 string20  Rep2FormerLastName := '';

	 string15  Rep3firstname := '';
	 string15  Rep3MiddleName := '';
	 string20  Rep3lastname := '';
	 string5   Rep3NameSuffix := '';
	 string50  Rep3Addr := '';
	 string30  Rep3City := '';
	 string2   Rep3State := '';
	 string9   Rep3Zip := '';
	 string9   Rep3SSN := '';
	 string8   Rep3DOB := '';
	 string3   Rep3Age := '';
	 string20  Rep3DLNumber := '';
	 string2   Rep3DLState := '';
	 string10  Rep3HomePhone := '';
	 string50  Rep3EmailAddress := '';
	 string20  Rep3FormerLastName := '';
	 
	 string15  Rep4firstname := '';
	 string15  Rep4MiddleName := '';
	 string20  Rep4lastname := '';
	 string5   Rep4NameSuffix := '';
	 string50  Rep4Addr := '';
	 string30  Rep4City := '';
	 string2   Rep4State := '';
	 string9   Rep4Zip := '';
	 string9   Rep4SSN := '';
	 string8   Rep4DOB := '';
	 string3   Rep4Age := '';
	 string20  Rep4DLNumber := '';
	 string2   Rep4DLState := '';
	 string10  Rep4HomePhone := '';
	 string50  Rep4EmailAddress := '';
	 string20  Rep4FormerLastName := '';
	 
	 string15  Rep5firstname := '';
	 string15  Rep5MiddleName := '';
	 string20  Rep5lastname := '';
	 string5   Rep5NameSuffix := '';
	 string50  Rep5Addr := '';
	 string30  Rep5City := '';
	 string2   Rep5State := '';
	 string9   Rep5Zip := '';
	 string9   Rep5SSN := '';
	 string8   Rep5DOB := '';
	 string3   Rep5Age := '';
	 string20  Rep5DLNumber := '';
	 string2   Rep5DLState := '';
	 string10  Rep5HomePhone := '';
	 string50  Rep5EmailAddress := '';
	 string20  Rep5FormerLastName := '';
END;

ds_input := 
	IF(
		recordsToRun <= 0, 
		DATASET(inputFile, layout, CSV(QUOTE('"'))), 
		CHOOSEN( DATASET(inputFile, layout, CSV(QUOTE('"'))), recordsToRun )
	);

// 2.  Construct SOAPCALL request.
layout_soap := RECORD
	DATASET(BusinessInstantID20_Services.Layouts.BatchInput) Batch_In;
	// Option Fields 
	INTEGER DPPAPurpose;
	INTEGER GLBPurpose;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	STRING IndustryClass;
	INTEGER HistoryDate;
	INTEGER MarketingMode;
	INTEGER BusShellVersion;
	INTEGER BIID20ProductType;
	DATASET(iesp.Share.t_StringArrayItem) WatchlistsRequested;
	DATASET(Gateway.Layouts.Config) Gateways;
	BOOLEAN ForRetroTesting;
	INTEGER LinkSearchLevel;
	BOOLEAN OverRideExperianRestriction;

	// Configurability flags, options, for Consumer InstantID section of Business InstantID 2.0.
	// Adapted from RiskProcessing.bwr_CIID_FP_Red_Flags_v1.
	BOOLEAN PoBoxCompliance;
	INTEGER OFAC_Version;
	REAL Global_Watchlist_Threshold;
	BOOLEAN OfacOnly;
	BOOLEAN IncludeOfac;
	BOOLEAN IncludeAdditionalWatchLists;
	BOOLEAN Usedobfilter;
	INTEGER DOBradius;
	STRING  DOBMatchType;
	INTEGER DOBMatchYearRadius;
	BOOLEAN IncludeMSoverride;	
	BOOLEAN IncludeCLoverride;	
	BOOLEAN IncludeDLVerification;	
	STRING44 PassportUpperLine;	
	STRING44 PassportLowerLine;	
	STRING6 Gender;	
	BOOLEAN ExactFirstNameMatch;	
	BOOLEAN ExactFirstNameMatchAllowNicknames;	
	BOOLEAN ExactLastNameMatch;	
	BOOLEAN ExactPhoneMatch;	
	BOOLEAN ExactSSNMatch;	
	BOOLEAN IncludeAllRiskIndicators;	
	UNSIGNED3 LastSeenThreshold;	// defaults to 365 but can be changed to say how many days you would like address verification to look back for
	STRING6 InstantIDVersion;	    // this should be set to 1
	BOOLEAN IIDVersionOverride;	  // this allows a customer to go below the lowest forced version of ciid
	BOOLEAN IncludeDOBInCVI;	    // allows the dob verification to affect cvi
	BOOLEAN IncludeDriverLicenseInCVI;	// allows drivers license verification to affect cvi, used with IncludeDLVerification (needs to be true)
	BOOLEAN IncludeMIoverride;	  // will set CVI = 10 for MI reason codes
	BOOLEAN DisableCustomerNetworkOptionInCVI;	 // will disable the inquiry NAP dataset
	BOOLEAN DisallowInsurancePhoneHeaderGateway; // will disable the insurance gateway NAP dataset
	BOOLEAN EnableEmergingID;     // for AmEx - do additional searches to assign a DID - set this option in the transform below 	
	STRING  NameInputOrder;       // if customer wants to specify the order of the input full name field - see options below 	
END;

layout_soap transform_input_request(layout le, INTEGER _counter) := 
	TRANSFORM	
		SELF.Batch_In := 
				DATASET( 1, // Transform all strings to upper case
					TRANSFORM( BusinessInstantID20_Services.Layouts.BatchInput,
						SELF.Seq                 := _counter;
						SELF.AcctNo              := le.AccountNumber;
						SELF.HistoryDate         := IF( historydate = 0, le.HistoryDate, historydate );
						SELF.CompanyName         := le.CompanyName;
						SELF.AltCompanyName      := le.AltCompanyName;
						SELF.StreetAddress1      := le.Addr;
						SELF.StreetAddress2      := '';
						SELF.City                := le.City;
						SELF.State               := le.State;
						SELF.Zip                 := le.Zip;
						SELF.FEIN                := le.TaxIdNumber;
						SELF.Phone10             := le.BusinessPhone;	
						
						SELF.Rep1_FullName       := '';
						SELF.Rep1_FirstName      := le.Rep1FirstName;
						SELF.Rep1_MiddleName     := le.Rep1MiddleName;
						SELF.Rep1_LastName       := le.Rep1LastName;
						SELF.Rep1_NameSuffix     := le.Rep1NameSuffix;
						SELF.Rep1_FormerLastName := le.Rep1FormerLastName;
						SELF.Rep1_StreetAddress1 := le.Rep1Addr;
						SELF.Rep1_StreetAddress2 := '';
						SELF.Rep1_City           := le.Rep1City;
						SELF.Rep1_State          := le.Rep1State;
						SELF.Rep1_Zip            := le.Rep1Zip;
						SELF.Rep1_SSN            := le.Rep1SSN;
						SELF.Rep1_DateOfBirth    := le.Rep1DOB;
						SELF.Rep1_Age            := le.Rep1Age;
						SELF.Rep1_DLNumber       := le.Rep1DLNumber;
						SELF.Rep1_DLState        := le.Rep1DLState;
						SELF.Rep1_Phone10        := le.Rep1HomePhone;

						SELF.Rep2_FullName       := '';
						SELF.Rep2_FirstName      := le.Rep2FirstName;
						SELF.Rep2_MiddleName     := le.Rep2MiddleName;
						SELF.Rep2_LastName       := le.Rep2LastName;
						SELF.Rep2_NameSuffix     := le.Rep2NameSuffix;
						SELF.Rep2_FormerLastName := le.Rep2FormerLastName;
						SELF.Rep2_StreetAddress1 := le.Rep2Addr;
						SELF.Rep2_StreetAddress2 := '';
						SELF.Rep2_City           := le.Rep2City;
						SELF.Rep2_State          := le.Rep2State;
						SELF.Rep2_Zip            := le.Rep2Zip;
						SELF.Rep2_SSN            := le.Rep2SSN;
						SELF.Rep2_DateOfBirth    := le.Rep2DOB;
						SELF.Rep2_Age            := le.Rep2Age;
						SELF.Rep2_DLNumber       := le.Rep2DLNumber;
						SELF.Rep2_DLState        := le.Rep2DLState;
						SELF.Rep2_Phone10        := le.Rep2HomePhone;

						SELF.Rep3_FullName       := '';
						SELF.Rep3_FirstName      := le.Rep3FirstName;
						SELF.Rep3_MiddleName     := le.Rep3MiddleName;
						SELF.Rep3_LastName       := le.Rep3LastName;
						SELF.Rep3_NameSuffix     := le.Rep3NameSuffix;
						SELF.Rep3_FormerLastName := le.Rep3FormerLastName;
						SELF.Rep3_StreetAddress1 := le.Rep3Addr;
						SELF.Rep3_StreetAddress2 := '';
						SELF.Rep3_City           := le.Rep3City;
						SELF.Rep3_State          := le.Rep3State;
						SELF.Rep3_Zip            := le.Rep3Zip;
						SELF.Rep3_SSN            := le.Rep3SSN;
						SELF.Rep3_DateOfBirth    := le.Rep3DOB;
						SELF.Rep3_Age            := le.Rep3Age;
						SELF.Rep3_DLNumber       := le.Rep3DLNumber;
						SELF.Rep3_DLState        := le.Rep3DLState;
						SELF.Rep3_Phone10        := le.Rep3HomePhone;

						SELF.Rep4_FullName       := '';
						SELF.Rep4_FirstName      := le.Rep4FirstName;
						SELF.Rep4_MiddleName     := le.Rep4MiddleName;
						SELF.Rep4_LastName       := le.Rep4LastName;
						SELF.Rep4_NameSuffix     := le.Rep4NameSuffix;
						SELF.Rep4_FormerLastName := le.Rep4FormerLastName;
						SELF.Rep4_StreetAddress1 := le.Rep4Addr;
						SELF.Rep4_StreetAddress2 := '';
						SELF.Rep4_City           := le.Rep4City;
						SELF.Rep4_State          := le.Rep4State;
						SELF.Rep4_Zip            := le.Rep4Zip;
						SELF.Rep4_SSN            := le.Rep4SSN;
						SELF.Rep4_DateOfBirth    := le.Rep4DOB;
						SELF.Rep4_Age            := le.Rep4Age;
						SELF.Rep4_DLNumber       := le.Rep4DLNumber;
						SELF.Rep4_DLState        := le.Rep4DLState;
						SELF.Rep4_Phone10        := le.Rep4HomePhone;

						SELF.Rep5_FullName       := '';
						SELF.Rep5_FirstName      := le.Rep5FirstName;
						SELF.Rep5_MiddleName     := le.Rep5MiddleName;
						SELF.Rep5_LastName       := le.Rep5LastName;
						SELF.Rep5_NameSuffix     := le.Rep5NameSuffix;
						SELF.Rep5_FormerLastName := le.Rep5FormerLastName;
						SELF.Rep5_StreetAddress1 := le.Rep5Addr;
						SELF.Rep5_StreetAddress2 := '';
						SELF.Rep5_City           := le.Rep5City;
						SELF.Rep5_State          := le.Rep5State;
						SELF.Rep5_Zip            := le.Rep5Zip;
						SELF.Rep5_SSN            := le.Rep5SSN;
						SELF.Rep5_DateOfBirth    := le.Rep5DOB;
						SELF.Rep5_Age            := le.Rep5Age;
						SELF.Rep5_DLNumber       := le.Rep5DLNumber;
						SELF.Rep5_DLState        := le.Rep5DLState;
						SELF.Rep5_Phone10        := le.Rep5HomePhone;

						SELF := [];
					)
				);
			
		// Options
		SELF.DPPAPurpose                := DPPA;
		SELF.GLBPurpose                 := GLBA;
		SELF.DataRestrictionMask        := '0000000000000000';
		SELF.DataPermissionMask         := DataPermissionMask;
		SELF.IndustryClass              := '';
		SELF.HistoryDate                := IF( historydate = 0, le.HistoryDate, historydate );
		SELF.MarketingMode              := Marketing_Mode;
		SELF.BusShellVersion            := 22;  // The value 22 is required for this product.
		SELF.BIID20ProductType          := BIID20ProductType;
		SELF.WatchlistsRequested        := Business_Risk_BIP.Constants.Default_Watchlists_Requested;
		SELF.Gateways                   := Business_Risk_BIP.Constants.Default_Gateways_Requested;
		SELF.ForRetroTesting            := TRUE;
		SELF.OverRideExperianRestriction := _OverRideExperianRestriction;

		// Configurability flags, options, for Consumer InstantID section of Business InstantID 2.0.
		SELF.PoBoxCompliance             := FALSE;
		SELF.OFAC_Version                := 2;
		SELF.Global_Watchlist_Threshold  := 0.84;
		SELF.OfacOnly                    := FALSE;
		SELF.IncludeOfac                 := TRUE;
		SELF.IncludeAdditionalWatchLists := FALSE;
		SELF.Usedobfilter                := FALSE; // This must be set to TRUE for DOBMatchType, DOBMatchYearRadius to work.
		SELF.DOBradius                   := 2;
		// To poulate the next two values appropriately, please see RiskProcessing.bwr_CIID_FP_Red_Flags_v1,
		// lines 212-213.
//		SELF.DOBMatchType                := ''; // options 'FuzzyCCYYMMDD','FuzzyCCYYMM''ExactCCYYMMDD''ExactCCYYMM''RadiusCCYY'
//		SELF.DOBMatchYearRadius          := 0;
		SELF.IncludeMSoverride           := FALSE;
		SELF.IncludeCLoverride           := FALSE;
		SELF.IncludeDLVerification       := TRUE;
		SELF.PassportUpperLine           := '';
		SELF.PassportLowerLine           := '';
		SELF.Gender                      := '';
		SELF.ExactFirstNameMatch         := FALSE;
		SELF.ExactFirstNameMatchAllowNicknames := FALSE;
		SELF.ExactLastNameMatch          := FALSE;
		SELF.ExactPhoneMatch             := FALSE;
		SELF.ExactSSNMatch               := FALSE;
		SELF.IncludeAllRiskIndicators    := TRUE;

		// new stuff for v1
		SELF.LastSeenThreshold           := risk_indicators.iid_constants.oneyear;
		SELF.InstantIDVersion            := '1';
		SELF.IIDVersionOverride          := FALSE;
		SELF.IncludeDOBInCVI             := TRUE;
		SELF.IncludeDriverLicenseInCVI   := TRUE;
		SELF.IncludeMIoverride           := FALSE;
		SELF.DisableCustomerNetworkOptionInCVI := FALSE;
		SELF.DisallowInsurancePhoneHeaderGateway := FALSE;

		// new fields for Emerging Identities
		SELF.EnableEmergingID := false;  //set to true to do additional DID searching (primarily for AmEx)
		SELF.NameInputOrder   := '';     // if customer wants to specify the order of input name

		SELF := [];
	END;

BIID20_input := DISTRIBUTE( PROJECT(ds_input, transform_input_request(LEFT,COUNTER)), RANDOM() );

OUTPUT(COUNT(ds_input), NAMED('COUNT_input_records'));
OUTPUT(CHOOSEN(ds_input, eyeball), NAMED('ds_input_sample'));
OUTPUT(CHOOSEN(BIID20_input, eyeball), NAMED('BIID20_input_sample'));

// Now carry out the SOAPCALL to obtain results.

BIID20_Output_layout := RECORD
	BusinessInstantID20_Services.layouts.OutputLayout_batch;
	STRING ErrorCode;
END;

BIID20_Output_layout myFail(BIID20_input le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Seq := le.batch_in[1].Seq;
	SELF.acctno := le.batch_in[1].AcctNo;
	SELF := le;
	SELF := [];
END;

// Round #1:
BIID20_results_raw := 
				SOAPCALL(BIID20_input, 
				RoxieIP,
				'BusinessInstantID20_Services.InstantID20_Batch_Service', 
				{BIID20_input}, 
				DATASET(BIID20_Output_layout),
        RETRY(5), TIMEOUT(500),
				XPATH('*/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

OUTPUT( COUNT(BIID20_results_raw), NAMED('COUNT_BIID20_results') );

// Minimum required fields are:
//   o  Company Name OR Alternate Company Name
//   o  Street Address 1 OR Street Address 2
//   o  (City, State) OR Zip

// Minimum input requirements for Authorized Reps: First Name AND Last Name. 
// An Authorized Rep not meeting minimum input requirements will NOT prevent 
// that record from being processed.
MinInputErrorCode := 'Minimum input fields required';

/* ----------[ BEGIN ECL TEMPLATE LANGUAGE ]---------- */
/*
	The following code redefines the BIID 2.0 Batch output 
	layout to be composed entirely of STRING fields, save
	for "seq" and "historydate" which shall remain numeric.

	It also generates a transform that converts the dataset
	generated by the SOAPCALL into the all-STRING result.

	Rationale: any records obtained via that failed because 
	they lacked minimum	input criteria must be expressed as 
	entirely blank, save for "seq", "acctno", and "historydate".
*/
LOADXML('<xml/>');

#DECLARE(_recordOf_BIID20_results_raw)
#EXPORTXML(_recordOf_BIID20_results_raw, recordof(BIID20_results_raw))

#DECLARE(RecordFields)
#SET(RecordFields, '')

#DECLARE(TransformFields)
#SET(TransformFields, '')

#FOR(_recordOf_BIID20_results_raw)
	#FOR(Field)
		#IF(%'{@name}'% != 'seq' and %'{@name}'% != 'acctno' and %'{@name}'% != 'historydate' and %'{@name}'% != 'errorcode')
			// Convert each field in the Record layout to a string.
			#APPEND(RecordFields,'string ' + %'{@name}'% + ';\n')
			// For the Transform...:
			#IF(%'{@type}'%	=	'boolean') // ...convert boolean values in "le" to a String...
				#APPEND(TransformFields,'SELF.' + %'{@name}'% + ' := IF( isMinInputErr, \'\', IF( le.' + %'{@name}'% + ' = TRUE, \'TRUE\', \'FALSE\' ) );\n')
			#ELSE  // ...convert numeric values in "le" to a String...
				#IF(%'{@type}'%	=	'integer' or %'{@type}'%	=	'unsigned' or %'{@type}'%	=	'real')
					#APPEND(TransformFields,'SELF.' + %'{@name}'% + ' := IF( isMinInputErr, \'\', IF( le.' + %'{@name}'% + ' = 0, \'0\', (string)le.' + %'{@name}'% + ' ) );\n')
				#ELSE  // ...otherwise, the field is (most likely) a string; don't change the datatype of the value in "le".
					#APPEND(TransformFields,'SELF.' + %'{@name}'% + ' := IF( isMinInputErr, \'\', le.' + %'{@name}'% + ' );\n')
				#END // IF
			#END // IF
		#END // IF
	#END
#END

#UNIQUENAME(layout_outputAsString)	
%layout_outputAsString% := RECORD
	UNSIGNED4 seq;
	STRING30 acctno;
	UNSIGNED6 historydate;
	// Generated record attributes:
	%RecordFields%
	STRING ErrorCode;
END;

#UNIQUENAME(xfm_outputToString)
%layout_outputAsString% %xfm_outputToString%(BIID20_results_raw le) := TRANSFORM		
	isMinInputErr := Stringlib.StringFind(le.ErrorCode, MinInputErrorCode, 1) > 0;
	%TransformFields%
	SELF := le;
	SELF := [];
END;

BIID20_results := PROJECT(BIID20_results_raw, %xfm_outputToString%(LEFT));

/* ----------[ END ECL TEMPLATE LANGUAGE ]---------- */

// ----------[ PASSED RECORDS ]----------

// Records that completed having a MinInputErrorCode shall be kept in the "Passed"
// dataset. However, we still need to display them.
Passed := 
	BIID20_results(TRIM(ErrorCode) = '' OR Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) > 0);

records_having_MinInputErrorCode := 
	Passed(Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) > 0);

OUTPUT( records_having_MinInputErrorCode, NAMED('MinimumInputErrorCode_recs') );

// ----------[ FAILED RECORDS ]----------

// Completed records that have an ErrorCode besides MinInputErrorCode will be put 
// in the "Failed" dataset. Display these too. Transform them into original input
// ("_as_input") so they can be rerun.
records_having_other_ErrorCode := 
	BIID20_results(TRIM(ErrorCode) != '' AND Stringlib.StringFind(ErrorCode, MinInputErrorCode, 1) = 0);

OUTPUT( records_having_other_ErrorCode, NAMED('OtherErrorCode_recs') );

ds_input_dist := DISTRIBUTE(ds_input, HASH32(AccountNumber)) : INDEPENDENT;

records_having_other_ErrorCode_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(records_having_other_ErrorCode, HASH32(AcctNo)),
		LEFT.AccountNumber = RIGHT.AcctNo,
		TRANSFORM(LEFT),
		KEEP(1),
		INNER, LOCAL
	);
	
// Grab any dropped records, i.e. those records not returned by the Roxie. These
// get tossed into the "Failed" dataset also.
dropped_records_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(BIID20_results, HASH32(AcctNo)),
		LEFT.AccountNumber = RIGHT.AcctNo,
		TRANSFORM(LEFT),
		LEFT ONLY, LOCAL
	);

OUTPUT( COUNT(dropped_records_as_input), NAMED('COUNT_dropped_records') );

Failed := records_having_other_ErrorCode_as_input + dropped_records_as_input;


// Final touch-ups for Passed records.
fn_FilterOutNonASCII(STRING x) := REGEXREPLACE('[^ -~]+',x,'');
			
BIID20Final_pre := 
	JOIN(
		DISTRIBUTE(BIID20_input, HASH32(batch_in[1].AcctNo)), DISTRIBUTE(Passed, HASH32(AcctNo)), 
		LEFT.batch_in[1].AcctNo = RIGHT.AcctNo,
		TRANSFORM( RECORDOF(BIID20_results),
			SELF.seq             := LEFT.batch_in[1].Seq,
			SELF.historydate     := LEFT.HistoryDate,
			SELF.bus_description := fn_FilterOutNonASCII( RIGHT.bus_description ); // Get rid of some goofy chars that were spotted.
			SELF := RIGHT,
			SELF := []
		),
		INNER, LOCAL
	);

BIID20Final := SORT( BIID20Final_pre, seq );

BIID20Failed_Inputs := SORT( Failed, AccountNumber );

// Output samples of final results--Passed and Dropped--and then write to file.
OUTPUT(CHOOSEN(BIID20Final         , eyeball), NAMED('Sample_Passed_Results'));
OUTPUT(CHOOSEN(BIID20Failed_Inputs, eyeball), NAMED('Sample_Failed_Results'));

OUTPUT('Total_Final_Results_Passed: ' + COUNT(BIID20Final));
OUTPUT('Total_Final_Results_Failed: ' + COUNT(BIID20Failed_Inputs));

OUTPUT(BIID20Final        , , outputFile +               '.csv', CSV(HEADING(SINGLE), QUOTE('"')), EXPIRE(30), OVERWRITE);
OUTPUT(BIID20Failed_Inputs, , outputFile + '_Failed_Inputs.csv', CSV(HEADING(0), QUOTE('"')), EXPIRE(30), OVERWRITE);
