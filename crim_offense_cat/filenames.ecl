import crim_offense_cat, versioncontrol, tools, Doxie;

export Filenames(boolean pUseProd = false) := module

	export BaseIn := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'in::' + crim_offense_cat._Dataset().name;

  	export Base := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'base::' + crim_offense_cat._Dataset().name;

	export Key := crim_offense_cat._Dataset(pUseProd).thor_cluster_files + 'key::' + crim_offense_cat._Dataset().name;

	export doc_offenses := '~thor::in::crim_offense_cat::charge::1::wuresult (4)mod.csv';
end;
