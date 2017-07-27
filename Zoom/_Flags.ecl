import _control, VersionControl;

export _Flags :=
module

	export IsTesting 							:= VersionControl._Flags.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored
	
	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.using		))) > 0;
	export ExistCurrentXMLSprayed	:= count(nothor(fileservices.superfilecontents(filenames().inputXML.using	))) > 0;
	export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.qa				))) > 0;

	export Update 								:= ExistCurrentSprayed and ExistBaseFile;

	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this
	
	export ShouldFilter						:= true;

end;