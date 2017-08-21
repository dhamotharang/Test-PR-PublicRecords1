//Raw professional license files from the AZS0813
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib;

/****************************************************************************************************************
* This function performs the following task                                                                     *
*  - Copy ::sprayed:: to ::using::																																							*
*  - Extract, Load, and Transform																																						    *
*  - Write output to            *
*  - Copy ::using:: to ::used::																																									*
*	 - Clear ::using::																																														*
*****************************************************************************************************************/		
EXPORT files_AZS0813 := MODULE


	SHARED code := 'AZS0813';

	SHARED dirname := Common_Prof_Lic_Mari.SourcesFolder + code + '::';

	export RealEstate_company := dataset(dirname + 'using' + '::' + 'entities', 
																			 Prof_License_Mari.layout_AZS0813.entity,
																			 //csv(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));
																			 csv(SEPARATOR(','),heading(1),quote('"')));
		
	export RealEstate_broker 	:= dataset(dirname + 'using' + '::' + 'individuals', 
																			 Prof_License_Mari.layout_AZS0813.individual,
																			 //csv(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));
																			 csv(SEPARATOR(','),heading(1),quote('"')));
	
END;