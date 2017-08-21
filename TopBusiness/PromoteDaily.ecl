import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export PromoteDaily(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	FilenamesDaily	(pversion).dAll_filenames
	,dataset(lay_builds)	pKeyFilenames		=		keynamesDaily	(pversion).dAll_filenames

) :=
module
	
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
	export keyfiles		:= tools.mod_PromoteBuild(pversion,pKeyFilenames,pFilter,pDelete,pIsTesting);

end;
