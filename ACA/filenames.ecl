import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::@version@::suppression_file';

	export Input	:= versioncontrol.mInputFilenameVersions(lInputTemplate						);
                                                                        
end;