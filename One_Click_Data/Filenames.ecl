import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	export ftemplate(string pFiletype)	:= _Dataset(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + '::@version@';

	export input 					:= versioncontrol.mInputFilenameVersions(ftemplate('in'		) + '::Data',pFileDate := pversion);
	export base 					:= versioncontrol.mBuildFilenameVersions(ftemplate('base'	) + '::Data',pversion);

	export dAll_filenames :=
			Base.dAll_filenames
//		+ stat.dAll_filenames
	;

end;