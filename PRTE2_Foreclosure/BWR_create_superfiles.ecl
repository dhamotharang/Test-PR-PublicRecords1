import promotesupers, roxiekeybuild;

promotesupers.mac_create_superfiles('~prte::base::foreclosure');
promotesupers.mac_create_superfiles('~prte::base::foreclosure_normalized');

//Foreclosure Keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'index_geo12');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'index_geo11');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'index_fips');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'address');

roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'fid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'fid_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure', 'linkids');

roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::foreclosure::autokey', 'zipb2');



//NOD keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod', 'bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod', 'did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod', 'fid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod', 'fid_linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod', 'linkids');

roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::nod::autokey', 'zipb2');