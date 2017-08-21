import versioncontrol;
export proc_Build(string pversion, boolean pOverwrite = false) :=
module

	//Do AK
	macBuild_State(AK,AK_dataset);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.AK	,AK_dataset	,Build_AK_File	,,,pOverwrite);
	
	//Do AL
	macBuild_State(AL,AL_dataset);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.AL	,AL_dataset	,Build_AL_File	,,,pOverwrite);

	//Do AR
	macBuild_State(AR,AR_dataset);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.AR	,AR_dataset	,Build_AR_File	,,,pOverwrite);

	//Do AZ
	macBuild_State(AZ,AZ_dataset);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.AZ	,AZ_dataset	,Build_AZ_File	,,,pOverwrite);

	export build_all :=
	sequential(

		 Build_AK_File
		,Build_AL_File
		,Build_AR_File
		,Build_AZ_File

	);

end;