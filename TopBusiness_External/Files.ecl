import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Source,Layouts.Source,Source);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Address,Layouts.Address,Address);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).FEIN,Layouts.FEIN,FEIN);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Phone,Layouts.Phone,Phone);
	
end;
