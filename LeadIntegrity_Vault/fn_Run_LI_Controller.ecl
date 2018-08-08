Import LeadIntegrity_Vault, Std;

EXPORT fn_Run_LI_Controller(STRING8 date_inp = '') := Function

		date_in := (STRING8)Std.Date.Today();

		buildPeriodFromCurrDate := Util_Date.getFileBuildDateFromCurrentDate();
		validInputDate := IF(Util_Date.ValidLIDate(TRIM(date_inp)),TRUE,FALSE);
		buildPeriodFromInputDate := IF(validInputDate,TRIM(date_inp),'');
		
		// build_period := IF(TRIM(date_inp) = '', date_in[1..6], TRIM(date_inp));

		build_period := IF(TRIM(date_inp) = '', buildPeriodFromCurrDate, buildPeriodFromInputDate);

		RunLI_Attributes := SEQUENTIAL(
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '01'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '02'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '03'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '04'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '05'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '06'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '07'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '08'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '09'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '10'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '11'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '12'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '13'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '14'),
												LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '15'));

		failuresubject   := 'The LeadIntegrity Build Failed for the Build Period: ' + build_period;
		failurebody      := 'The LeadIntegrity Build Failed for the Build Period: ' + build_period + '\n' +
												'The Workunit is '+WORKUNIT + '\n' +
												'ErrorMessage is '+FAILMESSAGE + '\n\n';

		Validationfailurebody := 'The LeadIntegrity Build did NOT kick off because of either the absence of MM Input files or an invalid Build Period: ' + build_period + '\n' +
														 'The Workunit is '+WORKUNIT + '\n';
												
		successsubject   := 'The LeadIntegrity Build completed for ' + build_period;
		successbody      := 'The LeadIntegrity Build completed for ' + build_period + '\n' +
												'The Workunit is '+ WORKUNIT + '\n';

		FILE_MASK := 'in::marketmagnifier::leadintegrity::' + TRIM(build_period) + '_*_of_15';
		ds_files := nothor(STD.File.LogicalFileList(FILE_MASK, true, false, true)); 
		inputFileCount := COUNT(ds_files);

		Final := IF(TRIM(build_period)='' OR inputFileCount < 15, 
								Fileservices.Sendemail(Constants.TeamEmailList, failuresubject, Validationfailurebody),
								SEQUENTIAL(RunLI_Attributes,
													 Fileservices.Sendemail(Constants.TeamEmailList, successsubject, successbody)))
								:FAILURE(Fileservices.Sendemail(Constants.TeamEmailList, failuresubject, failurebody));
												
		Return Final;
END;