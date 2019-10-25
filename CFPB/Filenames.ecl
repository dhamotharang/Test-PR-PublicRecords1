import versioncontrol, tools, Doxie;

export Filenames(string pversion = '', boolean pUseProd = false, boolean isfcra = false) := module
	shared version_suffix := if(pversion = '', '', '::' + pversion);
	shared FCRA_extension := if(isfcra, '::fcra', '');
  	export BaseBLKGRP := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::BLKGRP' + version_suffix;
	export BaseBLKGRP_attr_over18 := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::BLKGRP_attr_over18'+ version_suffix;
	export BaseCensus_surnames := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::census_surnames'+ version_suffix;

	export keyBLKGRP := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::BLKGRP'+ version_suffix;
	export keyBLKGRP_attr_over18 := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::BLKGRP_attr_over18'+ version_suffix;
	export keyCensus_surnames := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + '::census_surnames'+ version_suffix;
end;
