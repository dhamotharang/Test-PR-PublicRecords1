//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: Manage_Superfiles

// PARAMETERS	: 
//				  movefile = true - moves the logical file from in superfile to processed 
//							 false - removes all files from both processed and "in" superfiles that are in "in" superfile


//////////////////////////////////////////////////////////////////////////////////////////

export Manage_Input_Files(boolean movefile) := function
	filename := '~thor_data400::in::bankoadditionalevents';
	usingfilename := '~thor_data400::in::bankoadditionalevents::processed';
	ds := fileservices.superfilecontents(usingfilename);
	dsin := fileservices.superfilecontents(filename); 
	retval := if ( movefile,
				if ( fileservices.SuperFileExists(usingfilename),
					nothor(apply(dsin,
					sequential(
								if(fileservices.findsuperfilesubname(usingfilename,'~'+name) > 0,
										fileservices.removesuperfile(usingfilename,'~'+name)),
										fileservices.AddSuperFile(usingfilename,'~'+name),
										fileservices.removesuperfile(filename,'~'+name)
										)
									)
									),
					sequential
						(
							fileservices.CreateSuperFile(usingfilename),
							fileservices.AddSuperFile(usingfilename,filename,,true)
						)
					),
				if (fileservices.getsuperfilesubcount(filename) > 0,
						nothor(
							apply(ds,
									sequential(fileservices.removesuperfile(filename,'~'+name),
												fileservices.removesuperfile(usingfilename,'~'+name))
									)
								)
						
					)
				);
				
	return retval;
									
end;