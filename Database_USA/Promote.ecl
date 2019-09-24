IMPORT tools, dx_Database_USA;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(
	 STRING								pversion				= 	''
	,STRING								pFilter					= 	''
	,BOOLEAN							pDelete					= 	FALSE
	,BOOLEAN							pIsTesting			= 	FALSE
	,DATASET(lay_inputs)	pInputFilenames = 	Filenames	(pversion).Input.dAll_filenames 
	,DATASET(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_filenames
																						+ dx_Database_USA.names(pversion).dAll_filenames
																						
) := MODULE
	
	EXPORT inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

END;