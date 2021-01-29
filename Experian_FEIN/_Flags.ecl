import VersionControl;

export _Flags :=
module

	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := IsTesting;	// for bug 26170 -- Missing dependency from persist to stored
	
	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.using		))) > 0;
	export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.qa				))) > 0;

	export Update 								:= ExistCurrentSprayed and ExistBaseFile;

end;
