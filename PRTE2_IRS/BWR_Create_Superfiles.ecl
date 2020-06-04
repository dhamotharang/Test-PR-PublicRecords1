import promotesupers, roxiekeybuild, std;

FileServices.CreateSuperFile ('~PRTE::IN::irskeys::boca');
FileServices.CreateSuperFile ('~PRTE::IN::irskeys::alpha');

promotesupers.mac_create_superfiles('~prte::base::irs5500');

//custom keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::irs5500','bdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::irs5500','linkids');