import doxie, tools, versioncontrol;

export Build_Keys_Kel(
	 string pversion = ''
  ) := module
  
	shared TheKeys := Keys(
		 pversion
	);

	tools.mac_WriteIndex('TheKeys.Main.EntityProfile.New',BuildEntityProfileKey);
	tools.mac_WriteIndex('TheKeys.Main.ConfigAttributes.New',BuildConfigAttributesKey);
	tools.mac_WriteIndex('TheKeys.Main.ConfigRules.New',BuildConfigRulesKey);
	tools.mac_WriteIndex('TheKeys.Main.DisposableEmailDomains.New',BuildDisposableEmailDomainsKey);
													  
	export full_build :=
		 parallel(
			 BuildEntityProfileKey
			,BuildConfigAttributesKey
			,BuildConfigRulesKey
			,BuildDisposableEmailDomainsKey
		 )
		;
	
	export All :=
			if(tools.fun_IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping Build_Keys atribute')
				);			
end;
