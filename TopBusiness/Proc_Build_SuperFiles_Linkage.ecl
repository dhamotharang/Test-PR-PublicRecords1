import TopBusiness_External;

export Proc_Build_SuperFiles_Linkage(
	string version) := function

	return parallel(
		TopBusiness_External.Proc_Build_SuperFiles_External(version),
		Function_Update_SuperFiles(Filenames.Match.Linked,version),
		Function_Update_SuperFiles(Filenames.Linking.Linked,version)
		);

end;
