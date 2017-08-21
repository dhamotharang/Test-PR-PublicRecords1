IMPORT _Control, tools;

EXPORT SprayFiles(STRING	pServerIP								= _Control.IPAddress.bctlpedata10,
	                STRING	pDirectory							= '/data/data_build_4/Death_MI/data',
	                STRING	pFilenameDeath					= '5655*',
	                STRING	pFilenameDeath_IL				= '5758*',
	                STRING8	pversion,
	                STRING	pGroupName							= _Dataset().groupname,
	                BOOLEAN	pIsTesting							= FALSE,
	                BOOLEAN	pOverwrite							= FALSE,
	                BOOLEAN	pReplicate							=	FALSE,
	                STRING	pNameOutput							= 'Death_MI Spray Info') := FUNCTION

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

	MAC_FilesToSpray_Fixed(pFilenameDeath, Filenames(pversion).Input.Death, 142, FileToSprayDeath);
	MAC_FilesToSpray_Fixed(pFilenameDeath_IL, Filenames(pversion).Input.Death_IL, 177, FileToSprayDeathIL);

	SprayTheFile(DATASET(tools.Layout_Sprays.Info) FileToSpray) :=
		tools.fun_Spray(FileToSpray, , , pOverwrite, pReplicate, TRUE, pIsTesting, ,
		                   _Dataset().Name + ' ' + pversion, pNameOutput);

	RETURN PARALLEL(
	  IF(NOT _Flags.FileExists.Input.Death OR pOverwrite,    SprayTheFile(FileToSprayDeath)),
		IF(NOT _Flags.FileExists.Input.Death_IL OR pOverwrite, SprayTheFile(FileToSprayDeathIL)));

END;
