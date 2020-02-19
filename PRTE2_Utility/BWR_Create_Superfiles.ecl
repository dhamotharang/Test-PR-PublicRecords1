import promotesupers, roxiekeybuild, std;


STD.File.CreateSuperFile('~prte::in::utility::utilitydaily',,1);
STD.File.CreateSuperFile('~prte::in::utility::utilitydailyins',,1);

promotesupers.mac_create_superfiles('~prte::base::utility_file');

//custom keys
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.citystname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.fdid');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.name');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.phone');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.ssn');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.stname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.zipprlname');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','daily.zip');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::utility','linkids');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key','utility_address');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key','utility_did');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::datecorrect','hval');