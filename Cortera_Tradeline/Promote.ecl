import $, dx_Cortera_Tradeline, tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	true
	,boolean							pIsTesting			= 	false
	,boolean							pClearSFile			=		true
	,boolean							pIsDeltaBuild		=		false
	,dataset(lay_inputs)	pInputFilenames = 	$.Filenames	(pversion).Input.dAll_filenames
	,dataset(lay_builds)	pBuildFilenames = 	$.Filenames	(pversion).Base.dAll_filenames
																					+ dx_Cortera_Tradeline.keynames	(pversion).dAll_filenames

) :=
module
	
	export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting,,pClearSFile,,,,,pIsDeltaBuild);	

end;
