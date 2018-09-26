IMPORT _CONTROL;

/*
	************ Prototype **************

	AlertListService Thor Process that conforms with RAMPS standards.
	Requirements:
		1. Input Data as a Dataset (which will be in the record layout defined by the process)
	  2. Output Logical Filename where the output of the process will end up. (So we can use that logical file for ScoredSearch)
		3. All other parameters must have default values.
*/

EXPORT RAMPS_AlertListService2(String JobId, String inputLogicalFile,
															String outputLogicalFile,
															UNSIGNED pMindidscore = 0, 
															UNSIGNED pMinbdidscore = 0, 
															BOOLEAN ActivateThreshold = false, 
															BOOLEAN Test = false) := FUNCTION																															
																

//		FileID := MAP(~test => inputLogicalFile[stringlib.stringfind(inputLogicalFile, '::', 3)+2..], WORKUNIT); //Name output file for despray to batch for customer
		fun_calculate_overlap_output := '~thordev_socialthor_50::out::social_alert_results::' + JobId;
			
		//Call Alert_Network.fun_calculate_overlap
		FUN_CALCULATE_OVERLAP := Alert_Network.fun_calculate_overlap(inputLogicalFile, pMindidscore, pMinbdidscore, ActivateThreshold, Test, JobId);
		
		//Copy the Output Logical File from the fun_calculate_overlap to the one passed in (OutputLogialFile)
		RETURN sequential(FUN_CALCULATE_OVERLAP);

END;

