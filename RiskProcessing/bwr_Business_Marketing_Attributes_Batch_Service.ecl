
#workunit('name','bwr_Business_Marketing_Attributes_Batch_Service');
#option ('hthorMemoryLimit', 1000);

IMPORT PublicRecords_KEL,BRM_Marketing_attributes,ut; 

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := ALL;
eyeball      := 10;
threads      := 3;
// RoxieIP := RiskWise.shortcuts.Dev156; //Development Roxie 156
RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production
//RoxieIP := RiskWise.shortcuts.prod_batch_neutral;      // Production
// RoxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// RoxieIP := RiskWise.shortcuts.Dev194;                  // Development Roxie 194

// inputFile := Data_Services.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
InputFile := '~temp::kel::ally_01_business_uat_sample_100k_20181015.csv';
OutputFile := '~kandsu01::BRM_test_100K_roxie_'+ ThorLib.wuid();

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file
histDateYYYYMM := 0;
histDate       := 0;

//To process real time use this
//histDateYYYYMM := 999999;
//histDate       := 999999999999;

		// Configure options:
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80;
		EXPORT STRING100 Data_Restriction_Mask := '0000000000000101000000000000000000000000';
		EXPORT STRING100 Data_Permission_Mask := '11111111111111111111111111111111111111111111111111111111111';
		EXPORT UNSIGNED GLBAPurpose := 1;
		EXPORT UNSIGNED DPPAPurpose := 1;
		EXPORT BOOLEAN IsFCRA := FALSE; //It is only non-fcra query.
		EXPORT BOOLEAN isMarketing := true; //always true for this query
		EXPORT STRING100 Allowed_Sources := '';
		EXPORT BOOLEAN Override_Experian_Restriction := false;
		EXPORT STRING IndustryClass := ''; // When set to UTILI or DRMKT this restricts Utility data
		EXPORT UNSIGNED8 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			Data_Restriction_Mask, 
			Data_Permission_Mask, 
			GLBAPurpose, 
			DPPAPurpose, 
			FALSE,//isfcra
			TRUE, //ismarketing
			0, //Allow_DNBDMI
			FALSE,//OverrideExperianRestriction
			'',//PermissiblePurpose - For FCRA Products Only
			IndustryClass,
			PublicRecords_KEL.CFG_Compile);
		
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold :=75;
		EXPORT UNSIGNED BIPAppendWeightThreshold :=0;
		EXPORT BOOLEAN BIPAppendPrimForce :=false;
		EXPORT BOOLEAN BIPAppendReAppend :=false;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep :=false;
		// CCPA Options
		EXPORT UNSIGNED1 LexIdSourceOptout := 1;
		EXPORT STRING100 TransactionID :='';                                
		EXPORT STRING100 BatchUID :='';
		EXPORT UNSIGNED6 GlobalCompanyId :=0;	
		END;	

prii_layout := RECORD
STRING  AccountNumber;
STRING  CompanyName;
STRING  AlternateCompanyName;
STRING  Addr1;
STRING  City1; 
STRING  State1;
STRING  Zip1;
STRING  BusinessPhone;
STRING  TaxIdNumber;
STRING  BusinessIPAddress;
STRING  BusinessURL;
STRING  BusinessEmailAddress;
STRING  Rep1firstname;
STRING  Rep1MiddleName;
STRING  Rep1lastname;
STRING  Rep1NameSuffix;
STRING  Rep1Addr;
STRING  Rep1City;
STRING  Rep1State;
STRING  Rep1Zip;
STRING  Rep1SSN;
STRING  Rep1DOB;
STRING  Rep1Age;
STRING  Rep1DLNumber;
STRING  Rep1DLState;
STRING  Rep1HomePhone;
STRING  Rep1EmailAddress;
STRING  Rep1FormerLastName;
STRING  Rep1LexID;
STRING  ArchiveDate;
STRING  PowID;
STRING  ProxID;
STRING  SeleID;
STRING  OrgID;
STRING  UltID;
STRING  SIC_Code;
STRING  NAIC_Code;
STRING  Rep2firstname;
STRING  Rep2MiddleName;
STRING  Rep2lastname;
STRING  Rep2NameSuffix;
STRING  Rep2Addr;
STRING  Rep2City;
STRING  Rep2State;
STRING  Rep2Zip;
STRING  Rep2SSN;
STRING  Rep2DOB;
STRING  Rep2Age;
STRING  Rep2DLNumber;
STRING  Rep2DLState;
STRING  Rep2HomePhone;
STRING  Rep2EmailAddress;
STRING  Rep2FormerLastName;
STRING  Rep2LexID;
STRING  Rep3firstname;
STRING  Rep3MiddleName;
STRING  Rep3lastname;
STRING  Rep3NameSuffix;
STRING  Rep3Addr;
STRING  Rep3City;
STRING  Rep3State;
STRING  Rep3Zip;
STRING  Rep3SSN;
STRING  Rep3DOB;
STRING  Rep3Age;
STRING  Rep3DLNumber;
STRING  Rep3DLState;
STRING  Rep3HomePhone;
STRING  Rep3EmailAddress;
STRING  Rep3FormerLastName;
STRING  Rep3LexID;
STRING  Rep4firstname;
STRING  Rep4MiddleName;
STRING  Rep4lastname;
STRING  Rep4NameSuffix;
STRING  Rep4Addr;
STRING  Rep4City;
STRING  Rep4State;
STRING  Rep4Zip;
STRING  Rep4SSN;
STRING  Rep4DOB;
STRING  Rep4Age;
STRING  Rep4DLNumber;
STRING  Rep4DLState;
STRING  Rep4HomePhone;
STRING  Rep4EmailAddress;
STRING  Rep4FormerLastName;
STRING  Rep4LexID;
STRING  Rep5firstname;
STRING  Rep5MiddleName;
STRING  Rep5lastname;
STRING  Rep5NameSuffix;
STRING  Rep5Addr;
STRING  Rep5City;
STRING  Rep5State;
STRING  Rep5Zip;
STRING  Rep5SSN;
STRING  Rep5DOB;
STRING  Rep5Age;
STRING  Rep5DLNumber;
STRING  Rep5DLState;
STRING  Rep5HomePhone;
STRING  Rep5EmailAddress;
STRING  Rep5FormerLastName;
STRING  Rep5LexID;
STRING  ln_project_id;
STRING  pf_fraud;
STRING  pf_bad;
STRING  pf_funded;
STRING  pf_declined;
STRING  pf_approved_not_funded ;
END;

	p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"')))(AccountNumber != 'AccountNumber');
	OUTPUT( CHOOSEN(p_in, 100), NAMED('Input_data') );
	p := CHOOSEN(p_in, RecordsToRun);

	pp:= project(P,transform(BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input, 
		SELF.G_ProcBusUID :=Counter;
		SELF.acctno :=left.accountnumber;
		SELF.historydate:=(INTEGER)left.archivedate[1..8];
		SELF.historydateyyyymm:=(INTEGER)left.archivedate[1..6];
		SELF.streetaddressline1 := left.Addr1;
		SELF.BusinessTIN := left.TaxIdNumber;
		SELF := left;
		SELF := []));
			
output(pp,named('PP'));
soapLayout := RECORD
  DATASET(BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input) batch_in;
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendIncludeAuthRep;
	BOOLEAN BIPAppendReAppend;
	STRING100 DataRestrictionMask;
	STRING100 DataPermissionMask;
	UNSIGNED1 glbpurpose;
	UNSIGNED1 dppapurpose;
	STRING AttributeVer1;
	STRING AttributeVer2;
	STRING100 AllowedSources;
	STRING5 IndustryClass;
	BOOLEAN OverrideExperianRestriction;
	INTEGER Score_threshold;
	UNSIGNED1 LexIdSourceOptout;
end;

soapLayout trans1(pp le, INTEGER c) := TRANSFORM
    r2 := project(ut.ds_oneRecord, transform( BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input, 
         self.g_procbusuid:=c;
						self.historydate :=le.historydate;
						self.historydateyyyymm :=le.historydateyyyymm;
         self.acctno:=le.acctno;
         self.companyname := le.companyname;
         self.AlternateCompanyName := le.AlternateCompanyName;
         self.streetaddressline1 := le.streetaddressline1;
         self.City1 := le.City1;
         self.State1 := le.State1;
         self.Zip1 := le.Zip1;
						self.BusinessPhone := le.BusinessPhone;
						self.BusinessTIN := le.BusinessTIN;
						self.BusinessURL := le.BusinessURL;
						self.BusinessEmailAddress := le.BusinessEmailAddress;
						self                       := [])); 
						
			self.batch_in := r2;
 
    self.Score_threshold := Options.ScoreThreshold;
    self.BIPAppendScoreThreshold := Options.BIPAppendScoreThreshold;
    self.BIPAppendWeightThreshold := Options.BIPAppendWeightThreshold;
    self.BIPAppendPrimForce := Options.BIPAppendPrimForce;
    self.BIPAppendIncludeAuthRep := Options.BIPAppendIncludeAuthRep;
    self.BIPAppendReAppend := Options.BIPAppendReAppend;
    self.DataRestrictionMask :=Options.Data_Restriction_Mask;
    self.DataPermissionMask :=Options.Data_Permission_Mask;
    self.GLBpurpose := Options.GLBApurpose;
    self.DPPApurpose := Options.DPPApurpose;
    self.AttributeVer1 :='MA';
    self.AttributeVer2 := '';
    self.AllowedSources := Options.Allowed_Sources;
    self.IndustryClass := Options.IndustryClass;
    self.OverrideExperianRestriction := Options.Override_Experian_Restriction;
    //CCPA fields
    self.LexIdSourceOptout := Options.LexIdSourceOptout;
    SELF := [];
end;
soap_in := distribute(project(pp, trans1(left, counter)));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_SOAP_out := RECORD
 BRM_Marketing_attributes.Layout_BRM_NonFCRA.BatchOutput;
	string ErrorCode;
END;

layout_SOAP_out myFail(soapLayout le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE),'\n');
	SELF := le;
	SELF := [];
END;

result_SOAPCALL := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'brm_marketing_attributes.brm_marketing_attr_batch_services',
				{soap_in}, 
				DATASET(layout_SOAP_out),
				XPATH('brm_marketing_attributes.brm_marketing_attr_batch_servicesResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				// XPATH('*'),
				RETRY(5), TIMEOUT(500),
				PARALLEL(threads), onFail(myFail(LEFT)));
								
OUTPUT(result_SOAPCALL);

//Passed Records //results without minimum input are also listed in the results passed. Only results with the roxie error will be listed as failed.
Passed:= result_SOAPCALL(TRIM(ErrorCode) = '');
Failed:= result_SOAPCALL(TRIM(ErrorCode)<> '');

OUTPUT( CHOOSEN(Passed,eyeball), NAMED('results_Passed') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

// passed results without minimum input.
Minimum_Input_not_met := Passed(TRIM(Error_msg)='minimum input criteria not met');
OUTPUT( CHOOSEN(Minimum_Input_not_met,eyeball), NAMED('Minimum_Input_not_met_records') );
OUTPUT( COUNT(Minimum_Input_not_met), NAMED('Minimum_Input_not_met_Cnt') );

OUTPUT(Passed,, OutputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Minimum_Input_not_met,, OutputFile + 'Minimum_Input_not_met', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Failed,, OutputFile + '_failed_records', CSV(QUOTE('"')), OVERWRITE);
