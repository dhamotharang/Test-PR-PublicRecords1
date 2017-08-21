import  versioncontrol;

export Proc_Build_Keys(

	string pversion

) :=
function

	shared keyName	:= keynames(pversion);

	VersionControl.macBuildNewLogicalKeyWithName(Key_did								,keyName.Did.New								,Build_Key1);
	VersionControl.macBuildNewLogicalKeyWithName(Key_bdid								,keyName.bdid.New								,Build_Key2);
	VersionControl.macBuildNewLogicalKeyWithName(Key_contactID					,keyName.contactid.New					,Build_Key3);
	VersionControl.macBuildNewLogicalKeyWithName(Key_companyname_domain	,keyName.companyname_domain.New	,Build_Key4);
	VersionControl.macBuildNewLogicalKeyWithName(Key_DID_FCRA						,keyName.fcra.Did_FCRA.New			,Build_Key5);
	VersionControl.macBuildNewLogicalKeyWithName(Key_LinkIDs.key				,keyName.LinkIDs.New						,Build_LinkIDs);
	
	keygroupnames := 
				keyName.Did.dAll_filenames                                                                           
			+ keyName.Bdid.dAll_filenames
			+ keyName.contactid.dAll_filenames
			+ keyName.companyname_domain.dAll_filenames
			+ keyName.fcra.Did_FCRA.dAll_filenames
			+ keyName.LinkIDs.dAll_filenames
	 	; 

	build_keys :=
		parallel(
			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_LinkIDs
		);

	buildall := 
	sequential(
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
			,build_keys
		)
		,promote(pversion,'^(?!.*autokey).*$').new2built
	);
	
	return buildall ;

end;