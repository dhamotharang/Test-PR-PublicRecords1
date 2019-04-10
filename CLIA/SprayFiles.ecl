IMPORT _Control, tools;

EXPORT SprayFiles(STRING	pServerIP									= _Control.IPAddress.bctlpedata11,
	                STRING	pDirectory								= '/data/data_build_4/CLIA/data',
	                STRING	pFilenameAll   						= '*all*clia*csv',
	                STRING	pFilenameAllFromCD				= '*clia*txt',
	                STRING	pFilenameAccreditation  	= '*accred*csv',
	                STRING	pFilenameCompliance   		= '*compliance*csv',
	                STRING	pFilenameMicroscopy   		= '*microscopy*csv',
	                STRING	pFilenameWaiver   				= '*wa*csv',
	                STRING	pversion,
	                STRING	pGroupName								= _Dataset().groupname,
	                BOOLEAN	pIsTesting								= FALSE,
	                BOOLEAN	pOverwrite								= FALSE,
	                BOOLEAN	pReplicate								=	FALSE,
	                STRING	pNameOutput								= 'CLIA Spray Info') := FUNCTION

	MAC_FilesToSpray(pRemoteFilename, pLocalFilename, outAttr) := MACRO
		outAttr := DATASET([
												{pServerIP,
												 pDirectory + '/' + pversion,
												 pRemoteFilename,
												 0,
												 pLocalFilename.Template,
												 [{pLocalFilename.Sprayed}],
												 pGroupName,
												 pversion,
												 '',
												 'VARIABLE',
												 '',
												 _Dataset().max_record_size
												}
											 ], tools.Layout_Sprays.Info);
	ENDMACRO;
	
	MAC_FilesToSpray_Fixed(pRemoteFilename, pLocalFilename, pRecordSize, outAttr) := MACRO
		outAttr := DATASET([
												{pServerIP,
												 pDirectory + '/' + pversion,
												 pRemoteFilename,
												 pRecordSize,
												 pLocalFilename.Template,
												 [{pLocalFilename.Sprayed}],
												 pGroupName,
												 pversion,
												 '',
												 'FIXED',
												 '',
												 _Dataset().max_record_size
												}
											 ], tools.Layout_Sprays.Info);
	ENDMACRO;
	
	// MAC_FilesToSpray(pFilenameAll,           Filenames(pversion).Input.Main,          FileToSprayMain);
	// MAC_FilesToSpray(pFilenameAccreditation, Filenames(pversion).Input.Accreditation, FileToSprayAccreditation);
	// MAC_FilesToSpray(pFilenameCompliance,    Filenames(pversion).Input.Compliance,    FileToSprayCompliance);
	// MAC_FilesToSpray(pFilenameMicroscopy,    Filenames(pversion).Input.Microscopy,    FileToSprayMicroscopy);
	// MAC_FilesToSpray(pFilenameWaiver,        Filenames(pversion).Input.Waiver,        FileToSprayWaiver);
	
	MAC_FilesToSpray_Fixed(pFilenameAllFromCD, Filenames(pversion).Input.Main, 322, FileToSprayMain);

	SprayTheFile(DATASET(tools.Layout_Sprays.Info) FileToSpray) :=
		tools.fun_Spray(FileToSpray, , , pOverwrite, pReplicate, TRUE, pIsTesting, ,
		                   _Dataset().Name + ' ' + pversion, pNameOutput,
											 pShouldSprayMultipleFilesAs1 := TRUE);

	RETURN PARALLEL(
	  IF(NOT _Flags.FileExists.Input.Main OR pOverwrite,          SprayTheFile(FileToSprayMain))
	  // IF(NOT _Flags.FileExists.Input.Accreditation OR pOverwrite, SprayTheFile(FileToSprayAccreditation)),
	  // IF(NOT _Flags.FileExists.Input.Compliance OR pOverwrite,    SprayTheFile(FileToSprayCompliance)),
	  // IF(NOT _Flags.FileExists.Input.Microscopy OR pOverwrite,    SprayTheFile(FileToSprayMicroscopy)),
	  // IF(NOT _Flags.FileExists.Input.Waiver OR pOverwrite,        SprayTheFile(FileToSprayWaiver))
		);

END;
