import tools;

export _Flags :=
module
		export UseStandardizePersists 	:= not _Constants().IsTesting;
		export ExistCurrentCCSprayed  	:= Exists(nothor(fileservices.superfilecontents(filenames().inputCC.using		)));
		export ExistCurrentRSIHSprayed	:= Exists(nothor(fileservices.superfilecontents(filenames().inputRSIH.using		)));
		export ExistBaseFile						:= Exists(nothor(fileservices.superfilecontents(filenames().base.qa				)));
		export IsUpdateFullFile					:= true;
		export ShouldFilter							:= true;
		export UseBusinessHeader				:= true;
		export Update 									:= ExistCurrentCCSprayed and ExistCurrentRSIHSprayed and ExistBaseFile;
		
end;