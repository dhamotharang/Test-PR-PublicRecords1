EXPORT fFileMoves(string pDaliServer, string pLandingZone, string pBuildVersion) := module
	import STD;

	shared ready    := REGEXREPLACE('ready', pLandingZone, 'ready/');
	shared done     := REGEXREPLACE('ready', pLandingZone, 'done/'); 
	shared err    	:= REGEXREPLACE('ready', pLandingZone, 'error/'); 
	shared spraying := REGEXREPLACE('ready', pLandingZone, 'spraying/'); 

	Export MoveReadyToSpraying := function
	  file_list := FileServices.RemoteDirectory(pDaliServer,ready,'*'+pBuildVersion+'*');
	  move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,ready+trim(file_list.name),spraying+trim(file_list.name))));
		return move_file_list;
	End;
	Export MoveReadyToError := function
	  file_list := FileServices.RemoteDirectory(pDaliServer,ready,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,ready+trim(file_list.name),err+trim(file_list.name))));
		return move_file_list;
	End;
	Export MoveSprayingToError := function
		file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),err+trim(file_list.name))));
		return move_file_list;	
	End;
	Export MoveSprayingToDone := function
		file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),done+trim(file_list.name))));
		return move_file_list;
	End;
	Export MoveDoneToReady := function
		file_list := FileServices.RemoteDirectory(pDaliServer,done,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,done+trim(file_list.name),ready+trim(file_list.name))));
		return move_file_list;
	End;
	Export MoveSprayingToReady := function
		file_list := FileServices.RemoteDirectory(pDaliServer,spraying,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,spraying+trim(file_list.name),ready+trim(file_list.name))));
		return move_file_list;	
	End;
	Export MoveErrorToReady := function
		file_list := FileServices.RemoteDirectory(pDaliServer,err,'*'+pBuildVersion+'*');
		move_file_list := NOTHOR(APPLY(file_list,FileServices.MoveExternalFile(pDaliServer,err+trim(file_list.name),ready+trim(file_list.name))));
		return move_file_list;	
	End;
End;