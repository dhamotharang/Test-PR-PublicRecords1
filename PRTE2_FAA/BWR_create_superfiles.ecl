import promotesupers, roxiekeybuild;


promotesupers.mac_create_superfiles('~prte::base::faa::aircraft_info');
promotesupers.mac_create_superfiles('~prte::base::faa::aircraft_reg');
promotesupers.mac_create_superfiles('~prte::base::faa::airmen');
promotesupers.mac_create_superfiles('~prte::base::faa::airmen_certs');
promotesupers.mac_create_superfiles('~prte::base::faa::engine_info');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_info');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_reg_bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_reg_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'aircraft_reg_nnum');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'airmen_certs');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'airmen_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'airmen_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'airmen_rid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa', 'engine_info');
 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'aircraft_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'aircraft_info');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'aircraft_reg_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'aircraftreg_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'airmen_certs');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'airmen_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'airmen_rid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::fcra', 'engine_info');
 
 
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::autokey', 'zipb2');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::faa::airmen::autokey', 'zip');
