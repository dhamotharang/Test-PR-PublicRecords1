import TopBusiness;

export Build_SuperKeys(string version) := function

	return parallel(
		TopBusiness.Function_Update_SuperFiles(KeyNames.Address,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.CompanyName,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.FEIN,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.LLID9,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.LLID12,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.PhoneNumber,version),
		TopBusiness.Function_Update_SuperFiles(KeyNames.URL,version));

end;
