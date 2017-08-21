IMPORT PromoteSupers, roxiekeybuild, PRTE2_PhonesPlus;

//Input Files
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'phonesplusv2::boca::ge');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'phonesplusv2::boca::hist');

//Base File
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'phonesplusv2::base_all');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'companyname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'fdids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'companyname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'fdids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplusv2_royalty', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::iverification', 'phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::iverification', 'did_phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neustar', 'phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::neustar', 'phone_history');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplus_scoring', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::phonesplus_scoring', 'phone');
