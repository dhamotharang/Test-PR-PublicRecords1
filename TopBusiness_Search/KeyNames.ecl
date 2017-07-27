import tools, TopBusiness;

export KeyNames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset, string pStatus = '')	:=
		tools.mod_FilenamesBuild(TopBusiness._Dataset().thor_cluster_files + pFiletype + '::' + TopBusiness._Dataset().name + '::' + pCategory + '::@version@::' + pSubset + if(pStatus = '','','::' + pStatus),lversiondate);

	export Address := ftemplate('key','search','address');
	export CompanyName := ftemplate('key','search','companyname');
	export FEIN := ftemplate('key','search','fein');
	export LLID9 := ftemplate('key','search','llid9');
	export LLID12 := ftemplate('key','search','llid12');
	export PhoneNumber := ftemplate('key','search','phone');
	export URL := ftemplate('key','search','url');

	export dAll_filenames := 
		Address.dAll_filenames +
		CompanyName.dAll_filenames +
		FEIN.dAll_filenames +
		LLID9.dAll_filenames +
		LLID12.dAll_filenames +
		PhoneNumber.dAll_filenames +
		URL.dAll_filenames;

end;
