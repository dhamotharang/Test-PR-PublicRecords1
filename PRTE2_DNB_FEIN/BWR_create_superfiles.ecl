IMPORT PromoteSupers, roxiekeybuild, PRTE2_DNB_FEIN;

//Input Files
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'main');

//Base Files
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'main');
promotesupers.mac_create_superfiles(Constants.EXP_BASE_PREFIX + 'data');

//Key Files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::experian_fein', 'linkids'); //Only key for Experian FEIN data

//Autokey Files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::fein2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::dnbfein', 'autokey::zipb2');
