import tools, TopBusiness;

export KeyNames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset, string pStatus = '')	:=
		tools.mod_FilenamesBuild(TopBusiness._Dataset().thor_cluster_files + pFiletype + '::' + TopBusiness._Dataset().name + '::' + pCategory + '::@version@::' + pSubset + if(pStatus = '','','::' + pStatus),lversiondate);

	export Source := ftemplate('key','external','source');
	export Address := ftemplate('key','external','address');
	export FEIN := ftemplate('key','external','fein');
	export Phone := ftemplate('key','external','phone');

	export dAll_filenames := 
		Source.dAll_filenames +
		Address.dAll_filenames +
		FEIN.dAll_filenames +
		Phone.dAll_filenames;

end;
