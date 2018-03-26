IMPORT ut, RoxieKeyBuild;

EXPORT Proc_Spray_And_Build(fileVersion = ut.GetDate) := FUNCTION
	
	
	sprayEngine := Fn_SprayFile(Files.engine, Files.FILE_SPRAY(Files.engine));
	sprayMaster := Fn_SprayFile(Files.master, Files.FILE_SPRAY(Files.master));
	sprayAcft 	:= Fn_SprayFile(Files.acft, Files.FILE_SPRAY(Files.acft));

	// sprayFiles := PARALLEL(sprayEngine, sprayMaster, sprayAcft);
		

		// This macro is what builds the super files with generations: QA, Father, Grandfater
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_ENGINE_DS,
																				 Files.BASE_PREFIX_NAME, 
																				 Files.Engine_NAME,
																				 fileVersion, buildEngine, 3,
																				 false,true);
	
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_MASTER_DS,
																				 Files.BASE_PREFIX_NAME, 
																				 Files.Master_NAME,
																				 fileVersion, buildMaster, 3,
																				 false,true);

		RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_ACFT_DS,
																				 Files.BASE_PREFIX_NAME, 
																				 Files.Acft_NAME,
																				 fileVersion, buildAcft, 3,
																				 false,true);


		deleteSprayedFile := PARALLEL(FileServices.DeleteLogicalFile(Files.FILE_SPRAY(Files.engine)),
																	FileServices.DeleteLogicalFile(Files.FILE_SPRAY(Files.master)),
																	FileServices.DeleteLogicalFile(Files.FILE_SPRAY(Files.acft)));
	
	
		RETURN SEQUENTIAL( PARALLEL(sprayEngine, sprayMaster, sprayAcft), 
												PARALLEL(buildEngine, buildMaster, buildAcft), 
												deleteSprayedFile);
END;