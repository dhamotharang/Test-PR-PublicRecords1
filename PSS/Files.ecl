
import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module
	tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base,layouts.Base,Base	);
export in_response := dataset(Filenames(pversion,pUseOtherEnvironment).in_response, layouts.response_input, csv);
export in_request := dataset(Filenames(pversion,pUseOtherEnvironment).in_request, layouts.request_input, csv);

export in_response_fixed := dataset(Filenames(pversion,pUseOtherEnvironment).in_response_fixed, layouts.response_input_fixed, thor);
export in_request_fixed := dataset(Filenames(pversion,pUseOtherEnvironment).in_request_fixed, layouts.request_input_fixed, thor);

end;