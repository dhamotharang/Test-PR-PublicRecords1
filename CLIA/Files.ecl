import tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Main, Layouts.Input,
		                        Main, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Accreditation, Layouts.Input,
		                        Accreditation, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Compliance, Layouts.Input,
		                        Compliance, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Microscopy, Layouts.Input,
		                        Microscopy, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Waiver, Layouts.Input,
		                        Waiver, 'CSV', pHeading := 1);
	END;

	EXPORT Input_Alt := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Main, Layouts.Input_Alt,
		                        Main, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Accreditation, Layouts.Input_Alt,
		                        Accreditation, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Compliance, Layouts.Input_Alt,
		                        Compliance, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Microscopy, Layouts.Input_Alt,
		                        Microscopy, 'CSV', pHeading := 1);
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Waiver, Layouts.Input_Alt,
		                        Waiver, 'CSV', pHeading := 1);
	END;

	EXPORT Input_From_CD := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Main, Layouts.Input_From_CD, Main, 'Flat');
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Main, Layouts.Base, Main);
	END;

END;