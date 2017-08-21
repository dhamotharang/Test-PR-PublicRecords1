import versioncontrol;

export Filenames(string pversion = '') :=
module

	export ftemplate(string pFiletype, string pState)	:= _Dataset.thor_cluster_files + pFiletype + '::' + _Dataset.name + '::@version@::' + pState;

	export input :=
	module

		export NJ	:= versioncontrol.mInputFilenameVersions(ftemplate('in','NJ'));
		                                                                   
		export dAll_filenames := 
				NJ.dAll_filenames
			; 

	end;

	export base :=
	module

		export NJ	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','NJ')	,pversion);
                                                                
		export dAll_filenames := 
				NJ.dAll_filenames
			; 
	
	end;

	export dAll_filenames := 
		base.dAll_filenames
		;

end;