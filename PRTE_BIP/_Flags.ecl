import _control, lib_fileservices, VersionControl;

export _Flags(string pname = ''
						 ,string bname = 'business_header'
						 ) := module
						 
	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := IsTesting;
	
	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(prte_bip.filenames(pname).input.using		))) > 0;
	export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(prte_bip.filenames(bname).base.qa				))) > 0;

	export Update 								:= ExistCurrentSprayed and ExistBaseFile;

	export IsUpdateFullFile				:= true;
	
	export ShouldFilter						:= true;
end;