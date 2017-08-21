IMPORT PromoteSupers, roxiekeybuild, PRTE2_SexOffender;

//Input Files
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'sexoffender_main');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'sexoffense');

//Base Files
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'sex_offender_main');
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'sex_offender_offenses');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'didpublic');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublic');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'spkpublic');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'offenses_public');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublicaddress');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpubliccitystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublicname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublicphone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublicssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpublicstname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'enhpubliczip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publicaddress');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publiccitystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publicname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publicphone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publicssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publicstname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'publiczip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'fdid_public');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'zip_type_public');

//FCRA Keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender::fcra', 'didpublic');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender::fcra', 'offenses_public');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender::fcra', 'spkpublic');

//Autokey Files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::sexoffender', 'autokey::latlong');
