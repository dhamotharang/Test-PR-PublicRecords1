IMPORT PromoteSupers, roxiekeybuild, PRTE2_Watercraft;

//Input Files
FileServices.CreateSuperFile(PRTE2_Watercraft.Constants.IN_PREFIX + 'boca::base');

//Base File
promotesupers.mac_create_superfiles_standard('~prte', '::base::prte2::watercraft', 'boca');
promotesupers.mac_create_superfiles_standard('~prte', '::base::prte2::watercraft', 'coastguard');
promotesupers.mac_create_superfiles_standard('~prte', '::base::prte2::watercraft', 'main');
promotesupers.mac_create_superfiles_standard('~prte', '::base::prte2::watercraft', 'search');

//Key files
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'bdid');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'cid');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'did');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'hullnum');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'linkids');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'offnum');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'sid');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'sid::linkids');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'source_rec_id');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'vslnam');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'wid');

//FCRA Key files
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft::fcra', 'cid');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft::fcra', 'did');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft::fcra', 'sid');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft::fcra', 'wid');

//Autokeys
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::address');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::addressb2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::citystname');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::citystnameb2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::fein2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::name');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::nameb2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::namewords2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::payload');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::phone2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::phoneb2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::ssn2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::stname');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::stnameb2');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::zip');
roxiekeybuild.mac_create_superfiles_standard('~prte', '::key::watercraft', 'autokey::zipb2');