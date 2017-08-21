import	lib_fileservices;

export	FileExists	:=
module

	// Function to check if the logical key exists
	export	CheckFileExists(dataset(lib_fileservices.FsLogicalFileNameRecord)	pFiles)	:=
	function
		rAppendFileExists_layout	:=
		record
			recordof(pFiles);
			boolean	isFileExists;
		end;
		
		rAppendFileExists_layout	tGetExistenceInfo(recordof(pfiles)	l)	:=
		transform
			self.isFileExists	:=	fileservices.fileexists(l.name);
			self							:=	l;
		end;
		
		dCheckFileExists	:=	project(pFiles,tGetExistenceInfo(left));
		
		DoAllFilesExist := count(pFiles) = count(dCheckFileExists(isFileExists));
		
		return	DoAllFilesExist;
	end;
	
	// Function to get missing logical keys
	export	MissingKeyList(dataset(lib_fileservices.FsLogicalFileNameRecord)	pFiles)	:=
	function
		rAppendFileExists_layout	:=
		record
			recordof(pFiles);
			boolean	isFileExists;
		end;
		
		rAppendFileExists_layout	tGetExistenceInfo(recordof(pfiles)	l)	:=
		transform
			self.isFileExists	:=	fileservices.fileexists(l.name);
			self							:=	l;
		end;
		
		dMissingKeys	:=	project(pFiles,tGetExistenceInfo(left));
		
		return	dMissingKeys(isFileExists	=	false);
	end;
	
end;