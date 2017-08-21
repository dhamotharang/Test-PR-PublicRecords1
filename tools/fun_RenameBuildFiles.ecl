export fun_RenameBuildFiles(

	 string																		pversion
	,dataset(Layout_FilenameVersions.builds)	pFilesToRename
	,boolean																	pIsTesting					= true
	,string																		pSuperfileVersion		= 'qa'	// super file/keys version to look in to find logical files to rename
	,string																		pFilter							= ''
	,string																		pSubfilefilterRegex	= ''		//regex to filter subfile(s)


) :=
function
	
	filter	:= if(pFilter = ''	,true
															,regexfind(pFilter,pFilesToRename.templatename,nocase)
						);
	
	dfilenames_filtered := pFilesToRename(filter);

	all_superkeynames := project(dfilenames_filtered, transform(
		 Layout_SuperFilenames.InputLayout
		,self.superkeyname					:= fun_FilterSuperkeys(left.dSuperfiles,pSuperfileVersion)[1].name;
		 self.logicalkeynameversion	:= left.logicalname;
	));
	
	rename_keys := fun_RenameFiles(all_superkeynames, pIsTesting, pversion,,pSubfilefilterRegex);

	return rename_keys;
	
end;
