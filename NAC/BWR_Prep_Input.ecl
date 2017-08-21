import ut, VersionControl,lib_stringlib,lib_fileservices,_control;

export BWR_prep_input(string version,string ip,string rootDir) := function

	return SprayAndQualifyInput(version,ip,rootDir);

end;