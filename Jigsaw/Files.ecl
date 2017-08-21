import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export Live		       := tools.macf_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Live		        ,layouts.Input.Sprayed	,'CSV',,,,1,_Dataset().max_record_size,true);
		export Dead		       := tools.macf_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.Dead		        ,layouts.Input.Sprayed	,'CSV',,,,1,_Dataset().max_record_size,true);
		export DeletedRemove := tools.macf_FilesInput(Filenames(pversion,pUseOtherEnvironment).Input.DeletedRemove	,layouts.Input.Sprayed	,'CSV',,,,1,_Dataset().max_record_size,true);
                                                                                        
	end;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := tools.macf_FilesBase(Filenames(pversion,pUseOtherEnvironment).Base, layouts.Base);


end;