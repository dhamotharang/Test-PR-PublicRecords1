import promotesupers, roxiekeybuild, std;


STD.File.CreateSuperFile('~prte::in::vehicle::main',,1);
STD.File.CreateSuperFile('~prte::in::vehicle::party',,1);

promotesupers.mac_create_superfiles('~prte::base::vehicle::main');
promotesupers.mac_create_superfiles('~prte::base::vehicle::party');
promotesupers.mac_create_superfiles('~prte::base::vehicle::party_bip');
promotesupers.mac_create_superfiles('~prte::hole::wildcard_public');

//autokey keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'addressb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'citystnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'fein2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'nameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'namewords2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'phone2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'phoneb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'ssn2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'stnameb2');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte', '::key::vehiclev2::autokey', 'zipb2');


//custom keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','bocashell_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','dl_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','lic_plate_blur');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','lic_plate');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','main_key');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','mfd_srch');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','party_key');


roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','reverse_lic_plate');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','source_rec_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','title_number');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','vehicles_address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::vehiclev2','vin');

//Wildcard Keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::wc_vehicle','keymodelindex_public');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::wc_vehicle','keynameindex_public');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::wc_vehicle','make');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::wc_vehicle','bodystyle');
