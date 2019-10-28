import versioncontrol, tools, Doxie;

export Filenames(string pversion = '', boolean pUseProd = false, boolean isfcra = false) := module
	shared version_suffix := if(pversion = '', '', '::' + pversion + '::');
	shared FCRA_extension := if(isfcra, '::fcra', '');

	export BaseBLKGRP_in := $.Build_BLKGRP('~thor::cfpb_race_proxy::blkgrp');
    export BaseBLKGRP_attr_over18_in := $.Build_BLKGRP_attr_over18('~thor::cfpb_race_proxy::blkgrp_attr_over18');
    export BaseCensus_surnames_in := $.Build_census_surnames('~thor::cfpb_race_proxy::names_2010census2');

  	export BaseBLKGRP := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::BLKGRP';
	export BaseBLKGRP_attr_over18 := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::BLKGRP_attr_over18';
	export BaseCensus_surnames := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::census_surnames';

	export keyBLKGRP := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::BLKGRP';
	export keyBLKGRP_attr_over18 := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::BLKGRP_attr_over18';
	export keyCensus_surnames := _Dataset(pUseProd).thor_cluster_files + 'key::' + _Dataset().name + FCRA_extension + '::' + doxie.Version_SuperKey + version_suffix + '::census_surnames';
end;
