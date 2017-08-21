import VersionControl;

export _Flags :=
module

	export IsTesting 				:= VersionControl._Flags.IsDataland	;
	export ShouldFilter 		:= true															;
	export StartFromScratch	:= false														;
	export ExistBaseFile		:= count(nothor(fileservices.superfilecontents(filenames().base.qa			))) > 0;

end;