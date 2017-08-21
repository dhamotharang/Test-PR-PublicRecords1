import ut, versioncontrol, lib_fileservices, _control;

export fCopy_build_files(
 
	 string		pversion								// version date of files to copy
	,boolean	pToDataland			= true	// Copying to Dataland, from prod?
	,boolean	pIsTesting			= true	// If true, just output dataset of what to do, false actually copy the files
	,string		pFilter					= ''		// regex to filter the files to be copied			
	,boolean	pOverwrite			= false	// Should Overwrite existing files?
	,boolean	pShouldCompress	= true	// Should Compress Files?																										

) :=
function

	all_files_to_copy :=  
						  filenames().dAll_filenames
						;
						
	filter		:= if(pFilter = ''	,true
																,regexfind(pFilter,all_files_to_copy.templatename,nocase)
							);
	
	VersionControl.Layout_fCopyFiles.Input tgetsuperfiles(versioncontrol.layout_versions.builds l) :=
	transform
	
		self.srclogicalname					:= regexreplace('@version@', l.templatename, pversion);
		self.destinationgroup 			:= if(pToDataland, 'thor_dataland_linux'	, 'thor_data400');
		self.destinationlogicalname	:= self.srclogicalname;	
		self.srcdali								:= if(pToDataland	, _Control.IPAddress.prod_thor_dali
																									, _Control.IPAddress.dataland_dali
																		);
		self.dSuperfilenames				:= l.dSuperfiles(regexfind('^(.*?)::[qQ][aA]::(.*)$', name)) ;

	end;
	
	passtofunction := project(all_files_to_copy(filter), tgetsuperfiles(left));
	
	whattodo := VersionControl.fCopyFiles(passtofunction,,pIsTesting,pShouldCompress,pOverwrite);
	
	return whattodo;

end;
