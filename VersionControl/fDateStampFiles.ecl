import lib_fileservices;
export fDateStampFiles(

	 string		pFilenameRegex							// regex to filter the filenames
	,boolean	pInsertIn5thTuplet	= false	// default is fourth
	,boolean	pIsTesting					= true	// If true	, just output the dataset of files matched
																				// If false	, output the dataset, and perform the rename 
) :=
function

	file_list								:= fileservices.LogicalFileList();
	
	filename_filter					:= regexfind(pFilenameRegex	, file_list.name		, nocase);
	
	myfile_list							:= file_list(filename_filter,superfile = false,not regexfind('[[:digit:]]{6,8}', name));
	
	//need superfile(which is old filename), logical filename
	
	layout_superfilerenaming tGetReadyForRenaming(lib_fileservices.FsLogicalFileInfoRecord l) :=
	transform
		//get date
		date_stamp := regexreplace('^.*?([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}).*$', l.modified, '$1$2$3');
		
		newname		:= if(not pInsertIn5thTuplet 
											,regexreplace('^([^:]+::[^:]+::[^:]+::)(.*)$',l.name,'$1@version@::$2')
											,regexreplace('^([^:]+::[^:]+::[^:]+::[^:]+::)(.*)$',l.name,'$1@version@::$2')
									);
		newname2	:= regexreplace('@version@',newname,date_stamp);
		
		self.oldname := l.name;
		self.newname := newname2;

	end;

	dGetReadyForRenaming := project(myfile_list, tGetReadyForRenaming(left));
	
	
	//changed to dated files, then those old filenames created as superfiles, and 
	//the dated files added to those superfiles.

	fRenameFiles(string oldname, string newname) :=
	function
	
		return sequential(
			 fileservices.RenameLogicalFile(oldname,	newname)
			,fileservices.createsuperfile(oldname)
			,fileservices.AddSuperFile('~' + oldname,newname)
		);
	
	end;

	todo := sequential(
						 output(dGetReadyForRenaming, all)
						,if(not pIsTesting
							,nothor(apply(dGetReadyForRenaming, fRenameFiles(oldname,newname)))
						)
					);

	return todo;

end;