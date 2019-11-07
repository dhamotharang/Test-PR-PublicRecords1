import $, Data_Services, Doxie;
export Filenames(boolean use_prod = false, boolean isfcra = false) := module
	shared file_loc := $._Dataset(use_prod).thor_cluster_Files + 'key::CFPB' + if(isfcra, '::fcra', '');
	export keyBLKGRP :=  file_loc + '::BLKGRP_qa';
	export keyBLKGRP_attr_over18 :=  file_loc + '::BLKGRP_attr_over18_qa';
	export keyCensus_surnames :=  file_loc + '::census_surnames_qa';
end;
