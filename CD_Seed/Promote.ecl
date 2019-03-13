import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 string								pversion				= 	''
	,boolean							pUseProd			= 	false
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pisTesting			= 	false	
) :=
module

    export Promote_Seed_AsSrc := module
       dataset(lay_builds) pBuildFilenames := Filenames(pversion,pUseProd).Base_AsSrc.dAll_filenames;
       export buildfiles := tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting);
    end;
	
end;
