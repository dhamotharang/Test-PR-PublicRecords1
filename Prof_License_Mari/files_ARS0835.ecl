//Raw professional license files from the ARS0835
IMPORT ut
	   ,_control
     ,Prof_License_Mari
	   ,Lib_FileServices;

/****************************************************************************************************************
* This function performs the following task                                                                     *
*  - Copy ::sprayed:: to ::using::																																							*
*  - Extract, Load, and Transform																																						    *
*  - Write output to            *
*  - Copy ::using:: to ::used::																																									*
*	 - Clear ::using::																																														*
*****************************************************************************************************************/		
EXPORT files_ARS0835 := MODULE

	SHARED code := 'ARS0835';

	SHARED dirname := Common_Prof_Lic_Mari.SourcesFolder + code + '::';

	EXPORT active :=
		dataset(dirname + 'using' + '::' + 'active', 
						Prof_License_Mari.layout_ARS0835.common,
						csv(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

		
	EXPORT inactive := 
		dataset(dirname + 'using' + '::' + 'inactive', 
						Prof_License_Mari.layout_ARS0835.common,
						CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	

END;