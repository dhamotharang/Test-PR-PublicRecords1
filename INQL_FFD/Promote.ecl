import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 boolean       				pDaily      		=  true
	,boolean       				pFCRA       		=  true
	,string								pVersion				= 	''
	,boolean							pUseProd			 	= 	false
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pisTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	Filenames(pDaily, pFCRA, pversion).base.dAll_filenames
																																							+ keynames	(pFCRA, pversion).dAll_filenames
	) 
:=
module
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting);
	
end;