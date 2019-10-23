// Manage superfiles related to incremental build
IMPORT InsuranceHeader;
EXPORT Superfiles := MODULE
	
	EXPORT createSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
		                    // Suppression Correction 
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.IncSuppression_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.IncCorrection_SF),
												
												// incremental additions base
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.IncBase_SF),
												
												// incremental additions archive
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.IncBase_Archive_SF),
												
												// internal linking input file
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.SALT_Input_SF),
												
												// internal linking output file
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.SALT_Output_SF),
												
												// built as header, all data
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.AsHeaderAll_SF),
												
												// built as header, new data only (to feed to internal linking)
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.AsHeaderNewOnly_SF),
												
												// incremental raw Boca header
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.RawAsHeader_Boca_SF),
												
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.IncBaseAll_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.AsHeader_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.AsHeaderExisting_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.Inchierarchy_SF), 
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.BEST_SF), 
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.FCRA_SF), 
												
												// stats
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsIngest_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsNewOnly_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsILink_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsIncBase_SF),
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.BuildDate_SF)
												
											);	
		RETURN superFiles;
	END;
	/*-------------------- updateSuperFiles ----------------------------------------------------*/
	// keep 3 versions- remove older automatically
	EXPORT updateSF(newLogicalFile, nameMaker) := FUNCTIONMACRO
		IMPORT InsuranceHeader;
	
		RETURN InsuranceHeader.mod_Superfiles.mac_updateSuperFiles(newLogicalFile, nameMaker);
		
	ENDMACRO;
	
	EXPORT AddSuper(STRING superfile, STRING logical) := FUNCTION
	
	RETURN STD.File.AddSuperfile(superfile, logical); 
	
	END; 
	
END;
