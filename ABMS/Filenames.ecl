IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Address          := tools.mod_FilenamesInput(Template('Address'), pversion);
		EXPORT BIOG             := tools.mod_FilenamesInput(Template('BIOG'), pversion);
		EXPORT Career           := tools.mod_FilenamesInput(Template('Career'), pversion);
		EXPORT Cert             := tools.mod_FilenamesInput(Template('Cert'), pversion);
		EXPORT Contact          := tools.mod_FilenamesInput(Template('Contact'), pversion);
		EXPORT Deceased         := tools.mod_FilenamesInput(Template('Deceased'), pversion);
		EXPORT Education        := tools.mod_FilenamesInput(Template('Education'), pversion);
		EXPORT Membership       := tools.mod_FilenamesInput(Template('Membership'), pversion);
		EXPORT MOCParticipation := tools.mod_FilenamesInput(Template('MOC_Participation'), pversion);
		EXPORT TypeOfPractice   := tools.mod_FilenamesInput(Template('Type_Of_Practice'), pversion);
		EXPORT Schools          := tools.mod_FilenamesInput(Template('Schools'), pversion);
		EXPORT Specialty        := tools.mod_FilenamesInput(Template('Specialty'), pversion);
		
		EXPORT Raw_input				:= tools.mod_FilenamesInput(Template('Raw_Input'), pversion);
		
		EXPORT dAll_filenames := Address.dAll_filenames +
			                       BIOG.dAll_filenames +
			                       // Career.dAll_filenames +
			                       Cert.dAll_filenames +
			                       // Contact.dAll_filenames +
			                       Deceased.dAll_filenames +
			                       Education.dAll_filenames +
			                       // Membership.dAll_filenames +
			                       MOCParticipation.dAll_filenames +
			                       // TypeOfPractice.dAll_filenames +
			                       // Schools.dAll_filenames +
			                       // Specialty.dAll_filenames;
														 Raw_input.dAll_filenames;
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Main           := tools.mod_FilenamesBuild(Template('Main'), pversion);
		EXPORT Career         := tools.mod_FilenamesBuild(Template('Career'), pversion);
		EXPORT Cert           := tools.mod_FilenamesBuild(Template('Cert'), pversion);
		EXPORT Education      := tools.mod_FilenamesBuild(Template('Education'), pversion);
		EXPORT Membership     := tools.mod_FilenamesBuild(Template('Membership'), pversion);
		EXPORT TypeOfPractice := tools.mod_FilenamesBuild(Template('TypeOfPractice'), pversion);
		
		EXPORT dAll_filenames := Main.dAll_filenames +
		                         Career.dAll_filenames +
		                         Cert.dAll_filenames +
		                         Education.dAll_filenames +
		                         Membership.dAll_filenames +
		                         TypeOfPractice.dAll_filenames;
	END;
	
	EXPORT dAll_filenames := Base.dAll_filenames;
  
END;