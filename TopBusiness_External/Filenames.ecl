import business_header, tools, TopBusiness;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset, string pStatus = '')	:=
		tools.mod_FilenamesBuild(TopBusiness._Dataset().thor_cluster_files + pFiletype + '::' + TopBusiness._Dataset().name + '::' + pCategory + '::@version@::' + pSubset + if(pStatus = '','','::' + pStatus),lversiondate);

	export Source := ftemplate('base','external','source');
	export Address := ftemplate('base','external','address');
	export FEIN := ftemplate('base','external','fein');
	export Phone := ftemplate('base','external','phone');

	export dAll_filenames := 
		Source.dAll_filenames +
		Address.dAll_filenames +
		FEIN.dAll_filenames +
		Phone.dAll_filenames;

end;
