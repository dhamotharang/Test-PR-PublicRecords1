EXPORT Business( Query_Environment,
								 InputFile_LogicalName,
								 logical_file_type,
								 InputFile_Dali,
								 Records_to_Run,
								 GLBA, 
								 DPPA,
								 DPM,
								 DRM,
								 LexIdSO,
								 TransactionId,
								 BatchUID,
								 GCID, 
								 historyDate,
								 Score_threshold,
								 BIPAppend_Score_Threshold, 
								 BIPAppend_Weight_Threshold,
								 BIPAppend_PrimForce, 
								 BIPAppend_ReAppend, 
								 BIPAppend_Include_AuthRep,
								 Output_Master_Results,
								 Output_SALT_Profile,
								 Exclude_Consumer_Attributes,
								 AllowedSources,
								 OverrideExperianRestriction_par,
								 AllowedSourcesDataset_List,
								 ExcludeSourcesDataset_List,
								 IsMarketing,
								 email_list) := FUNCTIONMACRO


#workunit('name', 'MAS KAT Run Custom');

Threads := 1;

RoxieIP :=Query_Environment;

// InputFile := InputFile_LogicalName;


RecordsToRun := Records_to_Run;
eyeball := 120;


OutputFile := '~bbraaten::out::Business_Roxie_100k_Archive_KS-5842_test_errors_'+ ThorLib.wuid();

prii_layout := RECORD
	STRING AccountNumber;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING StreetAddressLine1;
	STRING StreetAddressLine2;
	STRING City1;
	STRING State1;
	STRING Zip1;
	STRING BusinessPhone;
	STRING BusinessTIN;
	STRING BusinessIPAddress;
	STRING BusinessURL;
	STRING BusinessEmailAddress;
	STRING Rep1FirstName;
	STRING Rep1MiddleName;
	STRING Rep1LastName;
	STRING Rep1NameSuffix;
	STRING Rep1StreetAddressLine1;
	STRING Rep1StreetAddressLine2;
	STRING Rep1City;
	STRING Rep1State;
	STRING Rep1Zip;
	STRING Rep1SSN;
	STRING Rep1DOB;
	STRING Rep1Age;
	STRING Rep1DLNumber;
	STRING Rep1DLState;
	STRING Rep1HomePhone;
	STRING Rep1EmailAddress;
	STRING Rep1FormerLastName;
	STRING Rep1LexID;
	STRING ArchiveDate;
	STRING PowID;
	STRING ProxID;
	STRING SeleID;
	STRING OrgID;
	STRING UltID;
	STRING SIC_Code;
	STRING NAIC_Code;
	STRING Rep2FirstName;
	STRING Rep2MiddleName;
	STRING Rep2LastName;
	STRING Rep2NameSuffix;
	STRING Rep2StreetAddressLine1;
	STRING Rep2StreetAddressLine2;
	STRING Rep2City;
	STRING Rep2State;
	STRING Rep2Zip;
	STRING Rep2SSN;
	STRING Rep2DOB;
	STRING Rep2Age;
	STRING Rep2DLNumber;
	STRING Rep2DLState;
	STRING Rep2HomePhone;
	STRING Rep2EmailAddress;
	STRING Rep2FormerLastName;
	STRING Rep2LexID;
	STRING Rep3FirstName;
	STRING Rep3MiddleName;
	STRING Rep3LastName;
	STRING Rep3NameSuffix;
	STRING Rep3StreetAddressLine1;
	STRING Rep3StreetAddressLine2;
	STRING Rep3City;
	STRING Rep3State;
	STRING Rep3Zip;
	STRING Rep3SSN;
	STRING Rep3DOB;
	STRING Rep3Age;
	STRING Rep3DLNumber;
	STRING Rep3DLState;
	STRING Rep3HomePhone;
	STRING Rep3EmailAddress;
	STRING Rep3FormerLastName;
	STRING Rep3LexID;
	STRING Rep4FirstName;
	STRING Rep4MiddleName;
	STRING Rep4LastName;
	STRING Rep4NameSuffix;
	STRING Rep4StreetAddressLine1;
	STRING Rep4StreetAddressLine2;
	STRING Rep4City;
	STRING Rep4State;
	STRING Rep4Zip;
	STRING Rep4SSN;
	STRING Rep4DOB;
	STRING Rep4Age;
	STRING Rep4DLNumber;
	STRING Rep4DLState;
	STRING Rep4HomePhone;
	STRING Rep4EmailAddress;
	STRING Rep4FormerLastName;
	STRING Rep4LexID;
	STRING Rep5FirstName;
	STRING Rep5MiddleName;
	STRING Rep5LastName;
	STRING Rep5NameSuffix;
	STRING Rep5StreetAddressLine1;
	STRING Rep5StreetAddressLine2;
	STRING Rep5City;
	STRING Rep5State;
	STRING Rep5Zip;
	STRING Rep5SSN;
	STRING Rep5DOB;
	STRING Rep5Age;
	STRING Rep5DLNumber;
	STRING Rep5DLState;
	STRING Rep5HomePhone;
	STRING Rep5EmailAddress;
	STRING Rep5FormerLastName;
	STRING Rep5LexID;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded;
END;

// inData := DATASET(InputFile, prii_layout, CSV(QUOTE('"'), HEADING(SINGLE)));

//OUTPUT(CHOOSEN(inData, eyeball), NAMED('inData'));
// inDataRecs := IF (RecordsToRun = 0, inData, CHOOSEN (inData, RecordsToRun));


sample_size:=Records_to_Run;

inData:=IF(logical_file_type ='THOR',DATASET('~foreign::' + InputFile_Dali + InputFile_LogicalName,prii_layout,THOR),
																DATASET('~foreign::' + InputFile_Dali + InputFile_LogicalName,prii_layout,CSV(HEADING(single), QUOTE('"')))
							 );
																 
inDataRecs:= if(sample_size=0, choosen(inData,all),choosen(inData,sample_size) );



// inDataReady := PROJECT(inDataRecs(AccountNumber NOT IN ['Account', 'SBFEExtract2016_0013010111WBD0101_3439841667_003']), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
inDataReady := PROJECT(inDataRecs(AccountNumber != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout, 
	SELF.ArchiveDate := IF(historyDate = '0', LEFT.ArchiveDate, (STRING)HistoryDate);
	SELF := LEFT, 
	// SELF := [] 
	));
inDataReadyDist := DISTRIBUTE(inDataReady, RANDOM());
// inDataReadyDist := inDataReady;

soapLayout := RECORD
	// STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN ExcludeConsumerAttributes;
	BOOLEAN IsMarketing;
	
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendReAppend;
	BOOLEAN BIPAppendIncludeAuthRep;
  BOOLEAN OverrideExperianRestriction;
	
	UNSIGNED1 LexIdSourceOptout;
  STRING _TransactionId;
  STRING _BatchUID;
  UNSIGNED6 _GCID;
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET(AllowedSourcesDataset_List, PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET(ExcludeSourcesDataset_List, PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := FALSE;
	EXPORT STRING ArchiveDate := historyDate;
	EXPORT STRING InputFileName := InputFile_LogicalName;
	EXPORT STRING Data_Restriction_Mask := DRM;
	EXPORT STRING Data_Permission_Mask := DPM;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction_par;
	EXPORT STRING Allowed_Sources := AllowedSources; // Controls inclusion of DNBDMI data
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
	EXPORT UNSIGNED BusinessLexIDThreshold := BIPAppend_Score_Threshold;
	EXPORT UNSIGNED BusinessLexIDWeightThreshold := BIPAppend_Weight_Threshold;
	EXPORT BOOLEAN BusinessLexIDPrimForce := BIPAppend_PrimForce;
	EXPORT BOOLEAN BusinessLexIDReAppend := BIPAppend_ReAppend;
	EXPORT BOOLEAN BusinessLexIDIncludeAuthRep := BIPAppend_Include_AuthRep;
END;

// Uncomment this code to run as test harness on Thor instead of SOAPCALL to Roxie
// Options := MODULE(PublicRecords_KEL.Interface_Options)
	// EXPORT INTEGER ScoreThreshold := Score_threshold;
// END;
	
// ResultSet:= PublicRecords_KEL.FnRoxie_GetBusAttrs(inDataReadyDist, Options);

layout_MAS_Business_Service_output := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

soapLayout trans (inDataReadyDist le):= TRANSFORM 
	// SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.OverrideExperianRestriction := Settings.Override_Experian_Restriction;
	SELF.IsMarketing := IsMarketing;
	SELF.OutputMasterResults := Output_Master_Results;
	SELF.ExcludeConsumerAttributes := Exclude_Consumer_Attributes;
	SELF.BIPAppendScoreThreshold := Settings.BusinessLexIDThreshold;
	SELF.BIPAppendWeightThreshold := Settings.BusinessLexIDWeightThreshold;
	SELF.BIPAppendPrimForce := Settings.BusinessLexIDPrimForce;
	SELF.BIPAppendReAppend := Settings.BusinessLexIDReAppend;
	SELF.BIPAppendIncludeAuthRep := Settings.BusinessLexIDIncludeAuthRep;
	SELF.LexIdSourceOptout := LexIdSO;
	SELF._TransactionId := TransactionId;
	SELF._BatchUID := BatchUID;
	SELF._GCID := GCID;	
END;

soap_in := PROJECT(inDataReadyDist, trans(LEFT));

//OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

layout_MAS_Business_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	// SELF.Account := le.Account;
	SELF := [];
END;

ResultSet := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_Business_nonFCRA_Service',
				{soap_in}, 
				DATASET(layout_MAS_Business_Service_output),
				XPATH('*'),
				RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
				onFail(myFail(LEFT)));


//OUTPUT(CHOOSEN(inDataReady, eyeball), NAMED('Raw_input'));
//OUTPUT( ResultSet, NAMED('Results') );

Settings_Dataset := Kel_Shell_QA_UI.fn_make_settings_dataset(Settings);


Passed := ResultSet(TRIM(Results.B_InpAcct) <> '');
Failed := ResultSet(TRIM(Results.B_InpAcct) = ''); 

//OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
//OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
// OUTPUT( COUNT(Failed), NAMED('Failed_Cnt') );

LayoutMaster_With_Extras := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster;
	STRING G_ProcErrorCode;
	STRING ln_project_id;
	STRING pf_fraud;
	STRING pf_bad;
	STRING pf_funded;
	STRING pf_declined;
	STRING pf_approved_not_funded; 
	STRING Perf;
	STRING Proj;
END;

Layout_Business := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Business_NonFCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.MasterResults.B_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Business := 
	JOIN(inDataRecs, Passed, LEFT.AccountNumber = RIGHT.Results.B_InpAcct, 
		TRANSFORM(Layout_Business,
			SELF := RIGHT.Results, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
      
result1:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your job has kicked-off. Your WUID is ' + workunit + '.');

result2:=output(Passed_Business,named('Filtered_output'));

unique_id:='p_inpacct';

result3:=Kel_Shell_QA_UI.Output_Distribution_Report_Module(unique_id, Passed_Business);

result4:=Kel_Shell_QA.descriptive_Stats_Report(unique_id, Passed_Business);

Settings_Dataset_updated:= Settings_Dataset +
                           DATASET([{'AllowedSources: ' , Kel_Shell_QA_UI.SetToString(AllowedSourcesDataset_List)},
													  {'ExcludeSources: ' , Kel_Shell_QA_UI.SetToString(ExcludeSourcesDataset_List)}
		                       ],{RECORDOF(Settings_Dataset)});

result5:=OUTPUT(Settings_Dataset_updated, NAMED('Attributes_Settings'));

result6:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your job has completed. Your WUID is ' + workunit + ' .' + '\n You can see the results here. \n http://alawqpnc018.risk.regn.net/KAT/ ');

seq:=sequential(result1, result2, result3, result4, result5, result6);

RETURN seq;

ENDMACRO;