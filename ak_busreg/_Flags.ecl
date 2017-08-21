import _control, VersionControl;
export _Flags :=
module
   export IsTesting                    := VersionControl._Flags.IsDataland;
   
   export UseStandardizePersists := not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
   
   export ExistCurrentSprayed    := fileservices.superfileexists(filenames().input.using) and count(fileservices.superfilecontents(filenames().input.using  )) > 0;
   export ExistBaseFile             := count(nothor(fileservices.superfilecontents(filenames().base.qa         ))) > 0;
   export Update                       := ExistCurrentSprayed and ExistBaseFile;
	 export IsUpdateFullFile				:= false;
end;
