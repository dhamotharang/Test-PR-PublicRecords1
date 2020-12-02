import _control, VersionControl;

export _Flags(string pInput_Name='', string pBase_Name='',boolean pUseProd=false)  := module

	export IsTesting								:= IDA._Constants(pUseProd).IsDataland;;
	export UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	export ExistCurrentSprayed			:= fileservices.superfileexists('~thor_data400::in::ida') and 
																		 count(fileservices.superfilecontents('~thor_data400::base::ida::built')) > 0  ;
	export ExistBaseFile						:= count(nothor(fileservices.superfilecontents(IDA.filenames(pBase_name,).base.qa))) > 0;	
	export Update										:= ExistCurrentSprayed and ExistBaseFile;
	export IsUpdateFullFile					:= false;
end;

