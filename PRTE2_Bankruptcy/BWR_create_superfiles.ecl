IMPORT PromoteSupers, roxiekeybuild, PRTE2_Bankruptcy;

//Input File
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'bankruptcy::main_built');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'bankruptcy::main_comments_built');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'bankruptcy::main_status');
FileServices.CreateSuperFile(Constants.IN_PREFIX + 'bankruptcy::search_built');

//Base File
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'bankruptcy::main');
promotesupers.mac_create_superfiles(Constants.BASE_PREFIX + 'bankruptcy::search');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'case_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'main::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'search::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv2', 'search_v3::linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'ssnmatch');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'main::supplemental');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'trusteeidname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'main::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'search::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'search::tmsid_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'case_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'ssn4st');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'search_v3::linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3', 'withdrawnstatus');

//FCRA Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'ssnmatch');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'main::supplemental');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'trusteeidname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'main::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'search::tmsid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'search::tmsid_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'case_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'ssn4st');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'search_v3::linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcyv3::fcra', 'withdrawnstatus');

//Autokeys
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::address');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::addressb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::citystname');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::citystnameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fein2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::name');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::nameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::namewords2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::payload');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::phone2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::phoneb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcy::autokey', 'ssnlast4name'); //uses a specialty build script
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::stname');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::stnameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::zip');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::zipb2');

//Autokeys FCRA
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::address');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::addressb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::citystname');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::citystnameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::fein2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::name');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::nameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::namewords2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::payload');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::phone2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::phoneb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::bankruptcy::autokey::fcra', 'ssnlast4name');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::stname');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::stnameb2');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::zip');
promotesupers.mac_create_superfiles(PRTE2_Bankruptcy.Constants.KEY_PREFIX + 'bankruptcy::autokey::fcra::zipb2');
