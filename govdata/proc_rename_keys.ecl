import business_header,VersionControl;

export proc_rename_keys(

	 string		pversion
	,boolean	pIsTesting = false

) := 
function

	versioncontrol.Layout_Superkeynames.InputLayout trenamelayout(versioncontrol.layout_versions.builds l) :=
	transform

		self.superkeyname						:= VersionControl.fFilterSuperkeys(l.dSuperfiles,'qa')[1].name;
		self.logicalkeynameversion	:= l.logicalname;

	end;

	all_superkeynames := project(keynames().dAll_filenames, trenamelayout(left));

	rename_keys := versioncontrol.fLogicalKeyRenaming(all_superkeynames, pIsTesting, pversion);

	return sequential(
		 rename_keys
		,govdata.Send_Emails(pversion,pIsTesting)
	);

end;