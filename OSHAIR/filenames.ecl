IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		EXPORT Accident          		:= tools.mod_FilenamesInput(Template('Accident'), pversion);
		EXPORT AccidentAbstract			:= tools.mod_FilenamesInput(Template('AccidentAbstract'), pversion);
		EXPORT AccidentInjury				:= tools.mod_FilenamesInput(Template('AccidentInjury'), pversion);
		EXPORT Inspection						:= tools.mod_FilenamesInput(Template('Inspection'), pversion);
		EXPORT OptionalInfo					:= tools.mod_FilenamesInput(Template('OptionalInfo'), pversion);
		EXPORT RelatedActivity			:= tools.mod_FilenamesInput(Template('RelatedActivity'), pversion);
		EXPORT StrategicCodes				:= tools.mod_FilenamesInput(Template('StrategicCodes'), pversion);
		EXPORT Violation						:= tools.mod_FilenamesInput(Template('Violation'), pversion);
		EXPORT GenDutyStd 					:= tools.mod_FilenamesInput(Template('GenDutyStd'), pversion);
		EXPORT ViolationEvent   		:= tools.mod_FilenamesInput(Template('ViolationEvent'), pversion);

	END;
	
	EXPORT dAll_Input_Filenames 			:= input.Accident.dAll_filenames +
																			 input.AccidentAbstract.dAll_filenames +
																			 input.AccidentInjury.dAll_filenames +
																			 input.Inspection.dAll_filenames +
																			 input.OptionalInfo.dAll_filenames +
																			 input.RelatedActivity.dAll_filenames +
																			 input.StrategicCodes.dAll_filenames +
																			 input.Violation.dAll_filenames +
																			 input.GenDutyStd.dAll_filenames 		+
																			 input.ViolationEvent.dAll_filenames;

	
	EXPORT Base := MODULE
	
		SHARED Template(STRING tag)  := _Dataset(pUseOtherEnvironment).FileTemplate+ tag;
		EXPORT Accident   					 := tools.mod_FilenamesBuild(Template('Accident'), pversion);
		EXPORT hazardous  					 := tools.mod_FilenamesBuild(Template('Hazardous_Substance'), pversion);
		EXPORT Inspection 					 := tools.mod_FilenamesBuild(Template('Inspection'), pversion);
		EXPORT OptionalInfo   			 := tools.mod_FilenamesBuild(Template('Optional_Info'), pversion);
		EXPORT program  						 := tools.mod_FilenamesBuild(Template('Program'), pversion);
		EXPORT related_activity 		 := tools.mod_FilenamesBuild(Template('Related_Activity'), pversion);
		EXPORT violations			  		 := tools.mod_FilenamesBuild(Template('Violations'), pversion);

		EXPORT dAll_Accident  	     := Accident.dAll_filenames;
		EXPORT dAll_hazardous 	     := hazardous.dAll_filenames;
		EXPORT dAll_Inspection 	     := Inspection.dAll_filenames;
		EXPORT dAll_OptionalInfo  	 := OptionalInfo.dAll_filenames;
		EXPORT dAll_program 				 := program.dAll_filenames;
		EXPORT dAll_related_activity := related_activity.dAll_filenames;
		EXPORT dAll_violations			 := violations.dAll_filenames;
	
	
	END;

	EXPORT dAll_Base_Filenames 			 := base.dAll_Accident   				+
																			base.dAll_hazardous  				+
																			base.dAll_Inspection 				+
																			base.dAll_OptionalInfo   		+
																			base.dAll_program   				+
																			base.dAll_related_activity	+
																			base.dAll_violations  			;
													 
END;		