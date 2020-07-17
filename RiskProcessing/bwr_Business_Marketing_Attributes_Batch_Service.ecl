#workunit('name','bwr_Business_Marketing_Attributes_Batch_Service');
#option ('hthorMemoryLimit', 1000);

IMPORT PublicRecords_KEL,BRM_Marketing_attributes,RiskWise; 

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
// recordsToRun := ALL;
recordsToRun := 20;
eyeball      := 10;
threads      := 30;

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production

inputFile := Data_Services.foreign_prod + 'jpyon::in::compass_1190_bus_shell_in_in';
OutputFile := '~kandsu01::BRM_test_100K_roxie_'+ ThorLib.wuid();

BOOLEAN runInRealTime := FALSE;   //When TRUE will run request in real time mode, if FALSE will run with archive date from file

		// Configure options:
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80;
		EXPORT STRING100 Data_Restriction_Mask := '0000000000000101000000000000000000000000';
		EXPORT STRING100 Data_Permission_Mask := '11111111111111111111111111111111111111111111111111111111111';
		EXPORT UNSIGNED GLBAPurpose := 1;
		EXPORT UNSIGNED DPPAPurpose := 3;
		EXPORT BOOLEAN IsFCRA := FALSE; //It is only non-fcra query.
		EXPORT BOOLEAN isMarketing := true; //always true for this query
		EXPORT STRING100 Allowed_Sources := '';
		EXPORT BOOLEAN Override_Experian_Restriction := false;
		EXPORT STRING IndustryClass := ''; // When set to UTILI or DRMKT this restricts Utility data
		EXPORT DATA100 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			Data_Restriction_Mask, 
			Data_Permission_Mask, 
			GLBAPurpose, 
			DPPAPurpose, 
			IsFCRA,//isfcra
			isMarketing, //ismarketing
			0, //Allow_DNBDMI
			Override_Experian_Restriction,//OverrideExperianRestriction
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

 
// load sample data
	p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));  // use this for a CSV file
	p := IF(recordsToRun = 0, p_in, CHOOSEN (p_in, recordsToRun));
 OUTPUT (choosen(p,eyeball), NAMED ('input'));

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

soap_in_pre:= Project(pp,TRANSFORM(soapLayout,
         self.batch_in := DATASET([TRANSFORM( BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input, 
         self.g_procbusuid:=counter;
						self.historydate :=LEFT.historydate;
						self.historydateyyyymm :=IF(runInRealTime, 99999999, (UNSIGNED4)LEFT.HistoryDate);;
         self.acctno:=LEFT.acctno;
         self.companyname := LEFT.companyname;
         self.AlternateCompanyName := LEFT.AlternateCompanyName;
         self.streetaddressline1 := LEFT.streetaddressline1;
         self.City1 := LEFT.City1;
         self.State1 := LEFT.State1;
         self.Zip1 := LEFT.Zip1;
						self.BusinessPhone := LEFT.BusinessPhone;
						self.BusinessTIN := LEFT.BusinessTIN;
						self.BusinessURL := LEFT.BusinessURL;
						self.BusinessEmailAddress := LEFT.BusinessEmailAddress;
						self                       := [])]); 
						 
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
    SELF := [];));

soap_in := DISTRIBUTE(soap_in_pre, RANDOM());		
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
				RETRY(5), TIMEOUT(500),
				PARALLEL(threads), onFail(myFail(LEFT)));
								
OUTPUT( CHOOSEN(result_SOAPCALL,eyeball), NAMED('result_SOAPCALL') );

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
