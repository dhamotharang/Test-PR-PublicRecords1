import promotesupers, roxiekeybuild;


promotesupers.mac_create_superfiles('~prte::base::proflic_mari::individual_detail');
promotesupers.mac_create_superfiles('~prte::base::proflic_mari::disciplinary_actions');
promotesupers.mac_create_superfiles('~prte::base::proflic_mari::regulatory_actions');
promotesupers.mac_create_superfiles('~prte::base::proflic_mari::search');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'license_nbr');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'rid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'ssn_taxid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'disciplinary_actions');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'individual_detail');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'nmls_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'regulatory_actions');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari', 'cmc_slpk');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::fcra', 'did');
 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'fein');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'zipb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::proflic_mari::autokey', 'fein2');
