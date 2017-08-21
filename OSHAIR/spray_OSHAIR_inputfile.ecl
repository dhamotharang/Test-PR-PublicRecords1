IMPORT _Control, tools;

EXPORT Spray_OSHAIR_inputfile(STRING8	pversion,
															STRING	pServerIP									= _Control.IPAddress.bctlpedata10,
															STRING	pDirectory								= '/data/hds_4/oshair/data',
															STRING	pFilenameAccident					= 'osha_accident.csv',
															STRING	pFilenameAccidentAbstract	= 'osha_accident_abstract.csv',
															STRING	pFilenameAccidentInjury		= 'osha_accident_injury.csv',
															STRING	pFilenameInspection				= 'osha_inspection.csv',
															STRING	pFilenameOptionalInfo			= 'osha_optional_info.csv',
															STRING	pFilenameRelatedActivity	= 'osha_related_activity.csv',
															STRING	pFilenameStrategicCodes		= 'osha_strategic_codes.csv',
															STRING	pFilenameViolation				= 'osha_violation.csv',
															STRING	pFilenameViolationEvent		= 'osha_violation_event.csv',
															STRING	pFilenameGenDutyStd				= 'osha_violation_gen_duty_std.csv',
															STRING	pGroupName								= _Dataset().groupname,
															BOOLEAN	pIsTesting								= FALSE,
															BOOLEAN	pOverwrite								= FALSE,
															BOOLEAN	pReplicate								=	FALSE,
															STRING	pNameOutput								= 'OSHAIR Spray Info') := FUNCTION

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

	MAC_FilesToSpray_Variable(pFilenameAccident,         Filenames(pversion).Input.Accident,         	FileToSprayAccident);
	MAC_FilesToSpray_Variable(pFilenameAccidentAbstract, Filenames(pversion).Input.AccidentAbstract, 	FileToSprayAccidentAbstract);
	MAC_FilesToSpray_Variable(pFilenameAccidentInjury,   Filenames(pversion).Input.AccidentInjury,   	FileToSprayAccidentInjury);
	MAC_FilesToSpray_Variable(pFilenameInspection,       Filenames(pversion).Input.Inspection,       	FileToSprayInspection);
	MAC_FilesToSpray_Variable(pFilenameOptionalInfo,     Filenames(pversion).Input.OptionalInfo,     	FileToSprayOptionalInfo);
	MAC_FilesToSpray_Variable(pFilenameRelatedActivity,  Filenames(pversion).Input.RelatedActivity,		FileToSprayRelatedActivity);
	MAC_FilesToSpray_Variable(pFilenameStrategicCodes,   Filenames(pversion).Input.StrategicCodes,		FileToSprayStrategicCodes);
	MAC_FilesToSpray_Variable(pFilenameViolation,        Filenames(pversion).Input.Violation,       	FileToSprayViolation);
	MAC_FilesToSpray_Variable(pFilenameViolationEvent,   Filenames(pversion).Input.ViolationEvent,	 	FileToSprayViolationEvent);
	MAC_FilesToSpray_Variable(pFilenameGenDutyStd, 			 Filenames(pversion).Input.GenDutyStd,  		 	FileToSprayGenDutyStd);

	SprayTheFile(DATASET(tools.Layout_Sprays.Info) FileToSpray) :=
		tools.fun_Spray(FileToSpray, , , pOverwrite, pReplicate, TRUE, pIsTesting, ,
		                   _Dataset().Name + ' ' + pversion, pNameOutput,
											 pShouldSprayMultipleFilesAs1 := TRUE);

	RETURN PARALLEL(
	  IF(NOT _Flags.FileExists.Input.Accident					OR pOverwrite, SprayTheFile(FileToSprayAccident)),
	  IF(NOT _Flags.FileExists.Input.AccidentAbstract	OR pOverwrite, SprayTheFile(FileToSprayAccidentAbstract)),
	  IF(NOT _Flags.FileExists.Input.AccidentInjury		OR pOverwrite, SprayTheFile(FileToSprayAccidentInjury)),
	  IF(NOT _Flags.FileExists.Input.Inspection				OR pOverwrite, SprayTheFile(FileToSprayInspection)),
	  IF(NOT _Flags.FileExists.Input.OptionalInfo			OR pOverwrite, SprayTheFile(FileToSprayOptionalInfo)),
	  IF(NOT _Flags.FileExists.Input.RelatedActivity	OR pOverwrite, SprayTheFile(FileToSprayRelatedActivity)),
	  IF(NOT _Flags.FileExists.Input.StrategicCodes		OR pOverwrite, SprayTheFile(FileToSprayStrategicCodes)),
	  IF(NOT _Flags.FileExists.Input.Violation       	OR pOverwrite, SprayTheFile(FileToSprayViolation)),
	  IF(NOT _Flags.FileExists.Input.ViolationEvent 	OR pOverwrite, SprayTheFile(FileToSprayViolationEvent)),
	  IF(NOT _Flags.FileExists.Input.GenDutyStd   		OR pOverwrite, SprayTheFile(FileToSprayGenDutyStd)),
		);

END;
