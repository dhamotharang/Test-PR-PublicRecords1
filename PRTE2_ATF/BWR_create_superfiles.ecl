IMPORT PromoteSupers, roxiekeybuild, PRTE2_ATF;

//Input File
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'atf::firearms');

//Base File
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'atf::firearms');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'atfid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'lnum');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'linkids');

//FCRA Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms::fcra', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms::fcra', 'atfid');

//Autokeys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::atf::firearms', 'autokey::zipb2');