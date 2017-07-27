import tools;
EXPORT Files(string pversion = '',boolean pUseOtherEnvironment = false) := module

	// Raw_Input File Versions
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input
											 ,layouts.Input.sprayed ,Input );
												 		 
	// Base_File Versions
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base
											 ,layouts.Base ,Base);
	
end;