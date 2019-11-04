import ConsumerFinancialProtectionBureau, versioncontrol, tools, Doxie;

export Filenames(string filedate = '', boolean pUseProd = false, boolean isfcra = false) := module
	shared version_suffix := if(filedate = '', '', '_' + filedate);
	shared FCRA_extension := if(isfcra, '::fcra', '');

	export BaseBLKGRP_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::BLKGRP';
    export BaseBLKGRP_attr_over18_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::BLKGRP_attr_over18';
    export BaseCensus_surnames_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::names_2010census';

  	export BaseBLKGRP := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP' + version_suffix ;
	export BaseBLKGRP_attr_over18 := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP_attr_over18' + version_suffix ;
	export BaseCensus_surnames := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::census_surnames' + version_suffix ;

	export keyBLKGRP := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP' + version_suffix ;
	export keyBLKGRP_attr_over18 := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP_attr_over18' + version_suffix ;
	export keyCensus_surnames := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::census_surnames' + version_suffix ;
end;
