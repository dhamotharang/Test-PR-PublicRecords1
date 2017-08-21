import _control,STD,Bair;
EXPORT fFileMoves(		string pVersion,
											string pDaliServer  = Bair._constant.bair_batchlz,
											string pLandingZone = '/data/batchimport/ready/') := module

	shared ready    := REGEXREPLACE('ready', pLandingZone, 'ready');
	shared done     := REGEXREPLACE('ready', pLandingZone, 'done'); 
	shared err    	:= REGEXREPLACE('ready', pLandingZone, 'error'); 
	shared spraying := REGEXREPLACE('ready', pLandingZone, 'spraying'); 

	Export MoveReadyToSpraying := function
	  file_list := FileServices.RemoteDirectory(pDaliServer,ready,'*'+pVersion+'*');
	  move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,ready+trim(file_list.name),spraying+trim(file_list.name))));
		return move_file_list;
	End;
	Export MoveSprayingToError := function
		file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),err+trim(file_list.name))));
		return move_file_list;	
	End;
	Export MoveSprayingToDone := function
		file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),done+trim(file_list.name))));
		return move_file_list;
	End;
	// Export MoveManifestToSpraying := function
		// file_list := FileServices.RemoteDirectory(pDaliServer,ready,'*'+pVersion+'*_manifest');
		// move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,ready+trim(file_list.name),spraying+trim(file_list.name))));
		// return move_file_list;
	// End;	
	// Export MoveManifestToDone := function
		// file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pVersion+'*_manifest');
		// move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),done+trim(file_list.name))));
		// return move_file_list;
	// End;	
	// Export MoveManifestToError := function
		// file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pVersion+'*_manifest');
		// move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),err+trim(file_list.name))));
		// return move_file_list;
	// End;	
End;