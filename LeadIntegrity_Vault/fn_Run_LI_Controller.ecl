EXPORT fn_Run_LI_Controller(build_period = '',LIProcToRun = 1) := FUNCTIONMACRO

	Import LeadIntegrity_Vault, Std;
				
	LIApd01 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '01');
	LIApd02 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '02');
	LIApd03 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '03');
	LIApd04 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '04');
	LIApd05 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '05');
	LIApd06 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '06');
	LIApd07 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '07');
	LIApd08 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '08');
	LIApd09 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '09');
	LIApd10 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '10');
	LIApd11 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '11');
	LIApd12 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '12');
	LIApd13 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '13');
	LIApd14 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '14');
	LIApd15 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '15');		
	
		failuresubject   := 'The LeadIntegrity Build Failed for the Build Period: ' + build_period;
		failurebody      := 'The LeadIntegrity Build Failed for the Build Period: ' + build_period + '\n' +
												          'The Workunit is '+WORKUNIT + '\n' +
												          'ErrorMessage is '+FAILMESSAGE + '\n\n';

		ValDatefailurebody := 'The LeadIntegrity Build did NOT kick off because invalid build date: ' + build_period + '\n' +
														          'The Workunit is '+WORKUNIT + '\n';

  ValCntfailurebody := 'The LeadIntegrity Build did NOT kick off because of missing Input files exspecting 15 files: ' + build_period + '\n' +
														         'The Workunit is '+WORKUNIT + '\n';														 

												
		FILE_MASK := LeadIntegrity_Vault.Constants.MMPrefixNM + TRIM(build_period) + '_*_of_15';
		ds_files := nothor(STD.File.LogicalFileList(FILE_MASK, true, false, true)); 
		inputFileCount := COUNT(ds_files);

		output(build_period,named('Build_Period'));
		output(inputFileCount,named('InputfileCount'));
				
	#IF (LIProcToRun = 1)
		 local RunLI := SEQUENTIAL(LIApd01,LIApd02,LIApd03,LIApd04,LIApd05
		                          ,LIApd06,LIApd07,LIApd08,LIApd09,LIApd10
														 													,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15
																												);
	#ELSEIF (LIProcToRun = 2)                           
		 local RunLI := SEQUENTIAL(LIApd02,LIApd03,LIApd04,LIApd05
		                          ,LIApd06,LIApd07,LIApd08,LIApd09,LIApd10
														 													,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15
																												);		
#ELSEIF (LIProcToRun = 3)                           
		 local RunLI := SEQUENTIAL(LIApd03,LIApd04,LIApd05
		                          ,LIApd06,LIApd07,LIApd08,LIApd09,LIApd10
														 													,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15
																												);
#ELSEIF (LIProcToRun = 4)                           
		 local RunLI := SEQUENTIAL(LIApd04,LIApd05
		                          ,LIApd06,LIApd07,LIApd08,LIApd09,LIApd10
														 													,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15
																												);
#ELSEIF (LIProcToRun = 5)                           
		 local RunLI := SEQUENTIAL(LIApd05,LIApd06,LIApd07,LIApd08,LIApd09,LIApd10
														 													,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15
																												);
#ELSEIF (LIProcToRun = 6)                           
		 local RunLI := SEQUENTIAL(LIApd06,LIApd07,LIApd08,LIApd09,LIApd10,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 7)                           
		 		 local RunLI := SEQUENTIAL(LIApd07,LIApd08,LIApd09,LIApd10,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 8)                           
		 		 local RunLI := SEQUENTIAL(LIApd08,LIApd09,LIApd10,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 9)                           
		 		 local RunLI := SEQUENTIAL(LIApd09,LIApd10,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 10)                           
		 local RunLI := SEQUENTIAL(LIApd10,LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 11)                           
		 local RunLI := SEQUENTIAL(LIApd11,LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 12)                           
		 local RunLI := SEQUENTIAL(LIApd12,LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 13)                           
		 local RunLI := SEQUENTIAL(LIApd13,LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 14)                           
		 local RunLI := SEQUENTIAL(LIApd14,LIApd15);
#ELSEIF (LIProcToRun = 15)                           
		 local RunLI := SEQUENTIAL(LIApd15);
#ELSE 
	  ERROR('fn_Run_LI_Controller - Invalid Parm for LIProcToRun');
#END	

Final := map(TRIM(build_period)='' => Fileservices.Sendemail(Constants.TeamEmailList, failuresubject, ValDatefailurebody)
		            ,inputFileCount < 15 => Fileservices.Sendemail(Constants.TeamEmailList, failuresubject, ValCntfailurebody) 
								      ,RunLI);


Return Final;
				
ENDMACRO;				
	