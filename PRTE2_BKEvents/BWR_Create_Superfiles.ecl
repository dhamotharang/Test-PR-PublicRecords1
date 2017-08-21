import std, promotesupers, roxiekeybuild;


roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::banko','courtcode.fullcasenumber.caseid.payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::banko','courtcode.casenumber.caseid.payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::banko::fcra','courtcode.fullcasenumber.caseid.payload');
roxiekeybuild.mac_create_superkeyfiles_standard('~prte','::key::banko::fcra','courtcode.casenumber.caseid.payload');


STD.File.CreateSuperFile(Constants.in_prefix_name,,1);
promotesupers.mac_create_superfiles(Constants.base_prefix_name + 'nonfcra::additionalevents');
promotesupers.mac_create_superfiles(Constants.base_prefix_name + 'fcra::additionalevents');
 
