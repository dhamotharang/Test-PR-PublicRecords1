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
	
	/////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////	
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Accident,OSHAIR.layout_OSHAIR_accident_clean,Accident);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.hazardous,OSHAIR.layout_OSHAIR_hazardous_substance_clean,hazardous);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Inspection,OSHAIR.layout_OSHAIR_inspection_clean_BIP,Inspection);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.OptionalInfo,OSHAIR.layout_OSHAIR_optional_info_clean,OptionalInfo);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.program,OSHAIR.layout_OSHAIR_program_clean,program);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.related_activity,OSHAIR.layout_OSHAIR_related_activity_clean,related_activity);
		
		tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.violations,OSHAIR.layout_OSHAIR_violations_clean,violations);
	
	END;

END;