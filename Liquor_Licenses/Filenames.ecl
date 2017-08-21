import versioncontrol;

export Filenames(string pversion = '') :=
module

	export ftemplate(string pFiletype, string pState)	:= _Dataset.thor_cluster_files + pFiletype + '::' + _Dataset.name + '::@version@::' + pState;

	export input :=
	module

		export CA	:= versioncontrol.mInputFilenameVersions(ftemplate('in','CA'));
		export CT	:= versioncontrol.mInputFilenameVersions(ftemplate('in','CT'));
		export IN	:= versioncontrol.mInputFilenameVersions(ftemplate('in','IN'));
		export KY	:= versioncontrol.mInputFilenameVersions(ftemplate('in','KY'));
		export LA	:= versioncontrol.mInputFilenameVersions(ftemplate('in','LA'));
		export NH	:= versioncontrol.mInputFilenameVersions(ftemplate('in','NH'));
		export OH	:= versioncontrol.mInputFilenameVersions(ftemplate('in','OH'));
		export PA	:= versioncontrol.mInputFilenameVersions(ftemplate('in','PA'));
		export TX	:= versioncontrol.mInputFilenameVersions(ftemplate('in','TX'));
                                                                
		export dAll_filenames := 
				CA.dAll_filenames
			+ CT.dAll_filenames
			+ IN.dAll_filenames
			+ KY.dAll_filenames
			+ LA.dAll_filenames
			+ NH.dAll_filenames
			+ OH.dAll_filenames
			+ PA.dAll_filenames
			+ TX.dAll_filenames
			; 

	end;

	export base :=
	module

		export CA	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','CA')	,pversion);
		export CT	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','CT')	,pversion);
		export IN	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','IN')	,pversion);
		export KY	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','KY')	,pversion);
		export LA	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','LA')	,pversion);
		export NH	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','NH')	,pversion);
		export OH	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','OH')	,pversion);
		export PA	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','PA')	,pversion);
		export TX	:= versioncontrol.mBuildFilenameVersions(ftemplate('base','TX')	,pversion);
                                                                         
		export dAll_filenames := 
				CA.dAll_filenames
			+ CT.dAll_filenames
			+ IN.dAll_filenames
			+ KY.dAll_filenames
			+ LA.dAll_filenames
			+ NH.dAll_filenames
			+ OH.dAll_filenames
			+ PA.dAll_filenames
			+ TX.dAll_filenames
			; 
	
	end;

	export dAll_filenames := 
		base.dAll_filenames
		;

end;