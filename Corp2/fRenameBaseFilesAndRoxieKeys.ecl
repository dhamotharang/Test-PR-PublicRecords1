import versioncontrol;

export fRenameBaseFilesAndRoxieKeys(string pversion) :=
function 

	all_names :=  corp2.keynames(pversion).dall_filenames
							+	corp2.filenames(pversion).dall_filenames;

	versioncontrol.Layout_Superkeynames.InputLayout trenamelayout(versioncontrol.layout_versions.builds l) :=
	transform

		self.superkeyname						:= l.dSuperfiles(regexfind('^(.*?)::qa::(.*?)$', name,nocase))[1].name;
		self.logicalkeynameversion	:= l.logicalname;

	end;

	all_superkeynames := project(all_names, trenamelayout(left));
	rename_keys				:= versioncontrol.fLogicalKeyRenaming(all_superkeynames, false, pversion);

	return rename_keys;

end;