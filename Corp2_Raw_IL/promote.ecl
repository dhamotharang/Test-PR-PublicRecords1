IMPORT tools;

lay_builds := tools.Layout_FilenameVersions.builds;
lay_inputs := tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(STRING							 pversion				 = '',
							 BOOLEAN						 pUseProd				 = FALSE,
	             STRING							 pFilter				 = '',
	             BOOLEAN						 pDelete				 = FALSE,
	             BOOLEAN						 pIsTesting			 = FALSE) := MODULE

	EXPORT Daily := MODULE
		SHARED pBuildFilenames 	:= Corp2_Raw_IL.Filenames(pversion,pUseProd).dAll_filenames_daily;
		EXPORT buildfiles				:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);
	END;
	
	EXPORT Monthly := MODULE
		SHARED pBuildFilenames 	:= Corp2_Raw_IL.Filenames(pversion,pUseProd).dAll_filenames_monthly;
		EXPORT buildfiles				:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);
	END;
	
	EXPORT LLC := MODULE
		SHARED pBuildFilenames 	:= Corp2_Raw_IL.Filenames(pversion,pUseProd).dAll_filenames_llc;
		EXPORT buildfiles				:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);
	END;
	
	EXPORT LP := MODULE
		SHARED pBuildFilenames 	:= Corp2_Raw_IL.Filenames(pversion,pUseProd).dAll_filenames_lp;
		EXPORT buildfiles				:= tools.mod_PromoteBuild(pversion, pBuildFilenames, pFilter, pDelete, pIsTesting);
	END;
	
END;