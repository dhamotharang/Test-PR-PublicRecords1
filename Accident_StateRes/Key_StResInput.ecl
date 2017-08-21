IMPORT Accident_Services,doxie,ut;

EXPORT Key_StResInput := INDEX(File_In_Input_res,
	{ApplicationType},{AccidentState,Bitmap},
	'~thor_data400::key::accident_state_restrictions::input_' + doxie.Version_SuperKey);
	
