
import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).in_request ,layouts.request_input, in_request	);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).in_response ,layouts.response_input, in_response	);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).in_request_fixed ,layouts.request_input_fixed, in_request_fixed);
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).in_response_fixed ,layouts.response_input_fixed, in_response_fixed);
	
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base,layouts.Base,Base	);

end;
