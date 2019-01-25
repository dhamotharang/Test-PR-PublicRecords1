IMPORT SALT38, SALTRoutines;

EXPORT SALT_Profile_Run_Everything(RawInputDataset, FileName = '', UIDField = '', SourceField = '') := FUNCTIONMACRO
	myInputDataset := SALTRoutines.MAC_Eliminate_Child_Datasets(RawInputDataset, FileName);
	SALTRoutines.Mac_Flatten(myInputDataset, myFlatInputDataset);
	SALTProfileResults := SALT38.MOD_Profile(myFlatInputDataset, UIDField, SourceField);
	SALTFullProfile := SALTProfileResults.AllProfiles;
	SALTFieldTypes := SALTRoutines.SALT_Profile_Field_Types(SALTFullProfile, 5, 3);

	OUTPUT(CHOOSEN(RawInputDataset, 25), NAMED('Sample_Raw_Input_' + FileName));
	OUTPUT(CHOOSEN(myFlatInputDataset, 25), NAMED('Sample_Flattened_Input_' + FileName));
	OUTPUT(CHOOSEN(SALTFullProfile, 2000), NAMED('Full_Profile_Results_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Poorly_Populated_Fields(SALTFullProfile, 5, 50.0), 2000), NAMED('Poorly_Populated_Fields_' + FileName));
	OUTPUT(CHOOSEN(SALTFieldTypes, 2000), NAMED('Field_Types_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Produce_ENTITY(SALTFieldTypes), 6000), NAMED('Field_Types_ENTITY_' + FileName));
	OUTPUT(CHOOSEN(SALTRoutines.SALT_Profile_Characters(SALTFullProfile, 15), 2000), NAMED('Characters_' + FileName));
	RETURN COUNT(SALTFullProfile);
ENDMACRO;