import ut, RoxieKeyBuild, paw_services, versioncontrol, paw;

export proc_build_business_keys(

	string pversion

) := 
module

	shared keyName	:= keynames(pversion);

	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Header_Address	,keyName.Base.PnStPrZipSr.New	,Build_Key1);

	shared keygroupnames := 
				keyName.Base.PnStPrZipSr.dAll_filenames                                                                           
			; 

	shared build_keys :=
		parallel(
			 Build_Key1
		);

	export all := 
	sequential(
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames), build_keys)
		,promote(pversion,'business_header.address').new2built

	);

end;
