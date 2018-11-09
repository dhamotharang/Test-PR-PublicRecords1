import tools;

lay_inputs	:= tools.Layout_FilenameVersions.Inputs;
lay_builds 	:= tools.Layout_FilenameVersions.builds;

export Promote(string								pversion				= 	''
							 ,string							pFilter					= 	''
							 ,boolean							pDelete					= 	false
							 ,boolean							pIsTesting			= 	false
							 ,dataset(lay_inputs)	pInputFilenames = 	Filenames	(pversion).dAll_input_Filenames
							 ,dataset(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_Base_Filenames
							 ):= Module
	
	export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

end;

