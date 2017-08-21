IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
	
		SHARED Template(STRING tag) 	:= Corp2_Raw_KY._Dataset(pUseOtherEnvironment).InputTemplate + tag;
			
		EXPORT Companies       				:= tools.mod_FilenamesInput(Template('Companies::ky'), pversion);
		EXPORT Officer        			 	:= tools.mod_FilenamesInput(Template('Officer::ky'), pversion);
		EXPORT InitialOfficers 				:= tools.mod_FilenamesInput(Template('InitialOfficers::ky'), pversion);
	
	END;

	EXPORT Base := MODULE
	
		SHARED Template(STRING tag)		:= Corp2_Raw_KY._Dataset(pUseOtherEnvironment).FileTemplate + tag;		
			
		EXPORT Companies							:= tools.mod_FilenamesBuild(Template('Companies::ky'), pversion);	
		EXPORT Officer								:= tools.mod_FilenamesBuild(Template('Officer::ky'), pversion);
		EXPORT InitialOfficers				:= tools.mod_FilenamesBuild(Template('InitialOfficers::ky'), pversion);

		EXPORT dAll_Companies					:= Companies.dAll_filenames;
		EXPORT dAll_Officer 		 			:= Officer.dAll_filenames;
		EXPORT dAll_InitialOfficers		:= InitialOfficers.dAll_filenames;

	END;
	
	EXPORT dAll_filenames 		 := Base.dAll_Companies	 + Base.dAll_Officer	+ Base.dAll_InitialOfficers;
	
END;