EXPORT FCRA_Consumer( Query_Environment,
											InputFile_LogicalName,
											logical_file_type,
											InputFile_Dali,
											Records_to_Run,
											GLBA,
											DPPA,
											DPM, 
											DRM,
											Intended_Purpose, 
											histDate,
											Score_threshold,
											Output_Master_Results,
											Output_SALT_Profile,
											AllowedSourcesDataset_List,
											ExcludeSourcesDataset_List,
											email_list) := FUNCTIONMACRO

﻿/* PublicRecords_KEL.BWR_FCRA_MAS_Roxie */
#workunit('name', 'MAS KAT Run Custom');

IMPORT PublicRecords_KEL, RiskWise, STD, Gateway, UT, SALT38, SALTRoutines;
threads := 1;

RoxieIP :=Query_Environment;
NeutralRoxieIP:= Query_Environment;

// InputFile := InputFile_LogicalName;
//InputFile := '~mas::uatsamples::consumer_fcra_1m_07092019.csv';
// InputFile := '~mas::uatsamples::consumer_nonfcra_iptest_04232020.csv'; //Samesample as NonFCRA only testing IP validation

RecordsToRun := Records_to_Run;
eyeball := 100;

OutputFile := '~lweiner::out::PersonFCRA_Roxie_100k_Archive_KS-4216_'+ ThorLib.wuid();

prii_layout := RECORD
    STRING Account             ;
    STRING FirstName           ;
    STRING MiddleName          ;
    STRING LastName            ;
    STRING StreetAddressLine1  ;
    STRING StreetAddressLine2  ;
    STRING City                ;
    STRING State               ;
    STRING Zip                 ;
    STRING HomePhone           ;
    STRING SSN                 ;
    STRING DateOfBirth         ;
    STRING WorkPhone           ;
    STRING Income              ;
    STRING DLNumber            ;
    STRING DLState             ;
    STRING Balance             ;
    STRING ChargeOffD          ;
    STRING FormerName          ;
    STRING Email               ;
    STRING EmployerName        ;
    STRING historydate;
    STRING LexID;
    STRING IPAddress;
    STRING Perf;
    STRING Proj;
END;
//p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"'), HEADING(SINGLE)));


sample_size:=Records_to_Run;

input_file:=IF(logical_file_type ='THOR',DATASET('~foreign::' + InputFile_Dali + InputFile_LogicalName,prii_layout,THOR),
																DATASET('~foreign::' + InputFile_Dali + InputFile_LogicalName,prii_layout,CSV(HEADING(single), QUOTE('"')))
							 );
																 
p_in:= if(sample_size=0, choosen(input_file,all),choosen(input_file,sample_size) );



// P_IN1 := p_in( ACCOUNT IN ['AAAA7833-122054', 'TMOBJUN7088-84991']);
p := IF (RecordsToRun = 0, P_IN, CHOOSEN (P_IN, RecordsToRun));
//p2 := p_in;
//p := p2(Account in ['TMOBSEP7088-158349', 'TMOBSEP7088-87504','TARG4547-221442', 'TMOBJUN7088-196571','AAAA7833-104166']); 
PP := PROJECT(P(Account != 'Account'), TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout, 
SELF.historydate := if(histDate = '0', LEFT.historydate, histDate);
SELF := LEFT));

soapLayout := RECORD
//  STRING CustomerId; // This is used only for failed transactions here; it's ignored by the ECL service.
	DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) input;
	INTEGER ScoreThreshold;
	STRING DataRestrictionMask;
	STRING DataPermissionMask;
	UNSIGNED1 GLBPurpose;
	UNSIGNED1 DPPAPurpose;
	BOOLEAN OutputMasterResults;
	BOOLEAN IsMarketing;
	DATASET(Gateway.Layouts.Config) gateways := DATASET([], Gateway.Layouts.Config);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET(AllowedSourcesDataset_List, PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
	DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET(ExcludeSourcesDataset_List, PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
end;

Settings := MODULE(PublicRecords_KEL.Interface_BWR_Settings)
	EXPORT STRING AttributeSetName := 'Development KEL Attributes';
	EXPORT STRING VersionName := 'Version 1.0';
	EXPORT BOOLEAN isFCRA := TRUE;
	EXPORT STRING ArchiveDate := histDate;
	EXPORT STRING InputFileName := InputFile_LogicalName;
	EXPORT STRING PermissiblePurpose := Intended_Purpose; // FCRA only
	EXPORT STRING Data_Restriction_Mask := DRM;
	EXPORT STRING Data_Permission_Mask := DPM;
	EXPORT UNSIGNED GLBAPurpose := GLBA;
	EXPORT UNSIGNED DPPAPurpose := DPPA;
	EXPORT UNSIGNED LexIDThreshold := Score_threshold;
END;


soapLayout trans (pp le):= TRANSFORM 
  // SELF.CustomerId := le.CustomerId;
	SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Layout,
		SELF := LEFT;
		SELF := []));
	SELF.Gateways := PROJECT(ut.ds_oneRecord, 
			TRANSFORM(Gateway.Layouts.Config, 
				SELF.ServiceName := 'neutralroxie'; 
				SELF.URL := NeutralRoxieIP; 
				SELF := []));
		
	SELF.ScoreThreshold := Settings.LexIDThreshold;
	SELF.DataRestrictionMask := Settings.Data_Restriction_Mask;
	SELF.DataPermissionMask := Settings.Data_Permission_Mask;
	SELF.GLBPurpose := Settings.GLBAPurpose;
	SELF.DPPAPurpose := Settings.DPPAPurpose;
	SELF.IsMarketing := FALSE;
	SELF.OutputMasterResults := Output_Master_Results;
END;

soap_in := PROJECT(pp, trans(LEFT));

// OUTPUT(CHOOSEN(P, eyeball), NAMED('Sample_Input'));
// OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

  // ResultSet:= PublicRecords_KEL.FnRoxie_GetAttrs(PP, Score_threshold);
  
  // output( Choosen(PP, eyeball), named('raw_input'));
    
  // OUTPUT( ResultSet, NAMED('Results') );
	

layout_MAS_Test_Service_output := RECORD
    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster MasterResults {XPATH('Results/Result/Dataset[@name=\'MasterResults\']/Row')};
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA Results {XPATH('Results/Result/Dataset[@name=\'Results\']/Row')};
	STRING G_ProcErrorCode := '';
END;

layout_MAS_Test_Service_output myFail(soap_in le) := TRANSFORM
	SELF.G_ProcErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
	//SELF.Account := le.Account;
	SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'publicrecords_kel.MAS_FCRA_Service',
				// 'publicrecords_kel.mas_fcra_service.161',
				{soap_in}, 
				DATASET(layout_MAS_Test_Service_output),
				XPATH('*'),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

Settings_Dataset := Kel_Shell_QA_UI.fn_make_settings_dataset(Settings);


Passed := bwr_results(TRIM(G_ProcErrorCode) = '');
Failed := bwr_results(TRIM(G_ProcErrorCode) <> '');

// OUTPUT( CHOOSEN(Passed,eyeball), NAMED('bwr_results_Passed') );
// OUTPUT( CHOOSEN(Failed,eyeball), NAMED('bwr_results_Failed') );
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

Layout_Person := RECORD
    unsigned8 time_ms;
	PublicRecords_KEL.ECL_Functions.Layout_Person_FCRA;
	STRING G_ProcErrorCode;
END;

Passed_with_Extras := 
	JOIN(p, Passed, LEFT.Account = RIGHT.MasterResults.P_InpAcct, 
		TRANSFORM(LayoutMaster_With_Extras,
			SELF := RIGHT.MasterResults, //fields from passed
            SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
	
Passed_Person := 
	JOIN(p, Passed, LEFT.Account = RIGHT.Results.P_InpAcct, 
		TRANSFORM(Layout_Person,
			SELF := RIGHT.Results, //fields from passed
      SELF.time_ms := RIGHT.time_ms,
			SELF := LEFT, //input performance fields
			SELF.G_ProcErrorCode := RIGHT.G_ProcErrorCode,
			SELF := []),
		INNER, KEEP(1));
      
result1:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your job has kicked-off. Your WUID is ' + workunit + '.');

result2:=output(Passed_Person,named('Filtered_output'));

unique_id:='p_inpacct';

result3:=Kel_Shell_QA_UI.Output_Distribution_Report_Module(unique_id, Passed_Person);

result4:=Kel_Shell_QA.descriptive_Stats_Report(unique_id, Passed_Person);

Settings_Dataset_updated:= Settings_Dataset +
                           DATASET([{'AllowedSources: ' , Kel_Shell_QA_UI.SetToString(AllowedSourcesDataset_List)},
													  {'ExcludeSources: ' , Kel_Shell_QA_UI.SetToString(ExcludeSourcesDataset_List)}
		                       ],{RECORDOF(Settings_Dataset)});

result5:=OUTPUT(Settings_Dataset_updated, NAMED('Attributes_Settings'));

result6:=STD.System.Email.SendEmail(email_list, 'KAT Notification',  'Your job has completed. Your WUID is ' + workunit + ' .' + '\n You can see the results here. \n http://alawqpnc018.risk.regn.net/KAT/ ');

seq:=sequential(result1, result2, result3, result4, result5, result6);

RETURN seq;

ENDMACRO;