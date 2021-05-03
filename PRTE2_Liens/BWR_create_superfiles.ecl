IMPORT PromoteSupers, roxiekeybuild, PRTE2_Liens;

//Input files
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'main');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'status');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'party');

//Base files
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'main');
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'party');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'case_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'filing_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'main::certificate_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'main::irs_serial_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'main::rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'main::tmsid.rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'party::tmsid.rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'party::linkids');//empty


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'party::SourceRecId');//empty

//FCRA Keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'case_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'filing_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'main::certificate_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'main::irs_serial_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'main::rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'main::tmsid.rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'party::tmsid.rmsid');

//Autokeys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::fein');//empty
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::fein2');//empty
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::phone2');//empty
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::phoneb2');//empty
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2', 'autokey::zipb2');

//FCRA Autokeys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::fein');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::fein2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::liensV2::fcra', 'autokey::zipb2');

