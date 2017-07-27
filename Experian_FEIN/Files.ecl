import tools;

export Files(string pversion = '',boolean pUseOtherEnvironment = false) := module

	//------------------------
	// Input File Versions
	//------------------------
	tools.mac_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input
											 ,layouts.Input.sprayed ,Input );
												 		 
	//------------------------
	// Base File Versions
	//------------------------
	tools.mac_FilesBase	(Filenames(pversion,pUseOtherEnvironment).Base
											 ,layouts.Base ,Base);
	
end;