import TopBusiness;

export Proc_Build_SuperFiles_External(
	string version) := function

	return parallel(
		TopBusiness.Function_Update_SuperFiles(Filenames.Source,version),
		TopBusiness.Function_Update_SuperFiles(Filenames.Address,version),
		TopBusiness.Function_Update_SuperFiles(Filenames.FEIN,version),
		TopBusiness.Function_Update_SuperFiles(Filenames.Phone,version)
		);

end;
