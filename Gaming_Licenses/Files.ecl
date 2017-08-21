import versioncontrol;
export Files(string pversion = '') :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		versioncontrol.macInputFileVersions(Filenames(pversion).Input.NJ, layouts.Input.NJ, NJ,'CSV',,'\n',,1,_Dataset.max_record_size);
                                                                                        
	end;
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
	
		versioncontrol.macBuildFileVersions(Filenames(pversion).Base.NJ, layouts.Base.NJ, NJ);
	                                                                                
	end;


end;