import doxie, lib_fileservices;
///////////////////////////////////////////////////////////////////////////
// -- Finds the superfiles that contain the logical files passed
// -- Then clears those logical files from their superfile containers
// -- Then deletes the subfiles
//////////////////////////////////////////////////////////////////////////
/*
all_subfilenames := DATASET([
	 {'~thor_data400::key::busreg::20060627::company.bdid'},
	 {'~thor_data400::key::busreg::20060627::contact.bdid'}
], Tools.Layout_Names);
Tools.fun_DeleteSubfiles(all_subfilenames, false);
*/
///////////////////////////////////////////////////////////////////////////
export fun_DeleteSubfiles(

	 dataset(Layout_Names)	pAll_subfilenames
	,boolean 								pIsTesting 				= true

) := FUNCTION
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get Subfiles, superfiles that contain that subfile, number of superfile containers, new logical keyname
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Layout_SuperFilenames.DeleteSubfilesOut tGetSuperOwners(Layout_Names l) :=
	transform
		self.subfilename				:= if(l.name[1] != '~', '~' + l.name, l.name);
		self.doessubfileexist		:= fileservices.fileexists(self.subfilename);
		self.dSubfileContainers	:= if(self.doessubfileexist
																		,fileservices.LogicalFileSuperOwners(self.subfilename)
																		,dataset([], Layout_Names)
															);
	end;
	mySuperkeycontainers				:= global(project(pAll_subfilenames, tGetSuperOwners(left)),few);
	outputmySuperkeycontainers	:= output(mySuperkeycontainers,all);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tRemoveFromSuperfile(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSuperkeys, string pName) := 
		apply(pSetSuperkeys, fileservices.RemoveSuperFile('~' + name, pName));
	tDeleteLogicalFile(string pName) :=
		fileservices.DeleteLogicalFile(pName);
	ClearSupersAndDelete := APPLY(mySuperkeycontainers(doessubfileexist),
		sequential(	tRemoveFromSuperfile(	dSubfileContainers, subfilename), 
						tDeleteLogicalFile(	subfilename)
		));
				
				
	return if(pIsTesting = true, outputmySuperkeycontainers, 
		sequential(
			 outputmySuperkeycontainers
			,nothor(ClearSupersAndDelete)));
			
end;
