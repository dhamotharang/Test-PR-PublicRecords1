IMPORT InsuranceHeader_Salt_T46,IDL_HEADER,InsuranceHeader_PreProcess;
EXPORT proc_cleanFiles_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	// Move Did to Rid to Processed SuperFile and resets DID to RID request file
		manual_did2ridExists	:= fileservices.getsuperfilesubcount(InsuranceHeader_Salt_T46.ManualDidToRid.superfile) = 1;
		cleanDid2RidFile	:= 	IF(manual_did2ridExists,
		                               SEQUENTIAL(InsuranceHeader_PreProcess.SuperFiles.updateDid2RidProccessedSuperFiles(),
																							FileServices.StartSuperFileTransaction(),																				  
																							Fileservices.SwapSuperFile(InsuranceHeader_Salt_T46.ManualDidToRid.superfile,idl_header.files.FILE_IDL_DID2RID_PROCESSED_BASE),
																							FileServices.FinishSuperFileTransaction()
																						 ),
																   OUTPUT('No manual record did2rid file used in this iteration'));
																	 
		// Move Suppress Addback requests to Processed SuperFile AND resets the Addback request file
		manual_addbackExists	  := fileservices.getsuperfilesubcount(InsuranceHeader_Salt_T46.ManualSuppression.superfile_addback) = 1;
		cleanAddbackFile	:= 	IF(manual_addbackExists,
		                               SEQUENTIAL(InsuranceHeader_PreProcess.SuperFiles.updateAddbackSuperFiles(),
																							FileServices.StartSuperFileTransaction(),																				  
																							Fileservices.SwapSuperFile(idl_header.files.FILE_SUPPRESSED_ADDBACK,idl_header.files.FILE_SUPPRESSED_ADDBACK_PROCESSED_BASE),
																							FileServices.FinishSuperFileTransaction()
																						 ),
																   OUTPUT('No manual record suppression addback file used in this iteration'));
	RETURN SEQUENTIAL(cleanDid2RidFile,cleanAddbackFile);
	
END;