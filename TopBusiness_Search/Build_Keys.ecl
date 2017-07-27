import doxie, Tools, VersionControl, TopBusiness;

export Build_Keys(
	string version) := function

	tools.mac_WriteIndex('Keys(version).Address.New',BuildAddressKey);
	tools.mac_WriteIndex('Keys(version).CompanyName.New',BuildCompanyNameKey);
	tools.mac_WriteIndex('Keys(version).FEIN.New',BuildFEINKey);
	tools.mac_WriteIndex('Keys(version).LLID9.New',BuildLLID9Key);
	tools.mac_WriteIndex('Keys(version).LLID12.New',BuildLLID12Key);
	tools.mac_WriteIndex('Keys(version).PhoneNumber.New',BuildPhoneNumberKey);
	tools.mac_WriteIndex('Keys(version).URL.New',BuildURLKey);
	
	return
		if(tools.fun_IsValidVersion(version),
			sequential(
				 parallel(
					 BuildAddressKey
					,BuildCompanyNameKey
					,BuildFEINKey
					,BuildLLID9Key
					,BuildLLID12Key
					,BuildPhoneNumberKey
					,BuildURLKey
							 )
				,Promote(version).KeyFiles.New2Built)
			,output('No Valid version parameter passed, skipping TopBusiness_Search.Build_Keys atribute'));

end;
