import ut;

export Proc_SOFF_OKC_Build := FUNCTION
 
 #workunit('name','Digs SexPred Pre-process: SOFF_OKC Build ');
  MainFile := Mapping_Offender; 
	 
		 
  return sequential( SuperFile_Functions.Fun_createsuperfile(SOFF_SuperFileList.FULL_OKC_FILE),
	                   SuperFile_Functions.DoCleanup(SOFF_SuperFileList.FULL_OKC_FILE+ut.GetDate,
										                               SOFF_SuperFileList.FULL_OKC_FILE),
		                 output(MainFile,,SOFF_SuperFileList.FULL_OKC_FILE+ut.GetDate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n'), quote('')),overwrite),
						         FileServices.StartSuperFileTransaction(),
                     SuperFile_Functions.Fun_Clearsuperfile(SOFF_SuperFileList.FULL_OKC_FILE),
							       SuperFile_Functions.Fun_AddToSuperfile(SOFF_SuperFileList.FULL_OKC_FILE+ut.GetDate,
										                                        SOFF_SuperFileList.FULL_OKC_FILE),
							       FileServices.FinishSuperFileTransaction()
									 );
 end ;