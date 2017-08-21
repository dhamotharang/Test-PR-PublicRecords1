import ut, EDA_VIA_XML, versioncontrol;

export proc_build_bizword_key(

	string pversion

) := 
module

	shared keyName		:= prte2_business_header.keynames(pversion).EDA.bizwordfreq;

	VersionControl.macBuildNewLogicalKeyWithName(EDA_VIA_XML.Key_bizword_frequency	,keyname.New	,Build_Key	);
                                          
	export all := 
		sequential(
			if(not VersionControl.DoAllFilesExist.fNamesBuilds(keyName.dAll_filenames)
				,build_key)
			,prte2_business_header.promote(pversion,'eda').new2built
		);
	
end;