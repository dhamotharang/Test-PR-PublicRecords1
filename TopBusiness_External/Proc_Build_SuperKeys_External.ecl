import TopBusiness;

export Proc_Build_SuperKeys_External(
	string version) := function

	return parallel(
		TopBusiness.Function_Update_SuperFiles(KeyNames.Source,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.Address,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.FEIN,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.Phone,version)
		);

end;
