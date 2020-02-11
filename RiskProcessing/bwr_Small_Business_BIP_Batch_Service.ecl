IMPORT Business_Risk_BIP, LNSmallBusiness, Models, iESP, Risk_Indicators, RiskWise, UT, data_services, Address;

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
threads      := 2;

// RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
// RoxieIP := RiskWise.shortcuts.Dev156;      // Dev Roxie 156
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev192;                  // Development Roxie 192
// RoxieIP := RiskWise.shortcuts.Dev194;                  // Development Roxie 194
RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;


// inputFile := ut.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
inputFile := data_services.foreign_prod + 'jpyon::in::chase_8843_bb_p1_small_input_1000_seleid.csv';
outputFile := '~blptemp::out::small_business_bip_batch_service';

includeSBFE := TRUE;				// Return SBFE attributes and SBA attributes (Note: DataPermissionMask_val must be set to '00000000000100000000' to allow SBFE data)
// includeSBFE := FALSE;		// Just return SBA attributes without SBFE attributes	

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';
dataPermissionMask_val  := '00000000000100000000'; 			// For SBFE: '00000000000100000000' (pos 12 = '1')
//  dataPermissionMask_val  := '00000000000000000000';	  // SBFE Not included: All 0's

Marketing_Mode := 0; // This product is not being run for marketing, allow all normal sources
// Marketing_Mode := 1; // This product IS being run for marketing, disable sources not allowed for marketing

// Uncomment the attributes below that you wish to have returned

Attribute1RequestName := 'SmallBusinessAttrV1';
Attribute2RequestName := 'SBFEAttrV1';		
		
// Uncomment the models below that you wish to have returned

Model1RequestName := 'SBBM1601_0_0';
Model2RequestName := 'SBOM1601_0_0';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
 
// Input layout:
bus_in := record
     string30  AccountNumber := '';
     string100 CompanyName := '';
	 string100 AlternateCompanyName := '';
     string50  Addr := '';
     string30  City := '';
     string2   State := '';
     string9   Zip := '';
     string10  BusinessPhone := '';
     string9   TaxIdNumber := '';
	 string16  BusinessIPAddress := '';
     string15  Representativefirstname := '';
	 string15  RepresentativeMiddleName := '';
     string20  Representativelastname := '';
	 string5   RepresentativeNameSuffix := '';
     string50  RepresentativeAddr := '';
     string30  RepresentativeCity := '';
     string2   RepresentativeState := '';
     string9   RepresentativeZip := '';
     string9   RepresentativeSSN := '';
     string8   RepresentativeDOB := '';
	 string3   RepresentativeAge := '';
     string20  RepresentativeDLNumber := '';
     string2   RepresentativeDLState := '';
	 string10  RepresentativeHomePhone := '';
     string50  RepresentativeEmailAddress := '';
	 string20  RepresentativeFormerLastName := '';
	 integer   historydate;
	unsigned PowID;
	unsigned ProxID;
	unsigned SeleID;
	unsigned OrgID;
	unsigned UltID;
end;

f := 
	IF(
		recordsToRun <= 0, 
		DATASET(inputFile, bus_in, CSV(QUOTE('"'))), 
		CHOOSEN( DATASET(inputFile, bus_in, CSV(QUOTE('"'))), recordsToRun )
	);

OUTPUT(f);

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
	DATASET(iesp.Share.t_StringArrayItem) Watchlists_Requested;
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
    i := PROJECT(ut.ds_oneRecord, TRANSFORM(LNSmallBusiness.BIP_Layouts.Input, 
	self.acctno := le.AccountNumber;
    SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)(STRING)le.historydate[1..6], histDateYYYYMM);
    SELF.HistoryDate := IF(histDate= 0, le.historydate, histDate);
    self.UltID := le.UltID;
	self.OrgID := le.OrgID;
	self.SELEID := le.SeleID;
	self.ProxID := le.ProxID;
	self.POWID := le.PowID;
    self.Bus_Company_Name := le.CompanyName;
    self.Bus_Doing_Business_As := le.AlternateCompanyName;
    self.Bus_Street_Address1 := le.Addr;
    self.Bus_Street_Address2 := '';
    self.Bus_City := le.City;
    self.Bus_State := le.State;
    self.Bus_Zip := le.Zip;
    self.Bus_Zip5 := '';
    self.Bus_Zip4 := '';
    self.Bus_Prim_Range := '';
    self.Bus_PreDir := '';
    self.Bus_Prim_Name := '';
    self.Bus_Addr_Suffix := '';
    self.Bus_PostDir := '';
    self.Bus_Unit_Desig := '';
    self.Bus_Sec_Range := '';
    self.Bus_FEIN := le.TaxIdNumber;
    self.Bus_Phone10 := le.BusinessPhone;
    self.Bus_SIC_Code := '';
    self.Bus_NAIC_Code := '';
    self.Bus_Structure := '';
    self.Bus_Years_in_Business := '';
    self.Bus_Start_Date := '';
    self.Bus_Yearly_Revenue := '';
    self.Bus_Fax_Number := '';
    self.Bus_Custom_Field_1 := '';
    self.Bus_Custom_Field_2 := '';
    self.Bus_Custom_Field_3 := '';
    self.Bus_Custom_Field_4 := '';
    self.Bus_Custom_Field_5 := '';
    self.Rep_1_LexID := 0;
    self.Rep_1_Full_Name := '';
   	self.Rep_1_First_Name := le.Representativefirstname;
   	self.Rep_1_Middle_Name := le.Representativemiddlename;
   	self.Rep_1_Last_Name := le.Representativelastname;
   	self.Rep_1_Former_Last_Name := '';
   	self.Rep_1_Suffix := le.Representativenamesuffix;
   	self.Rep_1_DOB := le.RepresentativeDOB;
   	self.Rep_1_SSN := le.RepresentativeSSN;
   	self.Rep_1_Street_Address1 := le.RepresentativeAddr;
   	self.Rep_1_Street_Address2 := '';
   	self.Rep_1_City := le.RepresentativeCity;
   	self.Rep_1_State := le.RepresentativeState;
   	self.Rep_1_Zip := le.RepresentativeZip;
   	self.Rep_1_Zip5 := '';
   	self.Rep_1_Zip4 := '';
   	self.Rep_1_Prim_Range := '';
   	self.Rep_1_PreDir := '';
   	self.Rep_1_Prim_Name := '';
   	self.Rep_1_Addr_Suffix := '';
   	self.Rep_1_PostDir := '';
   	self.Rep_1_Unit_Desig := '';
   	self.Rep_1_Sec_Range := '';
   	self.Rep_1_Phone10 := le.RepresentativeHomePhone;
   	self.Rep_1_Age := le.RepresentativeAge;
   	self.Rep_1_DL_Number := le.RepresentativeDLNumber;
   	self.Rep_1_DL_State := le.RepresentativeDLState;
   	self.Rep_1_Business_Title := '';
   	self.Rep_1_Custom_Field_1 := '';
   	self.Rep_1_Custom_Field_2 := '';
   	self.Rep_1_Custom_Field_3 := '';
   	self.Rep_1_Custom_Field_4 := '';
   	self.Rep_1_Custom_Field_5 := '';
    self.Rep_2_LexID := 0;
   	self.Rep_2_Full_Name := '';
   	self.Rep_2_First_Name := '';
   	self.Rep_2_Middle_Name := '';
   	self.Rep_2_Last_Name := '';
   	self.Rep_2_Former_Last_Name := '';
   	self.Rep_2_Suffix := '';
   	self.Rep_2_DOB := '';
   	self.Rep_2_SSN := '';
   	self.Rep_2_Street_Address1 := '';
   	self.Rep_2_Street_Address2 := '';
   	self.Rep_2_City := '';
   	self.Rep_2_State := '';
   	self.Rep_2_Zip := '';
   	self.Rep_2_Zip5 := '';
   	self.Rep_2_Zip4 := '';
   	self.Rep_2_Prim_Range := '';
   	self.Rep_2_PreDir := '';
   	self.Rep_2_Prim_Name := '';
   	self.Rep_2_Addr_Suffix := '';
   	self.Rep_2_PostDir := '';
   	self.Rep_2_Unit_Desig := '';
   	self.Rep_2_Sec_Range := '';
   	self.Rep_2_Phone10 := '';
   	self.Rep_2_Age := '';
   	self.Rep_2_DL_Number := '';
   	self.Rep_2_DL_State := '';
   	self.Rep_2_Business_Title := '';
   	self.Rep_2_Custom_Field_1 := '';
   	self.Rep_2_Custom_Field_2 := '';
   	self.Rep_2_Custom_Field_3 := '';
   	self.Rep_2_Custom_Field_4 := '';
   	self.Rep_2_Custom_Field_5 := '';
    self.Rep_3_LexID := 0;
   	self.Rep_3_Full_Name := '';
   	self.Rep_3_First_Name := '';
   	self.Rep_3_Middle_Name := '';
   	self.Rep_3_Last_Name := '';
   	self.Rep_3_Former_Last_Name := '';
   	self.Rep_3_Suffix := '';
   	self.Rep_3_DOB := '';
   	self.Rep_3_SSN := '';
   	self.Rep_3_Street_Address1 := '';
   	self.Rep_3_Street_Address2 := '';
   	self.Rep_3_City := '';
   	self.Rep_3_State := '';
   	self.Rep_3_Zip := '';
   	self.Rep_3_Zip5 := '';
   	self.Rep_3_Zip4 := '';
   	self.Rep_3_Prim_Range := '';
   	self.Rep_3_PreDir := '';
   	self.Rep_3_Prim_Name := '';
   	self.Rep_3_Addr_Suffix := '';
   	self.Rep_3_PostDir := '';
   	self.Rep_3_Unit_Desig := '';
   	self.Rep_3_Sec_Range := '';
   	self.Rep_3_Phone10 := '';
   	self.Rep_3_Age := '';
   	self.Rep_3_DL_Number := '';
   	self.Rep_3_DL_State := '';
   	self.Rep_3_Business_Title := '';
   	self.Rep_3_Custom_Field_1 := '';
   	self.Rep_3_Custom_Field_2 := '';
   	self.Rep_3_Custom_Field_3 := '';
   	self.Rep_3_Custom_Field_4 := '';
   	self.Rep_3_Custom_Field_5 := '';
    SELF := []));
    
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
    SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)(STRING)le.historydate[1..6], histDateYYYYMM);
	
	SELF := [];
 END;


SmallBusinessBatchService_input := DISTRIBUTE(PROJECT(f, transform_input_request(LEFT, COUNTER)), RANDOM());

OUTPUT(CHOOSEN(SmallBusinessBatchService_input, eyeball), NAMED('SmallBusinessBatchService_input'));

// Now run the SmallBusinessAnalytics attributes
SmallBusinessBatchReportoutput := RECORD
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	LNSmallBusiness.BIP_Layouts.BatchOutput;
	STRING ErrorCode;
END;

SmallBusinessBatchReportoutput myFail(layout_soap le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
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
Passed := SmallBusinessBatchService_attributes(TRIM(ErrorCode) = '');
Insufficient_input_Failed := SmallBusinessBatchService_attributes(Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) > 0);
Other_Failed := SmallBusinessBatchService_attributes(TRIM(ErrorCode) <> '' AND Stringlib.StringFind(ErrorCode, MinimumInputErrorCode, 1) = 0);
				
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('SmallBusinessBatchService_Results_Passed'));
OUTPUT(CHOOSEN(Insufficient_input_Failed, eyeball), NAMED('SmallBusinessBatchService_Insufficient_Input_Errors'));
OUTPUT(CHOOSEN(Other_Failed, eyeball), NAMED('SmallBusinessBatchService_Other_Errors'));
OUTPUT(COUNT(Passed), NAMED('SmallBusinessBatchService_Total_Passed'));
OUTPUT(COUNT(Insufficient_input_Failed), NAMED('SmallBusinessBatchService_Total_Insufficient_Input_Errors'));
OUTPUT(COUNT(Other_Failed), NAMED('SmallBusinessAnalytics_Total_Other_Errors'));
OUTPUT(Passed,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Insufficient_input_Failed,,outputFile+'_Errors', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Other_Failed,,outputFile+'_Error_Inputs', CSV(HEADING(single), QUOTE('"')), OVERWRITE);