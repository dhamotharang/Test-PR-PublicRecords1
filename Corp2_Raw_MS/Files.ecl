import ut, tools, Corp2_Raw_MS;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_MS.Filenames(pversion, pUseOtherEnvironment).Input.Profiles, Corp2_Raw_MS.Layouts.ProfilesLayoutIn, Profiles
												,'Profiles/Document/Record'); //XML data
		tools.mac_FilesInput(Corp2_Raw_MS.Filenames(pversion, pUseOtherEnvironment).Input.Forms,    Corp2_Raw_MS.Layouts.FormsLayoutIn, Forms
												,'CSV', , pTerminator := ['\r\n'] , pSeparator := ['\t'] );
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_MS.Filenames(pversion, pUseOtherEnvironment).Base.Profiles, Corp2_Raw_MS.Layouts.ProfilesLayoutBase, Profiles);
		tools.mac_FilesBase(Corp2_Raw_MS.Filenames(pversion, pUseOtherEnvironment).Base.Forms,    Corp2_Raw_MS.Layouts.FormsLayoutBase, Forms);	
	END;

END;