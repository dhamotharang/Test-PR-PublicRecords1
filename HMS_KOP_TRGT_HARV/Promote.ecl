IMPORT tools, hms_kop_trgt_harv;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
EXPORT promote := MODULE	
	
	EXPORT Promote_koptrgtharv(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = //hms_kop_trgt_harv.Filenames(pversion,pUseProd).koptrgtharv_Base.dAll_filenames
																							// + HMS_STLIC.keynames	(pversion,pUseProd).dAll_filenames
																							 hms_kop_trgt_harv.keynames	(pversion,pUseProd).koptrgtharv_lnpid_key.dAll_filenames
																						
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
END;
