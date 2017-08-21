import prte_csv, tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;
lay_slim		:= tools.Layout_FilenameVersions.Inputs;

export Promote(
	 string								pname						= 	''
	,string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_inputs)	pInputFilenames = 	prte_csv.Filenames	(pname,pversion).Input.dAll_filenames
	,dataset(lay_slim)		pSlimFilenames 	= 	prte_bip.Filenames	(pname,pversion).Input.dAll_filenames
	,dataset(lay_builds)	pBuildFilenames = 	prte_bip.Filenames	(pname,pversion).Base.dAll_filenames

) :=
module
	
	export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export slimfiles	:= tools.mod_PromoteInput(pversion,pSlimFilenames,pFilter,pDelete,pIsTesting);	
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

end;