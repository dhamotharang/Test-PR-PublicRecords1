import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lInputTemplate	:= _Dataset(pUseProd).thor_cluster_Files + 'in::' 	+ _Dataset().name + '::@version@::data';
	export lBaseTemplate	:= _Dataset(pUseProd).thor_cluster_Files + 'base::' + _Dataset().name + '::@version@::data';

	export Input	:= versioncontrol.mInputFilenameVersions(lInputTemplate						);
	export Base		:= versioncontrol.mBuildFilenameVersions(lBaseTemplate	,pversion	);
                                                                        
	export dAll_filenames :=
		  Base.dAll_filenames
	;

end;