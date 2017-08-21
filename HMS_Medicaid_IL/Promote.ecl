import tools, HMS_Medicaid_Common;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 string								pversion				= 	''
	,boolean							pUseProd			= 	false
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pisTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames = 	HMS_Medicaid_Common.FileNames('IL',pversion,pUseProd).base.dAll_filenames
																					//+ keynames	(pversion,pUseProd).dAll_filenames
) :=
module
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting);
	
end;