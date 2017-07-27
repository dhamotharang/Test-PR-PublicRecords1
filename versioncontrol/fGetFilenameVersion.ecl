//////////////////////////////////////////////////////////////////////////////////////
// -- fGetFilenameVersion(string pFilename)
// -- 	Pass it the filename, and it will return the version of the filename
// --	if filename is a superfile, it will return the version of the subfile of that superfile
// --	If can't find version or superfile doesn't contain a subfile, returns zero
// --	returns an integer
//////////////////////////////////////////////////////////////////////////////////////
export fGetFilenameVersion(string pFilename) := 
function
	IsSuperFile	:= FileServices.SuperFileExists(pFilename);
	
	Subfile		:= if(IsSuperFile, FileServices.GetSuperFileSubName(pFilename, 1), pFilename);
	
	lVersion	:= if(regexfind('[0-9]{8}',Subfile) = true, (unsigned4)regexfind('[0-9]{8}',Subfile, 0), 0);
	
	return lVersion;
end;
	