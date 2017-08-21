IMPORT tools, HMS_CSR;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
EXPORT promote := MODULE	
	
	EXPORT Promote_csrcredential(
			string								pversion				= 	''
			,boolean							pUseProd			= 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,dataset(lay_builds)	pBuildFilenames = 	HMS_CSR.Filenames(pversion,pUseProd).csrcredential_Base.dAll_filenames
																							//+ HMS_CSR.keynames	(pversion,pUseProd).dAll_filenames
		) := MODULE
				EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pisTesting,pnGenerations := 2);
			
	END;
	
END;
