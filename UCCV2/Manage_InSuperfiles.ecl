//////////////////////////////////////////////////////////////////////////////////////////
// Attribute 	: Manage_Superfiles

// PARAMETERS	: filename = superfile name for which needs to be managed
//				  movefile = true - moves the logical file from in superfile to using 
//							 false - if the subcount of using superfile is more than 1, 
//									 removes all the logical files from "in" superfiles 
//									 that are in "using"  

// PURPOSE	 	: Maintain a lookup to determine what is being used in the 
//				  build and remove only those files from the input superfile 

//////////////////////////////////////////////////////////////////////////////////////////

export Manage_InSuperfiles(string filename,boolean movefile) := function
	prefix := '~thor_data400::in::uccv2::';
	suffix := regexreplace(prefix,filename,'');
	usingfilename := prefix + 'using::' + suffix;
	ds := fileservices.superfilecontents(usingfilename);
	dsin := fileservices.superfilecontents(filename); 
	retval := if ( movefile,
				if ( fileservices.SuperFileExists(usingfilename),
					apply(dsin,
					if(fileservices.findsuperfilesubname(usingfilename,'~'+name) > 0,
						output('~'+name + ' already in ' + usingfilename),
						fileservices.AddSuperFile(usingfilename,'~'+name)
						
						
						)),
					sequential
						(
							fileservices.CreateSuperFile(usingfilename),
							fileservices.AddSuperFile(usingfilename,filename,,true)
						)
					),
				if (fileservices.getsuperfilesubcount(usingfilename) > 0,
					sequential
						(
						nothor(
							apply(ds,fileservices.removesuperfile(filename,'~'+name))
								),
						fileservices.clearsuperfile(usingfilename)
						),
						output('No new files processed for ' + filename)
					)
				);
				
	return retval;
									
end;