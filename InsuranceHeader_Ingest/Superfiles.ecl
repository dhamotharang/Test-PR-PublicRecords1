IMPORT InsuranceHeader;
EXPORT Superfiles := MODULE
	
	EXPORT createSuperFiles() := FUNCTION
		superFiles := SEQUENTIAL(
											
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.Base_Archive_SF),
												
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.AsHeaderAll_SF),

												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsIngest_SF),
												
												InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.Bocablankrid_SF),
												

											);	
		RETURN superFiles;
	END;
	/*-------------------- updateSuperFiles ----------------------------------------------------*/
	// keep 3 versions- remove older automatically
	EXPORT updateSF(newLogicalFile, nameMaker) := FUNCTIONMACRO
		IMPORT InsuranceHeader;
	
		RETURN InsuranceHeader.mod_Superfiles.mac_updateSuperFiles(newLogicalFile, nameMaker);
		
	ENDMACRO;
	
END;
