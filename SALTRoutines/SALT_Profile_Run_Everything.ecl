IMPORT SALT35, SALTRoutines;

EXPORT SALT_Profile_Run_Everything(RawInputDataset, FileName = '') := FUNCTIONMACRO
	SALTRoutines.Mac_Flatten(RawInputDataset, inputDataset); 
	SaltProfileResults := SALTRoutines.mac_profile(inputDataset);
	SALTFieldTypes := SALTRoutines.SALT_Profile_Field_Types(SaltProfileResults, 5, 3);

	OUTPUT(CHOOSEN(RawInputDataset, 25), NAMED('Sample_Raw_Input_' + FileName));
	OUTPUT(CHOOSEN(inputDataset, 25), NAMED('Sample_Flattened_Input_' + FileName));
	OUTPUT(CHOOSEN(SaltProfileResults, 2000), NAMED('Full_Profile_Results_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Poorly_Populated_Fields(SaltProfileResults, 5, 50.0), 2000), NAMED('Poorly_Populated_Fields_' + FileName));
	OUTPUT(CHOOSEN(SALTFieldTypes, 2000), NAMED('Field_Types_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Produce_ENTITY(SALTFieldTypes), 6000), NAMED('Field_Types_ENTITY_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Characters(SaltProfileResults, 15), 2000), NAMED('Characters_' + FileName));
	RETURN COUNT(SaltProfileResults);
ENDMACRO;