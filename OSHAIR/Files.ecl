IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Accident, Layouts_input.Accident, Accident,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.AccidentAbstract, Layouts_input.AccidentAbstract, AccidentAbstract,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.AccidentInjury, Layouts_input.AccidentInjury, AccidentInjury,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Inspection, Layouts_input.Inspection, Inspection,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.OptionalInfo, Layouts_input.OptionalInfo, OptionalInfo,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.RelatedActivity, Layouts_input.RelatedActivity, RelatedActivity,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.StrategicCodes, Layouts_input.StrategicCodes, StrategicCodes,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Violation, Layouts_input.Violation, Violation,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.GenDutyStd, Layouts_input.GenDutyStd,
		                        GenDutyStd, 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.ViolationEvent, Layouts_input.ViolationEvent,
		                        ViolationEvent, 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := ',', pHeading := 1);
	END;

END;