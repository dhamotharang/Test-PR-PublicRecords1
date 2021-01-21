IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	  // No idea of the why's, but you MUST have the pQuote parameter accounted for, in order to have the
		// multiple pTerminator interpreted correctly.
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Address, Layouts.Input.Address, Address);
		                        // 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.BIOG, Layouts.Input.BIOG, BIOG);
		                        // 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Career, Layouts.Input.Career, Career,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Cert, Layouts.Input.Cert, Cert);
		                        // 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Contact, Layouts.Input.Contact, Contact,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Deceased, Layouts.Input.Deceased, Deceased);
		                        // 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Education, Layouts.Input.Education, Education);
		                        // 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Membership, Layouts.Input.Membership, Membership,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.MOCParticipation, Layouts.Input.MOCParticipation,
		                        // MOCParticipation, 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		                        MOCParticipation);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.TypeOfPractice, Layouts.Input.TypeOfPractice,
		                        TypeOfPractice, 'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Schools, Layouts.Input.Schools, Schools,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Specialty, Layouts.Input.Specialty, Specialty,
		                        'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Raw_input, Layouts.Input.Raw_input, Raw_input,
														'CSV', , pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Main,           Layouts.Base.Main,           Main);
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Career,         Layouts.Base.Career,         Career);
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Cert,           Layouts.Base.Cert,           Cert);
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Education,      Layouts.Base.Education,      Education);
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Membership,     Layouts.Base.Membership,     Membership);
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.TypeOfPractice, Layouts.Base.TypeOfPractice, TypeOfPractice);
	END;

END;