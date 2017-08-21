import promotesupers, roxiekeybuild, std;


STD.File.CreateSuperFile('~prte::in::irs5500',,1);
promotesupers.mac_create_superfiles('~prte::base::irs5500');

//custom keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::irs5500','bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::irs5500','linkids');