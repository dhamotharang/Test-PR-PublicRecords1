IMPORT STD, Tools;

EXPORT proc_CopyFiles(string filedate) := FUNCTION

	GetSubFile	:= NOTHOR(STD.File.SuperFileContents('~thor_data400::key::neighborhood::qa::crime::geolink')[1].name);

	//Keeping this format in case other metadata keys are added to be copied
	myFilelist	:=	DATASET([{'~'+GetSubFile, '~prte::key::neighborhood::'+filedate+'::crime::geolink','thor400_20','10.241.20.205',[{'~prte::key::neighborhood::qa::crime::geolink'}]}
													],Tools.Layout_fun_CopyFiles.Input);


RETURN	tools.fun_CopyFiles(
					myFilelist	//	pCopyInformation
					,TRUE				//	pClearSuperFirst			=	true
					,FALSE			//	pIsTesting						=	false
					,TRUE				//	pShouldCompress				=	true
					,TRUE				//	pOverwrite						=	false
					,						//	pDeleteSrcFiles		    =	false
					,						//	pSkipSuperfileStuff	  =	false
					,						//	pFileDescription      =	workunit
					);
					
END;