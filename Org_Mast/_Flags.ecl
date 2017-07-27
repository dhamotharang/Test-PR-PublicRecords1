IMPORT _control, VersionControl;

EXPORT _Flags(string pInput_Name='', string pBase_Name='')  := module
	EXPORT IsTesting								:= VersionControl._Flags.IsDataland;
	EXPORT UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	// EXPORT ExistCurrentSprayed			:= fileservices.superfileexists(filenames(pInput_Name,).lInputTemplate) and 
																		 // count(fileservices.superfilecontents(filenames(pInput_Name,).lInputTemplate  )) > 0  ;
	// EXPORT ExistBaseFile						:= count(nothor(fileservices.superfilecontents(filenames(pBase_name,).base.qa))) > 0;	
	// EXPORT Update										:= ExistCurrentSprayed and ExistBaseFile;
	EXPORT IsUpdateFullFile					:= false;
END;

