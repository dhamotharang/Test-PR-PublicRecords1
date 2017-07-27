import tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_builds)	pKeyFilenames		=		Keynames (pversion).dAll_filenames

) :=
module
	
	export keyfiles		:= tools.mod_PromoteBuild(pversion,pKeyFilenames,pFilter,pDelete,pIsTesting);

end;
