IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ut._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Busentity         		:= tools.mod_FilenamesInput(Template('Busentity::ut'), pversion);
		EXPORT Principals         	:= tools.mod_FilenamesInput(Template('Principals::ut'), pversion);		
		EXPORT Businfo         			:= tools.mod_FilenamesInput(Template('Businfo::ut'), pversion);	
		
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag) := Corp2_Raw_ut._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Busentity         	:= tools.mod_FilenamesBuild(Template('Busentity::ut'), pversion);	
		EXPORT Principals    			:= tools.mod_FilenamesBuild(Template('Principals::ut'), pversion);
		EXPORT Businfo         		:= tools.mod_FilenamesBuild(Template('Businfo::ut'), pversion);
		
		EXPORT dAll_Busentity			:= Busentity.dAll_filenames;
		EXPORT dAll_Principals 		:= Principals.dAll_filenames;
		EXPORT dAll_Businfo 			:= Businfo.dAll_filenames;
		
	END;
	
	EXPORT dAll_filenames 				:= Base.dAll_Busentity		  +
																	 Base.dAll_Principals 		+
																	 Base.dAll_Businfo		 		;
	
END;