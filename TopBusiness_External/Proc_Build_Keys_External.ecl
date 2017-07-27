import doxie, Tools, VersionControl;

export Proc_Build_Keys_External(
	string version) := function

	tools.mac_WriteIndex('Keys(version).Source.New',BuildSourceKey);
	tools.mac_WriteIndex('Keys(version).Address.New',BuildAddressKey);
	tools.mac_WriteIndex('Keys(version).FEIN.New',BuildFEINKey);
	tools.mac_WriteIndex('Keys(version).Phone.New',BuildPhoneKey);
	
	return
		if(tools.fun_IsValidVersion(version),
			sequential(
				 parallel(
					 BuildSourceKey
					,BuildAddressKey
					,BuildFEINKey
					,BuildPhoneKey
							 )
				,Promote(version).KeyFiles.New2Built)
			,output('No Valid version parameter passed, skipping TopBusiness_External.Proc_Build_Keys_External atribute'));

end;
