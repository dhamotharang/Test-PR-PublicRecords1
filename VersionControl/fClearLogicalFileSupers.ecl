import doxie, lib_fileservices;
///////////////////////////////////////////////////////////////////////////
// -- Finds the superfiles that contain the logical files passed
// -- Then clears those logical files from their superfile containers
//////////////////////////////////////////////////////////////////////////
/*

all_subfilenames := DATASET([

	 {'~thor_data400::key::busreg::20060627::company.bdid'},
	 {'~thor_data400::key::busreg::20060627::contact.bdid'}

], versioncontrol.Layout_Names);

versioncontrol.fClearLogicalFileSupers(all_subfilenames, false);

*/
///////////////////////////////////////////////////////////////////////////


export fClearLogicalFileSupers(

	 dataset(Layout_Names)	pAll_subfilenames
	,boolean 				pIsTesting 			= true

) := FUNCTION

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get superfiles that contain that subfile
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Layout_Superkeynames.DeleteSubfilesOut tGetSuperOwners(Layout_Names l) :=
	transform
		self.subfilename			:= l.name;
		self.doessubfileexist		:= fileservices.fileexists(l.name);
		self.dSubfileContainers		:= if(self.doessubfileexist
																		,fileservices.LogicalFileSuperOwners(l.name)
																		,dataset([], layout_names)
															);
	end;

	mySuperkeycontainers			:= project(pAll_subfilenames, tGetSuperOwners(left));

	outputmySuperkeycontainers		:= output(mySuperkeycontainers,all);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tRemoveFromSuperfile(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSuperkeys, string pName) := 
		sequential(
			 fileservices.StartSuperFileTransaction()
			,apply(pSetSuperkeys, 
				fileservices.RemoveSuperFile('~' + name, pName)
			)
			,fileservices.finishSuperFileTransaction()
		
		);

	ClearSupers := APPLY(mySuperkeycontainers(count(dSubfileContainers) > 0, doessubfileexist),
		tRemoveFromSuperfile(	dSubfileContainers, subfilename)
		);
				
	return if(pIsTesting = true, sequential(outputmySuperkeycontainers), 
		sequential(
			 outputmySuperkeycontainers
//			,nothor(ClearSupers)));
			,nothor(ClearSupers)));

end;