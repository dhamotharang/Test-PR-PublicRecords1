IMPORT tools, corp2_raw_nv;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NV._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Corporation         	:= tools.mod_FilenamesInput(Template('corporation::nv'), pversion);
		EXPORT RA         					:= tools.mod_FilenamesInput(Template('ra::nv'), pversion);		
		EXPORT Officers         		:= tools.mod_FilenamesInput(Template('officers::nv'), pversion);		
		EXPORT Actions         			:= tools.mod_FilenamesInput(Template('actions::nv'), pversion);		
		EXPORT Stock         				:= tools.mod_FilenamesInput(Template('stocks::nv'), pversion);	
		EXPORT TM            				:= tools.mod_FilenamesInput(Template('tm::nv'), pversion);	
		EXPORT TMActions     				:= tools.mod_FilenamesInput(Template('tmactions::nv'), pversion);	
	END;

END;