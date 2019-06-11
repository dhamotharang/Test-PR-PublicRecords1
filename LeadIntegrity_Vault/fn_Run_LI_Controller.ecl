EXPORT fn_Run_LI_Controller(build_period,LIProcToRun = 1) := FUNCTIONMACRO

	Import LeadIntegrity_Vault, Std;
				
	local LIApd01 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '01');
	local LIApd02 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '02');
	local LIApd03 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '03');
	local LIApd04 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '04');
	local LIApd05 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '05');
	local LIApd06 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '06');
	local LIApd07 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '07');
	local LIApd08 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '08');
	local LIApd09 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '09');
	local LIApd10 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '10');
	local LIApd11 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '11');
	local LIApd12 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '12');
	local LIApd13 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '13');
	local LIApd14 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '14');
	local LIApd15 := LeadIntegrity_Vault.fn_LeadIntegrity_Controller(build_period, '15');
	
 local failuresubject   := 'The LeadIntegrity Build Failed for the Build Period: ' + (string) build_period;
		
	local failurebody      := 'The LeadIntegrity Build Failed for the Build Period: ' + (string) build_period + '\n' +
												          'The Workunit is '+WORKUNIT + '\n' +
												          'ErrorMessage is '+FAILMESSAGE + '\n\n';

	local ValDatefailurebody := 'The LeadIntegrity Build did NOT kick off because invalid build date: ' + (string) build_period + '\n' +
														          'The Workunit is '+WORKUNIT + '\n';

 local ValCntfailurebody := 'The LeadIntegrity Build did NOT kick off because of missing Input files exspecting 15 files: ' + (string) build_period + '\n' +
														         'The Workunit is '+WORKUNIT + '\n';														 

												
	local 	FILE_MASK := LeadIntegrity_Vault.Constants.MMPrefixNM + (string) TRIM(build_period) + '_*_of_15';
	local 	ds_files := nothor(STD.File.LogicalFileList(FILE_MASK, true, false, true)); 
	local 	inputFileCount := COUNT(ds_files) :Independent;

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

Final := map(TRIM(build_period)='' => Fileservices.Sendemail(LeadIntegrity_Vault.Constants.TeamEmailList, failuresubject, ValDatefailurebody)
		            ,inputFileCount < 15 => Fileservices.Sendemail(LeadIntegrity_Vault.Constants.TeamEmailList, failuresubject, ValCntfailurebody) 
								      ,RunLI);
										


Return Final;
				
ENDMACRO;				
	