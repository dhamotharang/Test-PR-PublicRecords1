import doxie, VersionControl;

export Rename_Keys(

	 string		pversion
	,boolean	pIsTesting		= true

) :=
function
	
	dpackagekeys := keynames(pversion).dAll_filenames;
                                                         
	versioncontrol.Layout_Superkeynames.InputLayout trenamelayout(versioncontrol.layout_versions.builds l) :=
	transform

		self.superkeyname						:= VersionControl.fFilterSuperkeys(l.dSuperfiles,'qa')[1].name;
		self.logicalkeynameversion	:= l.logicalname;

	end;

	all_superkeynames := project(dpackagekeys, trenamelayout(left));

	rename_keys := versioncontrol.fLogicalKeyRenaming(all_superkeynames, pIsTesting, pversion);

	return rename_keys;

end;