#workunit('name','bwr_Business_Marketing_Attributes_Batch_Service');
#option ('hthorMemoryLimit', 1000);

IMPORT PublicRecords_KEL,BRM_Marketing_attributes,RiskWise,Data_Services; 

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

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production

inputFile := Data_Services.foreign_prod + 'tfuerstenberg::in::amex_9834_gcp_sba_in.csv';
OutputFile := '~kandsu01::BRM_test_100K_roxie_'+ ThorLib.wuid();

BOOLEAN runInRealTime := FALSE;   //When TRUE will run request in real time mode, if FALSE will run with archive date from file

		// Configure options:
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80;
		EXPORT STRING100 Data_Restriction_Mask := '';
		EXPORT STRING100 Data_Permission_Mask := '';
		EXPORT UNSIGNED GLBAPurpose := 0;
		EXPORT UNSIGNED DPPAPurpose := 0;
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
STRING  AcctNo;
STRING  CompanyName;
STRING  AlternateCompanyName;
STRING  bus_addr;
STRING  bus_city; 
STRING  bus_state;
STRING  bus_zip;
STRING  BusinessPhone;
STRING  TaxIdNumber;
STRING  BusinessIPAddress;
STRING  historydate;
STRING  BusinessURL;
STRING  BusinessEmailAddress;
STRING  PowID;
STRING  ProxID;
STRING  SeleID;
STRING  OrgID;
STRING  UltID;
END;

 
// load sample data
	p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"')));  // use this for a CSV file
	p := IF(recordsToRun = 0, p_in, CHOOSEN (p_in, recordsToRun));
 OUTPUT (choosen(p,eyeball), NAMED ('input'));
 
 //append G_ProcBusUID to the input.
  inputRecords := PROJECT(P, TRANSFORM({UNSIGNED G_ProcBusUID, RECORDOF(LEFT)}, SELF.G_ProcBusUID := COUNTER; SELF := LEFT;));

	pp:= project(inputRecords,transform(BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input, 
		SELF.G_ProcBusUID := left.G_ProcBusUID;
		SELF.AcctNo :=left.AcctNo;
		SELF.historydate:=(INTEGER)left.historydate[1..8];
		SELF.historydateyyyymm:=(INTEGER)left.historydate[1..6];
		SELF.streetaddressline1 := left.bus_addr;
		SELF.city1 := left.bus_city;
		SELF.state1 := left.bus_state;
		SELF.zip1 := left.bus_zip;
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
    self.g_procbusuid:= left.G_ProcBusUID;
    self.historydate :=IF(runInRealTime, 99999999, (UNSIGNED4)LEFT.historydate);
    self.historydateyyyymm :=IF(runInRealTime, 999999, (UNSIGNED4)LEFT.historydateyyyymm);
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
    self := [];));

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

result_SOAPCALL_pre_sort := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'brm_marketing_attributes.brm_marketing_attr_batch_services',
				{soap_in}, 
				DATASET(layout_SOAP_out),
				XPATH('brm_marketing_attributes.brm_marketing_attr_batch_servicesResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				RETRY(5), TIMEOUT(500),
				PARALLEL(threads), onFail(myFail(LEFT)));

result_SOAPCALL := Sort(result_SOAPCALL_pre_sort,	AcctNo);
							
OUTPUT( CHOOSEN(result_SOAPCALL,eyeball), NAMED('result_SOAPCALL') );

//Passed Records //results without minimum input are also listed in the results passed. Only results with the roxie error will be listed as failed.
Passed:= result_SOAPCALL(TRIM(ErrorCode) = '');
Failed:= result_SOAPCALL(TRIM(ErrorCode)<> '');

//dropped input
//Input Accountnumber here is considered unique for the records.
droppedInput := JOIN(inputRecords, result_SOAPCALL,
                      LEFT.AcctNo = RIGHT.AcctNo,
                      TRANSFORM({RECORDOF(LEFT) - g_procbusuid}, SELF := LEFT;), 
                      LEFT ONLY); //These are in the format as input to be reprocessed 
																				
OUTPUT( CHOOSEN(Passed,eyeball), NAMED('results_Passed') );
OUTPUT( COUNT(Passed), NAMED('Passed_Cnt') );
OUTPUT( CHOOSEN(Failed,eyeball), NAMED('results_Failed') );
OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

// passed results without minimum input.
Minimum_Input_not_met := Passed(TRIM(Error_msg)='minimum input criteria not met');
OUTPUT( CHOOSEN(Minimum_Input_not_met,eyeball), NAMED('Minimum_Input_not_met_records') );
OUTPUT( COUNT(Minimum_Input_not_met), NAMED('Minimum_Input_not_met_Cnt') );

OUTPUT(Passed,, OutputFile + '_Passed_records', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Minimum_Input_not_met,, OutputFile + 'Minimum_Input_not_met', CSV(HEADING(single), QUOTE('"')), OVERWRITE);
OUTPUT(Failed,, OutputFile + '_failed_records', CSV(QUOTE('"')), OVERWRITE);
OUTPUT(droppedInput,, OutputFile + '_reprocess', CSV(QUOTE('"')), OVERWRITE);
OUTPUT(result_SOAPCALL,, OutputFile + 'All_records', CSV(QUOTE('"')), OVERWRITE);
