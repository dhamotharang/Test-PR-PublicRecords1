import TopBusiness_Search as TBS,TopBusiness_External as TBE;

export Proc_Build_SuperKeys(string version) := function

	return parallel(
		TBE.Proc_Build_SuperKeys_External(version),
		TBS.Build_SuperKeys(version),
		Function_Update_SuperFiles(KeyNames.LinkDiagnostic,version),
		Function_Update_SuperFiles(KeyNames.MatchDiagnostic,version),
		Function_Update_SuperFiles(KeyNames.Source,version),
		Function_Update_SuperFiles(KeyNames.AddressesPhones,version),
		Function_Update_SuperFiles(KeyNames.Aircraft.Main,version),
		Function_Update_SuperFiles(KeyNames.Aircraft.Party,version),
		Function_Update_SuperFiles(KeyNames.Bankruptcy.Main,version),
		Function_Update_SuperFiles(KeyNames.Bankruptcy.Party,version),
		Function_Update_SuperFiles(KeyNames.Contacts,version),
		Function_Update_SuperFiles(KeyNames.Finance,version),
		Function_Update_SuperFiles(KeyNames.Incorporation,version),
		Function_Update_SuperFiles(KeyNames.Industry,version),
		Function_Update_SuperFiles(KeyNames.License,version),
		Function_Update_SuperFiles(KeyNames.Liens.Main,version),
		Function_Update_SuperFiles(KeyNames.Liens.Party,version),
		Function_Update_SuperFiles(KeyNames.LLID,version),
		Function_Update_SuperFiles(KeyNames.MotorVehicle.Main,version),
		Function_Update_SuperFiles(KeyNames.MotorVehicle.Registration,version),
		Function_Update_SuperFiles(KeyNames.MotorVehicle.Title,version),
		Function_Update_SuperFiles(KeyNames.MotorVehicle.Party,version),
		Function_Update_SuperFiles(KeyNames.NamesFEINs,version),
		Function_Update_SuperFiles(KeyNames.Relationship,version),
		Function_Update_SuperFiles(KeyNames.TradeLines,version),
		Function_Update_SuperFiles(KeyNames.UCC.Main,version),
		Function_Update_SuperFiles(KeyNames.UCC.Party,version),
		Function_Update_SuperFiles(KeyNames.UCC.Collateral,version),
		Function_Update_SuperFiles(KeyNames.URLs,version),
		Function_Update_SuperFiles(KeyNames.Watercraft.Main,version),
		Function_Update_SuperFiles(KeyNames.Watercraft.Party,version),
		Function_Update_SuperFiles(KeyNames.Property.Main,version),
		Function_Update_SuperFiles(KeyNames.Property.Party,version),
		Function_Update_SuperFiles(KeyNames.Property.Assessment,version),
		Function_Update_SuperFiles(KeyNames.Property.Deed,version),
		Function_Update_SuperFiles(KeyNames.Property.Foreclosure,version),
		Function_Update_SuperFiles(KeyNames.Abstract,version)
		);

end;
