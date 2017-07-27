import  RoxieKeyBuild, ut, autokey, versioncontrol;

export Build_Keys(
	
	 string		pversion
	,boolean	pOverwrite = true
	
) :=

module

		VersionControl.macBuildNewLogicalKeywithName(Key_addr_search_zip		,Keynames(pversion).AddrZip.Logical		,Build_zipKeys		);
		VersionControl.macBuildNewLogicalKeywithName(Key_addr_search_state		,Keynames(pversion).AddrState.Logical	,Build_stateKeys	);

	export full_build :=
			sequential(Build_zipKeys
				,Build_stateKeys
				,Promote(pversion, 'key').New2Built
		);
		
	export All :=
		if(VersionControl.IsValidVersion(pversion)
			,parallel(full_build)		
			,output('No Valid version parameter passed, skipping USPIS_HotList.Build_Base atribute')
		);
		
end;

