IMPORT PromoteSupers, roxiekeybuild, PRTE2_DEADCO;

//Input File
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'infousa::deadco');

//Base File
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'infousa::deadco');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'linkids');

//Autokeys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::infousa::deadco', 'autokey::zipb2');