import crim_offense_cat, versioncontrol, tools, Doxie;

export Filenames(boolean pUseProd = false) := module
	export BaseIn := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'in::' + crim_offense_cat._Dataset(pUseProd).name;
//	export ProcessedIn := BaseIn + '::processed';
  	export Base := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'base::' + crim_offense_cat._Dataset(pUseProd).name;
//	export ProcessedBase := Base + '::processed';
	export Key := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'key::' + crim_offense_cat._Dataset(pUseProd).name;
end;
