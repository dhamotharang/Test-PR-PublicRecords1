IMPORT tools, HMS_STLIC;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
EXPORT promote := MODULE	
	
	EXPORT Promote_statelicense(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = HMS_STLIC.Filenames(pversion,pUseProd).statelicense_Base.dAll_filenames
																							// + HMS_STLIC.keynames	(pversion,pUseProd).dAll_filenames
																							+ HMS_STLIC.keynames	(pversion,pUseProd).statelicense_lnpid_key.dAll_filenames //statelicense_lnpid_dAll_filenames
																							// + HMS_STLIC.keynames	(pversion,pUseProd).statelicense_lnk_key.dAll_filenames
																							// + HMS_STLIC.keynames	(pversion,pUseProd).statelicense_sourcerid_key.dAll_filenames
																							// + HMS_STLIC.keynames	(pversion,pUseProd).stlicrollup_lnpid_key.dAll_filenames
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
	EXPORT Promote_stlicrollup(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = HMS_STLIC.Filenames(pversion,pUseProd).stlicrollup_Base.dAll_filenames
																							+ HMS_STLIC.keynames	(pversion,pUseProd).stlicrollup_sourcerid_key.dAll_filenames
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
END;
