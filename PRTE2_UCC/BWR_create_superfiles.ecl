IMPORT PromoteSupers, roxiekeybuild, PRTE2_UCC;

//Input files
FileServices.CreateSuperFile(PRTE2_UCC.Constants.IN_PREFIX + 'main');
FileServices.CreateSuperFile(PRTE2_UCC.Constants.IN_PREFIX + 'party');

//Base files
promotesupers.mac_create_superfiles(PRTE2_UCC.Constants.BASE_PREFIX + 'main');
promotesupers.mac_create_superfiles(PRTE2_UCC.Constants.BASE_PREFIX + 'party');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'filing_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'did_w_type');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'bdid_w_type');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'main_rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'party_rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc', 'linkids');

//FCRA Key
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc::fcra', 'did_w_type');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc::fcra', 'main_rmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::ucc::fcra', 'party_rmsid');

//Autokeys
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::address');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::addressb2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::citystname');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::citystnameb2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::fein2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::name');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::nameb2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::namewords2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::payload');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::phone2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::phoneb2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::ssn2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::stname');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::stnameb2');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::zip');
promotesupers.mac_create_superfiles_standard('~prte', '::key::ucc', 'autokey::zipb2');