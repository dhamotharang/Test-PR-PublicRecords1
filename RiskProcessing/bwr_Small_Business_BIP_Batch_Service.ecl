IMPORT LNSmallBusiness, iesp, Risk_Indicators, RiskWise, Data_Services;

/* RiskProcessing.BWR_Small_Business_Analytics_SBFE */
#workunit('name','Small Business BIP Batch Analytics');
#option ('hthorMemoryLimit', 1000);


/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 0;
eyeball      := 10;
threads      := 30;

// RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
// RoxieIP := RiskWise.shortcuts.Dev156;                  // Dev Roxie 156
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;

inputFile := data_services.foreign_prod + 'jpyon::in::amex_9848_seleid.csv';
outputFile := '~mdw::out::amex_9848_small_business_bip_batch_service_' + thorlib.wuid();

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';
dataPermissionMask_val  := '00000000000100000000'; 			// For SBFE: '00000000000100000000' (pos 12 = '1')
// dataPermissionMask_val  := '00000000000000000000';	  // SBFE Not included: All 0's

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// Uncomment the attributes below that you wish to have returned

Attribute1RequestName := 'SmallBusinessAttrV1';
// Attribute2RequestName := '';		
Attribute2RequestName := 'SBFEAttrV1';		
		
// Uncomment the models below that you wish to have returned

Model1RequestName := 'SBBM1601_0_0';
Model2RequestName := 'SBOM1601_0_0';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
 
// Input layout:
bus_in := record
  STRING30  AccountNumber := '';
  STRING100 CompanyName := '';
  STRING100 AlternateCompanyName := '';
  STRING50  Addr := '';
  STRING30  City := '';
  STRING2   State := '';
  STRING9   Zip := '';
  STRING10  BusinessPhone := '';
  STRING9   TaxIdNumber := '';
  STRING16  BusinessIPAddress := '';
  STRING15  Representativefirstname := '';
  STRING15  RepresentativeMiddleName := '';
  STRING20  Representativelastname := '';
  STRING5   RepresentativeNameSuffix := '';
  STRING50  RepresentativeAddr := '';
  STRING30  RepresentativeCity := '';
  STRING2   RepresentativeState := '';
  STRING9   RepresentativeZip := '';
  STRING9   RepresentativeSSN := '';
  STRING8   RepresentativeDOB := '';
  STRING3   RepresentativeAge := '';
  STRING20  RepresentativeDLNumber := '';
  STRING2   RepresentativeDLState := '';
  STRING10  RepresentativeHomePhone := '';
  STRING50  RepresentativeEmailAddress := '';
  STRING20  RepresentativeFormerLastName := '';
  INTEGER   historydate;
  UNSIGNED PowID;
  UNSIGNED ProxID;
  UNSIGNED SeleID;
  UNSIGNED OrgID;
  UNSIGNED UltID;
end;

f := 
	IF(
		recordsToRun <= 0, 
		DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
		CHOOSEN( DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun )
	);

//outputting full input may cause memory warning
// OUTPUT(f)
OUTPUT(CHOOSEN(f, eyeball), NAMED('Raw_Input'));


layout_soap := RECORD
	STRING Seq;// Forcing this into the layout so that we have something to join the attribute results by to get the account number back
  STRING AccountNumber;
  UNSIGNED3 HistoryDateYYYYMM;
  DATASET(LNSmallBusiness.BIP_Layouts.Input) Batch_In;
  STRING2 GLBPurpose;
  STRING2 DPPAPurpose;
  STRING50 DataRestrictionMask;
  STRING50 DataPermissionMask;
	DATASET(Risk_Indicators.Layout_Gateways_In) Gateways;
	DATASET(iesp.Share.t_STRINGArrayItem) Watchlists_Requested;
	UNSIGNED1 OFAC_Version;
	UNSIGNED1 LinkSearchLevel;
	UNSIGNED1 MarketingMode;
	STRING50 AllowedSources;
	REAL Global_Watchlist_Threshold;
  STRING attributesversion1;
	STRING attributesversion2;
	STRING modelname1;
	STRING modelname2;
	STRING modelname3;
	STRING modelname4;
	STRING modelname5;
	BOOLEAN IncludeTargusGateway;
	BOOLEAN RunTargusGateway;
END;

layout_soap transform_input_request(f le, UNSIGNED8 ctr) := TRANSFORM
  i := DATASET([TRANSFORM(LNSmallBusiness.BIP_Layouts.Input, 
	SELF.acctno := le.AccountNumber;
  SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)((STRING)le.historydate)[1..6], histDateYYYYMM);
  SELF.HistoryDate := IF(histDate= 0, le.historydate, histDate);
  SELF.UltID := le.UltID;
	SELF.OrgID := le.OrgID;
	SELF.SELEID := le.SeleID;
	SELF.ProxID := le.ProxID;
	SELF.POWID := le.PowID;
  SELF.Bus_Company_Name := le.CompanyName;
  SELF.Bus_Doing_Business_As := le.AlternateCompanyName;
  SELF.Bus_Street_Address1 := le.Addr;
  SELF.Bus_Street_Address2 := '';
  SELF.Bus_City := le.City;
  SELF.Bus_State := le.State;
  SELF.Bus_Zip := le.Zip;
  SELF.Bus_Zip5 := '';
  SELF.Bus_Zip4 := '';
  SELF.Bus_Prim_Range := '';
  SELF.Bus_PreDir := '';
  SELF.Bus_Prim_Name := '';
  SELF.Bus_Addr_Suffix := '';
  SELF.Bus_PostDir := '';
  SELF.Bus_Unit_Desig := '';
  SELF.Bus_Sec_Range := '';
  SELF.Bus_FEIN := le.TaxIdNumber;
  SELF.Bus_Phone10 := le.BusinessPhone;
  SELF.Bus_SIC_Code := '';
  SELF.Bus_NAIC_Code := '';
  SELF.Bus_Structure := '';
  SELF.Bus_Years_in_Business := '';
  SELF.Bus_Start_Date := '';
  SELF.Bus_Yearly_Revenue := '';
  SELF.Bus_Fax_Number := '';
  SELF.Bus_Custom_Field_1 := '';
  SELF.Bus_Custom_Field_2 := '';
  SELF.Bus_Custom_Field_3 := '';
  SELF.Bus_Custom_Field_4 := '';
  SELF.Bus_Custom_Field_5 := '';
  SELF.Rep_1_LexID := 0;
  SELF.Rep_1_Full_Name := '';
  SELF.Rep_1_First_Name := le.Representativefirstname;
  SELF.Rep_1_Middle_Name := le.Representativemiddlename;
  SELF.Rep_1_Last_Name := le.Representativelastname;
  SELF.Rep_1_Former_Last_Name := '';
  SELF.Rep_1_Suffix := le.Representativenamesuffix;
  SELF.Rep_1_DOB := le.RepresentativeDOB;
  SELF.Rep_1_SSN := le.RepresentativeSSN;
  SELF.Rep_1_Street_Address1 := le.RepresentativeAddr;
  SELF.Rep_1_Street_Address2 := '';
  SELF.Rep_1_City := le.RepresentativeCity;
  SELF.Rep_1_State := le.RepresentativeState;
  SELF.Rep_1_Zip := le.RepresentativeZip;
  SELF.Rep_1_Zip5 := '';
  SELF.Rep_1_Zip4 := '';
  SELF.Rep_1_Prim_Range := '';
  SELF.Rep_1_PreDir := '';
  SELF.Rep_1_Prim_Name := '';
  SELF.Rep_1_Addr_Suffix := '';
  SELF.Rep_1_PostDir := '';
  SELF.Rep_1_Unit_Desig := '';
  SELF.Rep_1_Sec_Range := '';
  SELF.Rep_1_Phone10 := le.RepresentativeHomePhone;
  SELF.Rep_1_Age := le.RepresentativeAge;
  SELF.Rep_1_DL_Number := le.RepresentativeDLNumber;
  SELF.Rep_1_DL_State := le.RepresentativeDLState;
  SELF.Rep_1_Business_Title := '';
  SELF.Rep_1_Custom_Field_1 := '';
  SELF.Rep_1_Custom_Field_2 := '';
  SELF.Rep_1_Custom_Field_3 := '';
  SELF.Rep_1_Custom_Field_4 := '';
  SELF.Rep_1_Custom_Field_5 := '';
  SELF.Rep_2_LexID := 0;
  SELF.Rep_2_Full_Name := '';
  SELF.Rep_2_First_Name := '';
  SELF.Rep_2_Middle_Name := '';
  SELF.Rep_2_Last_Name := '';
  SELF.Rep_2_Former_Last_Name := '';
  SELF.Rep_2_Suffix := '';
  SELF.Rep_2_DOB := '';
  SELF.Rep_2_SSN := '';
  SELF.Rep_2_Street_Address1 := '';
  SELF.Rep_2_Street_Address2 := '';
  SELF.Rep_2_City := '';
  SELF.Rep_2_State := '';
  SELF.Rep_2_Zip := '';
  SELF.Rep_2_Zip5 := '';
  SELF.Rep_2_Zip4 := '';
  SELF.Rep_2_Prim_Range := '';
  SELF.Rep_2_PreDir := '';
  SELF.Rep_2_Prim_Name := '';
  SELF.Rep_2_Addr_Suffix := '';
  SELF.Rep_2_PostDir := '';
  SELF.Rep_2_Unit_Desig := '';
  SELF.Rep_2_Sec_Range := '';
  SELF.Rep_2_Phone10 := '';
  SELF.Rep_2_Age := '';
  SELF.Rep_2_DL_Number := '';
  SELF.Rep_2_DL_State := '';
  SELF.Rep_2_Business_Title := '';
  SELF.Rep_2_Custom_Field_1 := '';
  SELF.Rep_2_Custom_Field_2 := '';
  SELF.Rep_2_Custom_Field_3 := '';
  SELF.Rep_2_Custom_Field_4 := '';
  SELF.Rep_2_Custom_Field_5 := '';
  SELF.Rep_3_LexID := 0;
  SELF.Rep_3_Full_Name := '';
  SELF.Rep_3_First_Name := '';
  SELF.Rep_3_Middle_Name := '';
  SELF.Rep_3_Last_Name := '';
  SELF.Rep_3_Former_Last_Name := '';
  SELF.Rep_3_Suffix := '';
  SELF.Rep_3_DOB := '';
  SELF.Rep_3_SSN := '';
  SELF.Rep_3_Street_Address1 := '';
  SELF.Rep_3_Street_Address2 := '';
  SELF.Rep_3_City := '';
  SELF.Rep_3_State := '';
  SELF.Rep_3_Zip := '';
  SELF.Rep_3_Zip5 := '';
  SELF.Rep_3_Zip4 := '';
  SELF.Rep_3_Prim_Range := '';
  SELF.Rep_3_PreDir := '';
  SELF.Rep_3_Prim_Name := '';
  SELF.Rep_3_Addr_Suffix := '';
  SELF.Rep_3_PostDir := '';
  SELF.Rep_3_Unit_Desig := '';
  SELF.Rep_3_Sec_Range := '';
  SELF.Rep_3_Phone10 := '';
  SELF.Rep_3_Age := '';
  SELF.Rep_3_DL_Number := '';
  SELF.Rep_3_DL_State := '';
  SELF.Rep_3_Business_Title := '';
  SELF.Rep_3_Custom_Field_1 := '';
  SELF.Rep_3_Custom_Field_2 := '';
  SELF.Rep_3_Custom_Field_3 := '';
  SELF.Rep_3_Custom_Field_4 := '';
  SELF.Rep_3_Custom_Field_5 := '';
  SELF := [])]);
    
	SELF.Batch_In := i[1];
  
	SELF.glbpurpose := '1';
	SELF.dppapurpose := '1';
	SELF.DataRestrictionMask := dataRestrictionMask_val; 
	SELF.DataPermissionMask := dataPermissionMask_val; 
	SELF.OFAC_Version := 3;
	SELF.LinkSearchLevel := 0;
	SELF.MarketingMode := Marketing_Mode;
	SELF.AllowedSources := '';
	SELF.Global_Watchlist_Threshold := 0.84;

	SELF.Seq := (STRING)ctr;	
	SELF.attributesversion1 := Attribute1RequestName;
	SELF.attributesversion2 := Attribute2RequestName;
	SELF.modelname1 := Model1RequestName;
	SELF.modelname2 := Model2RequestName;
	SELF.modelname3 := '';
	SELF.modelname4 := '';
	SELF.modelname5 := '';
	SELF.IncludeTargusGateway := true;
	SELF.RunTargusGateway := true;
  SELF.AccountNumber := le.AccountNumber;
  SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)((STRING)le.historydate)[1..6], histDateYYYYMM);
	
	SELF := [];
 END;


SmallBusinessBatchService_input := DISTRIBUTE(PROJECT(f, transform_input_request(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(SmallBusinessBatchService_input, eyeball), NAMED('SmallBusinessBatchService_input'));

// Now run the SmallBusinessAnalytics attributes
SmallBusinessBatchReportoutput := RECORD
	UNSIGNED8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	LNSmallBusiness.BIP_Layouts.BatchOutput;
	STRING Seq;
	STRING ErrorCode;
END;

SmallBusinessBatchReportoutput myFail(layout_soap le) := TRANSFORM
	SELF.ErrorCode := STRINGLib.STRINGFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	SELF.Seq := le.Seq;
	SELF := le;
	SELF := [];
END;

SmallBusinessBatchService_attributes := 
				SOAPCALL(SmallBusinessBatchService_input, 
				RoxieIP,
				'LNSmallBusiness.SmallBusiness_BIP_Batch_Service', 
				{SmallBusinessBatchService_input}, 
				DATASET(SmallBusinessBatchReportoutput),
        RETRY(5), TIMEOUT(500),
				XPATH('LNSmallBusiness.SmallBusiness_BIP_Batch_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));

MinimumInputErrorCode := 'Please input the minimum required fields';
Passed := SmallBusinessBatchService_attributes(TRIM(ErrorCode) = '' AND TRIM(acctno) <> '');
Insufficient_input_Failed := SmallBusinessBatchService_attributes(STRINGlib.STRINGFind(ErrorCode, MinimumInputErrorCode, 1) > 0);
Other_Failed := SmallBusinessBatchService_attributes((TRIM(ErrorCode) <> '' OR TRIM(acctno) = '') AND STRINGlib.STRINGFind(ErrorCode, MinimumInputErrorCode, 1) = 0);

//grab input for all failed (not passed) results
Failed_PII := JOIN(f, Passed, 
									 LEFT.accountnumber = RIGHT.acctno, 
									 TRANSFORM(bus_in, SELF := LEFT; SELF := [];),
									 LEFT ONLY);
				
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessBatchService_Results_Passed'));
OUTPUT(CHOOSEN(Insufficient_input_Failed, eyeball), NAMED('SmallBusinessBatchService_Insufficient_Input_Errors'));
OUTPUT(CHOOSEN(Other_Failed, eyeball), NAMED('SmallBusinessBatchService_Other_Errors'));
OUTPUT(COUNT(Passed), NAMED('SmallBusinessBatchService_Total_Passed'));
OUTPUT(COUNT(Insufficient_input_Failed), NAMED('SmallBusinessBatchService_Total_Insufficient_Input_Errors'));
OUTPUT(COUNT(Other_Failed), NAMED('SmallBusinessAnalytics_Total_Other_Errors'));
OUTPUT(Passed,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Insufficient_input_Failed,,outputFile+'_Errors', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Other_Failed,,outputFile+'_Error_Inputs', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Failed_PII,,outputFile+'_Failed_PII', CSV(QUOTE('"')), OVERWRITE, NAMED('Failed_PII_CSV'));