export Cleanup_Input_Files(

	 string																		pversion			= ''	//version to delete
	,dataset(Layout_FilenameVersions.inputs)	pFilenames								//filenames to delete
	,string																		pFilter				= ''				//regex to filter the dataset passed in
	,boolean																	pIsTesting		= false			//just output dataset of files to delete, no deletion performed
	,boolean																	pNotFilter		= false			//Negate the filter?

) :=
function

	dfilenames := pFilenames;
	
	filter			:= if(pFilter = ''	,true
																	,regexfind(pFilter,dfilenames.templatename		,nocase)
								);

	
	fullfilter := if(pNotFilter	,not(filter),filter);
	
	dfiles2cleanup := dfilenames(fullfilter);
																				
	names := project(dfiles2cleanup, transform({Layout_Names, dataset(layout_names) subfiles}
		, name := mod_FilenamesInput(left.templatename);
			self.name := if(pversion = ''
											,map(	 mod_Utilities.compare_supers(name.Using	)	=>	name.Using
														,mod_Utilities.compare_supers(name.Used		)	=>	name.Used
														,																						 		name.Used
											)
											,regexreplace('@version@',left.templatename,pversion,nocase)
									);
			self.subfiles := if(self.name != '' ,fileservices.superfilecontents(self.name)  ,dataset([],Layout_Names))
		)
	);

//	return output(names,all);

	return nothor(apply(names,tools.fun_DeleteSubfiles(subfiles, pIsTesting)));

end;