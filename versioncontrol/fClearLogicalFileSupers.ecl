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
		self.dSubfileContainers		:= fileservices.LogicalFileSuperOwners(l.name);
	end;

	mySuperkeycontainers			:= project(pAll_subfilenames, tGetSuperOwners(left));

	outputmySuperkeycontainers		:= output(mySuperkeycontainers);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tRemoveFromSuperfile(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSuperkeys, string pName) := 
		apply(pSetSuperkeys, 
			sequential(
				 fileservices.StartSuperFileTransaction()
				,fileservices.RemoveSuperFile('~' + name, pName)
				,fileservices.finishSuperFileTransaction()
			));

	ClearSupers := APPLY(mySuperkeycontainers,
		tRemoveFromSuperfile(	dSubfileContainers, subfilename)
		);
				
	return if(pIsTesting = true, sequential(outputmySuperkeycontainers), 
		sequential(
			 outputmySuperkeycontainers
//			,nothor(ClearSupers)));
			,ClearSupers));

end;