import doxie, lib_fileservices;
///////////////////////////////////////////////////////////////////////////
// -- Finds the subfiles that the superfile contains
// -- clears the superfile, then renames it
// -- then adds back the subfiles
//////////////////////////////////////////////////////////////////////////
/*

rename_dataset := DATASET([

	 {'~thor_data400::key::busreg::spryed::company.bdid','~thor_data400::key::busreg::sprayed::company.bdid'},
	 {'~thor_data400::key::busreg::usid::contact.bdid'	,'~thor_data400::key::busreg::used::contact.bdid'}

], VersionControl.layout_superfilerenaming);

VersionControl.fSuperfileRenaming(rename_dataset, false);

*/
///////////////////////////////////////////////////////////////////////////


export fSuperfileRenaming(

	 dataset(layout_superfilerenaming)	psuperfilenames
	,boolean 														pIsTesting 				= true
	,boolean														pDeleteOldSuper		= false

) := FUNCTION


	layout_subfiles :=
	record, maxlength(50000)
		string oldname;
		string newname;
		DATASET(lib_fileservices.FsLogicalFileNameRecord)	dSubfiles;
	end;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get subfiles that Superfile contains
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	layout_subfiles tGetSubfiles(layout_superfilerenaming l) :=
	transform
		self							:= l;
		self.dSubfiles		:= fileservices.superfilecontents(l.oldname);
	end;

	mySubfiles					:= project(psuperfilenames, tGetSubfiles(left));

	outputmySubfiles		:= output(mySubfiles);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear superfile, rename it, then add back subfiles
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tRenameSuperfile(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSubfiles, string oldName, string newname) := 
		sequential(
			 VersionControl.mUtilities.createsuper(newname)
			,fileservices.StartSuperFileTransaction()
			,fileservices.clearSuperFile(oldname)
			,apply(pSetSubfiles, fileservices.addsuperfile(newname, '~' + name))
			,fileservices.finishSuperFileTransaction()
			,if(pDeleteOldSuper = true,fileservices.deletesuperfile(oldname))
		);


	RenameSupers := APPLY(mySubfiles,
		tRenameSuperfile(	dSubfiles, oldname, newname)
		);
				
	return if(pIsTesting = true
															,sequential(outputmySubfiles)
															,sequential(
																	 outputmySubfiles
																	,nothor(RenameSupers)
																)
	);

end;