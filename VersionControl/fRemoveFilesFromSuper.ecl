import doxie, lib_fileservices;
///////////////////////////////////////////////////////////////////////////
// -- Finds the superfiles that contain the logical files passed
// -- Then clears those logical files from their superfile containers
// -- Then deletes the subfiles
//////////////////////////////////////////////////////////////////////////
/*

all_superfiles := DATASET([

	 {'~thor_data400::key::busreg::20060627::company.bdid'},
	 {'~thor_data400::key::busreg::20060627::contact.bdid'}

], versioncontrol.Layout_Names);

versioncontrol.fRemoveFilesFromSuper(all_superfiles, 'IL', true);

*/
///////////////////////////////////////////////////////////////////////////


export fRemoveFilesFromSuper(

	 dataset(Layout_Names)	pSuperfiles
	,string									pSubFileRegex
	,boolean 								pIsTesting 			= true
	,boolean								pDelete					= false

) := FUNCTION

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get Subfiles, superfiles that contain that subfile, number of superfile containers, new logical keyname
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Layout_Superkeynames.RemoveSubfiles tGetSubfiles(Layout_Names l) :=
	transform
		self.superfilename		:= l.name;
		self.dSubfiles				:= fileservices.superfilecontents(l.name)(regexfind(pSubFileRegex, name, nocase));
	end;   

	mySubfiles				:= project(pSuperfiles, tGetSubfiles(left));

	outputmySubfiles	:= output(mySubfiles);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tRemoveFromSuperfile(string pSuperfilename, DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSubfiles) := 
		apply(pSetSubfiles, fileservices.RemoveSuperFile(pSuperfilename, Name));

	ClearSubsAndDelete := APPLY(mySubfiles,	
		sequential(
			 FileServices.StartSuperFileTransaction()
			,tRemoveFromSuperfile(	superfilename, dSubfiles)
			,FileServices.FinishSuperFileTransaction()
			,if(pDelete, apply(dSubfiles, versioncontrol.mUtilities.deletelogical('~' + name)))
		)
	);
				
				
	return if(pIsTesting = true, sequential(outputmySubfiles), 
		sequential(
			 outputmySubfiles
			,nothor(ClearSubsAndDelete)));

end;