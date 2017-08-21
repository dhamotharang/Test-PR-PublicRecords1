import VersionControl;

export build_base (string pversion) := module

	export create_base := Standardize_Inputs.fAll(Files().InputEntity.Sprayed, Files().InputSVCAddr.Sprayed, pversion);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.new	,create_base	,Build_Base_File	);
	
	export full_build := 
				sequential(
					Build_Base_File
					,Promote(pversion).Base.New2Built
				);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,sequential(full_build)		
		,output('No Valid version parameter passed, skipping Utility_Business.build_base atribute')
	);
		
end;