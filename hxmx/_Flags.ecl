IMPORT _control, VersionControl;

EXPORT _Flags(STRING pInput_Name='', STRING pBase_Name='')  := MODULE
	EXPORT IsTesting								:= VersionControl._Flags.IsDataland;
	EXPORT UseStandardizePersists		:= NOT IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	// EXPORT ExistCurrentSprayed			:= fileservices.superfileexists(filenames(pInput_Name,).lInputTemplate) and 
																		 // count(fileservices.superfilecontents(filenames(pInput_Name,).lInputTemplate  )) > 0  ;
	// EXPORT ExistBaseFile						:= count(nothor(fileservices.superfilecontents(filenames(pBase_name,).base.qa))) > 0;	
	// EXPORT Update										:= ExistCurrentSprayed and ExistBaseFile;
	EXPORT IsUpdateFullFile					:= FALSE;
END;

