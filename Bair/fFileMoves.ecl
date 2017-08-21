EXPORT fFileMoves(string version = '') := module
	import STD, _control;
	
	shared pLandingZone := '/data/bair/';
	
	shared ready    := pLandingZone + 'ready/';
	shared done     := pLandingZone + 'done/';
	shared err    	:= pLandingZone + 'error/';
	shared spraying := pLandingZone + 'spraying/';
	
	shared pServerIP	:= Bair._Constant.bair_batchlz;	

	shared fnFileList(string subDir = '') := function	
		file_list := Bair.GetSrcFileList(version, subDir) : global(few);
		readytogo := FileServices.RemoteDirectory(pServerIP, pLandingZone + subDir, 'readytogo');
		return file_list + readytogo;
	end;

	Export MoveReadyToSpraying := sequential(
		nothor(apply(fnFileList('ready'), STD.File.MoveExternalFile( pServerIP, ready + name, spraying + name )))
	 ,nothor(STD.File.DeleteExternalFile( pServerIP, pLandingZone + 'spraying/readytogo' ))
	);
	
	Export MoveReadyToDone := sequential(
		nothor(apply(fnFileList('ready'), STD.File.MoveExternalFile( pServerIP, ready + name, done + name )))
	);
	
	Export MoveReadyToError := sequential(
		nothor(apply(fnFileList('ready'), STD.File.MoveExternalFile( pServerIP, ready + name, err + name )))
	);
	
	Export MoveSprayingToError := sequential(
		nothor(apply(fnFileList('spraying'), STD.File.MoveExternalFile( pServerIP, spraying + name, err + name )))
	);
	
	Export MoveSprayingToDone := sequential(
		nothor(apply(fnFileList('spraying'), STD.File.MoveExternalFile( pServerIP, spraying + name, done + name )))
	);
	
	Export MoveSprayingToReady := sequential(
		nothor(apply(fnFileList('spraying'), STD.File.MoveExternalFile( pServerIP, spraying + name, ready + name )))
	);
	
	Export MoveDoneToReady := sequential(
		nothor(apply(fnFileList('done'), STD.File.MoveExternalFile( pServerIP, done + name, ready + name )))
	);	
	
	Export MoveErrorToReady := sequential(
		nothor(apply(fnFileList('err'), STD.File.MoveExternalFile( pServerIP, err + name, ready + name )))
	);

End;