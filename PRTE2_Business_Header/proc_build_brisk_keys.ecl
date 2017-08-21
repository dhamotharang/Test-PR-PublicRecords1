import ut, Roxiekeybuild, business_header, Business_Risk, versioncontrol;

export proc_build_brisk_keys(

	string pversion

) := 
module

	shared keyName		:= prte2_business_header.keynames(pversion).risk;

	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.key_bdid_table								,keyName.Bdid.New					,Build_Key1);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.key_fein_table								,keyName.Fein.New					,Build_Key2);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.key_groupid_cnt							,keyName.Groupid.New			,Build_Key3);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.Key_BH_Fein									,keyName.FeinCompany.New	,Build_Key4);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.Key_BH_BDID_Phone						,keyName.BdidPhone.New		,Build_Key5);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.Key_Bus_Cont_DID_2_BDID			,keyName.Did.New					,Build_Key6);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.key_BDID_risk_table					,keyName.BdidRisk.New			,Build_Key7);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Risk.Key_Business_Header_Address	,keyName.BHAddress.New		,Build_Key8);

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
		,prte2_business_header.promote(pversion,'^(.*?)key(.*?)$').new2built

	);

end;