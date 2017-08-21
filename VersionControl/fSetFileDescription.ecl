//////////////////////////////////////////////////////////////////////////////////////////////
// -- fSetFileDescription() function:
// -- 	Adds the pass description string to the files passed
// --		Useful to add when rebuilding files with a "b" version(or c, d, etc) to 
// -- 	to give all of the files a description that explains the reason for the rebuild
// --		Such as a bug # that will be fixed, etc.
// --
// -- 	Parameters:
// --			pFiles				-- dataset of filenames(superfiles or logical files)
// --			pDescription	-- Description to add to files

//////////////////////////////////////////////////////////////////////////////////////////////
#option('maxLength', 131072); // have to increase for the superfile contents child datasets

export fSetFileDescription(

	 dataset(Layout_Names)	pFiles				// list of files 
	,string									pDescription

) := FUNCTION

	layout_subfiles := VersionControl.Layout_Superkeynames.DeleteSubfilesOut;
	
	layout_subfiles tGetSubfiles(layout_names l) := 
	transform
	
		self.dSubfileContainers	:= map(	 fileservices.SuperFileExists	(l.name)	=> fileservices.superfilecontents(l.name)
																		,fileservices.FileExists			(l.name)	=> dataset([{l.name}]	, layout_names)
																																							,dataset([]					, layout_names)
																);
		self.subfilename				:= l.name;
	
	end;
	
	dGetSubfiles := project(pFiles, tGetSubfiles(left));
	
	layout_names tNormFiles(layout_subfiles l, layout_names r) := 
	transform
	
		self.name := r.name;
	
	end;
	
	dNormed := normalize(
							 dGetSubfiles
							,left.dSubfileContainers
							,tNormFiles(left,right)
						);
	
	

	add_description := apply(dNormed, FileServices.SetFileDescription(name, pDescription));
	
	return add_description;

end;