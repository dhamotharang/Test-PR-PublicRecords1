import doxie, Tools, VersionControl, TopBusiness_External, TopBusiness_Search;

export Proc_Build_Daily_Keys(
	string version) := function

	tools.mac_WriteIndex('KeysDaily(version).Bankruptcy.Main.New',BuildBankruptcyMainKey);
	tools.mac_WriteIndex('KeysDaily(version).Bankruptcy.Party.New',BuildBankruptcyPartyKey);
	tools.mac_WriteIndex('KeysDaily(version).Source.New',BuildSourceKey);
	
	return
		if(tools.fun_IsValidVersion(version),
			sequential(
				 // TopBusiness_External.Proc_Build_Keys_External(version)
				// ,TopBusiness_Search.Build_Keys(version)
				 parallel(
					 BuildBankruptcyMainKey
					,BuildBankruptcyPartyKey
					,BuildSourceKey
							 )
				,PromoteDaily(version).KeyFiles.New2Built)
			,output('No Valid version parameter passed, skipping TopBusiness.Proc_Build_Daily_Keys atribute'));

end;
