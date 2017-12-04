IMPORT _Control, tools;

EXPORT SprayFiles(STRING	pServerIP								= _Control.IPAddress.bctlpedata10,
	                STRING	pDirectory							= '/data/hds_4/MMCP/data',
	                STRING	pFilenameLicenseStatus	= '4386*',
	                STRING	pFilenameLicensee 			= '4385*',
	                STRING	pFilenameILLicense 			= '5757*',
	                STRING	pversion,
	                STRING	pGroupName							= _Dataset().groupname,
	                BOOLEAN	pIsTesting							= FALSE,
	                BOOLEAN	pOverwrite							= FALSE,
	                BOOLEAN	pReplicate							=	FALSE,
	                STRING	pNameOutput							= 'MMCP Spray Info') := FUNCTION

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

	MAC_FilesToSpray_Fixed(pFilenameLicenseStatus, Filenames(pversion).Input.License_Status, 81, FileToSprayLicenseStatus);
	MAC_FilesToSpray_Fixed(pFilenameLicensee, Filenames(pversion).Input.Licensee, 269, FileToSprayLicensee);
	MAC_FilesToSpray_Fixed(pFilenameILLicense, Filenames(pversion).Input.IL_License, 942, FileToSprayILLicense);

	SprayTheFile(DATASET(tools.Layout_Sprays.Info) FileToSpray) :=
		tools.fun_Spray(FileToSpray, , , pOverwrite, pReplicate, TRUE, pIsTesting, ,
		                   _Dataset().Name + ' ' + pversion, pNameOutput,
											 pShouldSprayMultipleFilesAs1 := TRUE);

	RETURN PARALLEL(
	  IF(NOT _Flags.FileExists.Input.License_Status OR pOverwrite, SprayTheFile(FileToSprayLicenseStatus)),
		IF(NOT _Flags.FileExists.Input.Licensee OR pOverwrite,       SprayTheFile(FileToSprayLicensee)),
		IF(NOT _Flags.FileExists.Input.IL_License OR pOverwrite,     SprayTheFile(FileToSprayILLicense)));

END;
