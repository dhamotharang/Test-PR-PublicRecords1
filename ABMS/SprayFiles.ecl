IMPORT _Control, tools;

EXPORT SprayFiles(STRING	pServerIP									= _Control.IPAddress.bctlpedata11,
	                STRING	pDirectory								= '/data/hds_3/ABMS/build',
									// STRING	pFilenameAddress					= 'address*.txt',
									// STRING	pFilenameBIOG			 				= 'biog*.txt',
									// STRING	pFilenameCareer		 				= 'career*.txt',
									// STRING	pFilenameCert			 				= 'cert*.txt',
									// STRING	pFilenameContact	 				= 'contact*.txt',
									// STRING	pFilenameDeceased	 				= 'deceased*.txt',
									// STRING	pFilenameEducation 				= 'education*.txt',
									// STRING	pFilenameMembership				= 'membership*.txt',
									// STRING	pFilenameMOCParticipation	= 'mocpart*.txt',
									// STRING	pFilenameTypeOfPractice		= 'typeofprac*.txt',
									// STRING	pFilenameSchools					= 'zschoolspi*.txt',
									// STRING	pFilenameSpecialty				= 'zspecialtypi*.txt',
									STRING  pFilenameRaw_input				= 'ABMS_Data.txt',
	                STRING8	pversion,
	                STRING	pGroupName								= _Dataset().groupname,
	                BOOLEAN	pIsTesting								= FALSE,
	                BOOLEAN	pOverwrite								= FALSE,
	                BOOLEAN	pReplicate								=	FALSE,
	                STRING	pNameOutput								= 'ABMS Spray Info') := FUNCTION

	MAC_FilesToSpray_Variable(pRemoteFilename, pLocalFilename, outAttr) := MACRO
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
												 _Dataset().max_record_size,
												 '|'
												}
											 ], tools.Layout_Sprays.Info);
	ENDMACRO;

	// MAC_FilesToSpray_Variable(pFilenameAddress,          Filenames(pversion).Input.Address,          FileToSprayAddress);
	// MAC_FilesToSpray_Variable(pFilenameBIOG,             Filenames(pversion).Input.BIOG,             FileToSprayBIOG);
	// MAC_FilesToSpray_Variable(pFilenameCareer,           Filenames(pversion).Input.Career,           FileToSprayCareer);
	// MAC_FilesToSpray_Variable(pFilenameCert,             Filenames(pversion).Input.Cert,             FileToSprayCert);
	// MAC_FilesToSpray_Variable(pFilenameContact,          Filenames(pversion).Input.Contact,          FileToSprayContact);
	// MAC_FilesToSpray_Variable(pFilenameDeceased,         Filenames(pversion).Input.Deceased,         FileToSprayDeceased);
	// MAC_FilesToSpray_Variable(pFilenameEducation,        Filenames(pversion).Input.Education,        FileToSprayEducation);
	// MAC_FilesToSpray_Variable(pFilenameMembership,       Filenames(pversion).Input.Membership,       FileToSprayMembership);
	// MAC_FilesToSpray_Variable(pFilenameMOCParticipation, Filenames(pversion).Input.MOCParticipation, FileToSprayMOCParticipation);
	// MAC_FilesToSpray_Variable(pFilenameTypeOfPractice,   Filenames(pversion).Input.TypeOfPractice,   FileToSprayTypeOfPractice);
	// MAC_FilesToSpray_Variable(pFilenameSchools,          Filenames(pversion).Input.Schools,          FileToSpraySchools);
	// MAC_FilesToSpray_Variable(pFilenameSpecialty,        Filenames(pversion).Input.Specialty,        FileToSpraySpecialty);
	MAC_FilesToSpray_Variable(pFilenameRaw_input,        Filenames(pversion).Input.Raw_input,        FileToSprayRaw_input);

	SprayTheFile(DATASET(tools.Layout_Sprays.Info) FileToSpray) :=
		tools.fun_Spray(FileToSpray, , , pOverwrite, pReplicate, TRUE, pIsTesting, ,
		                   _Dataset().Name + ' ' + pversion, pNameOutput,
											 pShouldSprayMultipleFilesAs1 := TRUE);

	RETURN //PARALLEL(
	  // IF(NOT _Flags.FileExists.Input.Address          OR pOverwrite, SprayTheFile(FileToSprayAddress)),
	  // IF(NOT _Flags.FileExists.Input.BIOG             OR pOverwrite, SprayTheFile(FileToSprayBIOG)),
	  // IF(NOT _Flags.FileExists.Input.Career           OR pOverwrite, SprayTheFile(FileToSprayCareer)),
	  // IF(NOT _Flags.FileExists.Input.Cert             OR pOverwrite, SprayTheFile(FileToSprayCert)),
	  // IF(NOT _Flags.FileExists.Input.Contact          OR pOverwrite, SprayTheFile(FileToSprayContact)),
	  // IF(NOT _Flags.FileExists.Input.Deceased         OR pOverwrite, SprayTheFile(FileToSprayDeceased)),
	  // IF(NOT _Flags.FileExists.Input.Education        OR pOverwrite, SprayTheFile(FileToSprayEducation)),
	  // IF(NOT _Flags.FileExists.Input.Membership       OR pOverwrite, SprayTheFile(FileToSprayMembership)),
	  // IF(NOT _Flags.FileExists.Input.MOCParticipation OR pOverwrite, SprayTheFile(FileToSprayMOCParticipation)),
	  // IF(NOT _Flags.FileExists.Input.TypeOfPractice   OR pOverwrite, SprayTheFile(FileToSprayTypeOfPractice)),
	  // IF(NOT _Flags.FileExists.Input.Schools          OR pOverwrite, SprayTheFile(FileToSpraySchools)),
	  // IF(NOT _Flags.FileExists.Input.Specialty        OR pOverwrite, SprayTheFile(FileToSpraySpecialty)),
		IF(NOT _Flags.FileExists.Input.Raw_input				OR pOverwrite, SprayTheFile(FileToSprayRaw_input));
		// );

END;
