IMPORT tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseProd = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Death, Layouts.Input.Death,
		                        Death, 'Flat');
		tools.mac_FilesInput(Filenames(pversion, pUseProd).Input.Death_IL, Layouts.Input.Death_IL,
		                        Death_IL, 'Flat');
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		tools.mac_FilesBase(Filenames(pversion, pUseProd).Base.Main, Layouts.Base, Main);
	END;

END;