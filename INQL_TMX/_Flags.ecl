import _control, VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='') := 
module

	export IsTesting								:= VersionControl._Flags.IsDataland;
	export UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	export ExistCurrentSprayed			:= fileservices.superfileexists(filenames(pInput_Name,).lInputTemplate) and 
																		 count(fileservices.superfilecontents(filenames(pInput_Name,).lInputTemplate  )) > 0  ;
	export ExistBaseFile						:= count(nothor(fileservices.superfilecontents(filenames(pBase_name,).base.qa))) > 0;	
	export Update										:= ExistCurrentSprayed and ExistBaseFile;
	export IsUpdateFullFile					:= false;

end;
