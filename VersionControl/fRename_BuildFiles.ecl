export fRename_BuildFiles(

	 string														pversion
	,dataset(layout_versions.builds)	pFilesToRename
	,boolean													pIsTesting				= true
	,string														pSuperfileVersion	= 'qa'	// super file/keys version to look in to find logical files to rename

) :=
function

	all_superkeynames := project(pFilesToRename, transform(
		 Layout_Superkeynames.InputLayout
		,self.superkeyname					:= fFilterSuperkeys(left.dSuperfiles,pSuperfileVersion)[1].name;
		 self.logicalkeynameversion	:= left.logicalname;
	));

	rename_keys := fLogicalKeyRenaming(all_superkeynames, pIsTesting, pversion);

	return rename_keys;
	
end;

