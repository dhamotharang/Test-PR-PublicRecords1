IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.License_Status, Layouts.Input.License_Status,
		                        License_Status, 'Flat');
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Licensee, Layouts.Input.Licensee,
		                        Licensee, 'Flat');
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.IL_License, Layouts.Input.IL_License,
		                        IL_License, 'Flat');
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Main, Layouts.Base, Main);
	END;

END;