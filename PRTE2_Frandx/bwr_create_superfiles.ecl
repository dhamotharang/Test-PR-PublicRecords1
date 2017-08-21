import std, promotesupers, roxiekeybuild;

STD.File.CreateSuperFile('~prte::in::frandx',,1);
promotesupers.mac_create_superfiles('~prte::base::frandx');

roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::frandx','source_rec_id');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::frandx','linkids');
