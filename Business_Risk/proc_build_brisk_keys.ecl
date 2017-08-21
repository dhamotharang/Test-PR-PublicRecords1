import ut, Roxiekeybuild, business_header, versioncontrol;

export proc_build_brisk_keys(

	string pversion

) := 
module

	shared keyName		:= business_header.keynames(pversion).risk;

	VersionControl.macBuildNewLogicalKeyWithName(key_bdid_table								,keyName.Bdid.New					,Build_Key1);
	VersionControl.macBuildNewLogicalKeyWithName(key_fein_table								,keyName.Fein.New					,Build_Key2);
	VersionControl.macBuildNewLogicalKeyWithName(key_groupid_cnt							,keyName.Groupid.New			,Build_Key3);
	VersionControl.macBuildNewLogicalKeyWithName(Key_BH_Fein									,keyName.FeinCompany.New	,Build_Key4);
	VersionControl.macBuildNewLogicalKeyWithName(Key_BH_BDID_Phone						,keyName.BdidPhone.New		,Build_Key5);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Bus_Cont_DID_2_BDID			,keyName.Did.New					,Build_Key6);
	VersionControl.macBuildNewLogicalKeyWithName(key_BDID_risk_table					,keyName.BdidRisk.New			,Build_Key7);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Header_Address	,keyName.BHAddress.New		,Build_Key8);

	shared keygroupnames := 
				keyName.dAll_filenames                                                                           
			; 
                                          
	shared Build_Keys :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
		,parallel(

			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_Key6
			,Build_Key7
			,Build_Key8

		));

	export all := 
	sequential(

		 Build_Keys
		,business_header.promote(pversion,'^(?!.*moxie)(.*?)key(.*?)$').new2built

	);

end;