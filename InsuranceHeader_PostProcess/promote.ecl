import ut,tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	true
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pBuildFilenames =   Keynames  (pversion).dAll_filenames

) :=
module
	
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting,2);
	
 end;
