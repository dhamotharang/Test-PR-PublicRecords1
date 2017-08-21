import _control, lib_fileservices, VersionControl;

EXPORT Flags(string pname = '') := module
	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := IsTesting;
	
	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(prte2.filenames(pname).input.root 	))) = 1;
	// export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(prte2.filenames(pname).base.qa				))) > 0;

end;