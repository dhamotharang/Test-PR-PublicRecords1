IMPORT PromoteSupers, roxiekeybuild, PRTE2_FCC;

//Input File
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'fcc::base_in');

//Base File
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'fcc');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'seq');

//Autokeys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::fcc', 'autokey::zipb2');