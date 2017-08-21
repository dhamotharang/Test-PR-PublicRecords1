import _control, lib_fileservices, VersionControl;

export _Flags(string pname = '') := module
	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := IsTesting;
	
	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(prte_csv.filenames(pname).input.using		))) > 0;
	export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(prte_csv.filenames(pname).base.qa				))) > 0;

	export Update 								:= ExistCurrentSprayed and ExistBaseFile;

	export IsUpdateFullFile				:= true;
	
	export ShouldFilter						:= true;
end;