IMPORT tools;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := _Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT Accident          	:= tools.mod_FilenamesInput(Template('Accident'), pversion);
		EXPORT AccidentAbstract		:= tools.mod_FilenamesInput(Template('AccidentAbstract'), pversion);
		EXPORT AccidentInjury			:= tools.mod_FilenamesInput(Template('AccidentInjury'), pversion);
		EXPORT Inspection					:= tools.mod_FilenamesInput(Template('Inspection'), pversion);
		EXPORT OptionalInfo				:= tools.mod_FilenamesInput(Template('OptionalInfo'), pversion);
		EXPORT RelatedActivity		:= tools.mod_FilenamesInput(Template('RelatedActivity'), pversion);
		EXPORT StrategicCodes			:= tools.mod_FilenamesInput(Template('StrategicCodes'), pversion);
		EXPORT Violation					:= tools.mod_FilenamesInput(Template('Violation'), pversion);
		EXPORT GenDutyStd 				:= tools.mod_FilenamesInput(Template('GenDutyStd'), pversion);
		EXPORT ViolationEvent   	:= tools.mod_FilenamesInput(Template('ViolationEvent'), pversion);
		
		EXPORT dAll_filenames := Accident.dAll_filenames +
			                       AccidentAbstract.dAll_filenames +
			                       AccidentInjury.dAll_filenames +
			                       Inspection.dAll_filenames +
			                       OptionalInfo.dAll_filenames +
			                       RelatedActivity.dAll_filenames +
			                       StrategicCodes.dAll_filenames +
			                       Violation.dAll_filenames +
			                       GenDutyStd.dAll_filenames +
			                       ViolationEvent.dAll_filenames;
	END;
END;