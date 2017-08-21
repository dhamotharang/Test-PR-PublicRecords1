IMPORT PromoteSupers, roxiekeybuild, PRTE2_Marriage_Divorce;

//Input File
FileServices.CreateSuperFile(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'main_base');

//Base File
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.BASE_PREFIX + 'main');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.BASE_PREFIX + 'search');

//Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div', 'filing_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div', 'id_main');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div', 'id_search');

//FCRA Key files
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div::fcra', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div::fcra', 'id_main');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::mar_div::fcra', 'id_search');

//Autokeys
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::address');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::citystname');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::name');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::payload');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::stname');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::zip');

//Not sure why these are needed since they are supposed to be skipped, but macro is failing because they are missing?????
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::addressb2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::fein2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::ssn2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::Phone2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::Phoneb2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::citystnameb2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::nameb2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::namewords2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::stnameb2');
promotesupers.mac_create_superfiles(PRTE2_Marriage_Divorce.Constants.KEY_PREFIX + 'autokey::zipb2');