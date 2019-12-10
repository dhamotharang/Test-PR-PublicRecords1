import ConsumerFinancialProtectionBureau, versioncontrol, tools, Doxie;

export Filenames(boolean pUseProd = false, boolean isfcra = false) := module
	shared FCRA_extension := if(isfcra, '::fcra', '');

	export BaseBLKGRP_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::BLKGRP';
    export BaseBLKGRP_attr_over18_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::BLKGRP_attr_over18';
    export BaseCensus_surnames_in := ConsumerFinancialProtectionBureau._Dataset(true).thor_cluster_files + 'in::' + ConsumerFinancialProtectionBureau._Dataset().name + '::names_2010census';

  	export BaseBLKGRP := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name  + '::BLKGRP';
	export BaseBLKGRP_attr_over18 := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name  + '::BLKGRP_attr_over18';
	export BaseCensus_surnames := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'base::' + ConsumerFinancialProtectionBureau._Dataset().name  + '::census_surnames';

	export keyPrefix := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension;
	//export keyBLKGRP := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP';
	//export keyBLKGRP_attr_over18 := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::BLKGRP_attr_over18';
	//export keyCensus_surnames := ConsumerFinancialProtectionBureau._Dataset(pUseProd).thor_cluster_files + 'key::' + ConsumerFinancialProtectionBureau._Dataset().name + FCRA_extension + '::census_surnames';
end;
