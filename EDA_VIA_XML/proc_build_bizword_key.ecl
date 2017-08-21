import ut,business_header, versioncontrol, roxiekeybuild;

export proc_build_bizword_key(

	string pversion

) := 
module

	shared keyName		:= business_header.keynames(pversion).EDA.bizwordfreq;

	VersionControl.macBuildNewLogicalKeyWithName(Key_bizword_frequency	,keyname.New	,Build_Key	);
                                          
	export all := 
		sequential(
			if(not VersionControl.DoAllFilesExist.fNamesBuilds(keyName.dAll_filenames)
				,build_key)
			,business_header.promote(pversion,'eda').new2built
		);
	
end;