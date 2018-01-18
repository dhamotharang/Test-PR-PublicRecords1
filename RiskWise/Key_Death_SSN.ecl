import doxie, header,data_services;

f := header.File_Did_Death_Master;

export Key_Death_SSN:= INDEX(f,{ssn},{f},data_services.data_location.prefix() + 'thor_data400::key::death_ssn_'+doxie.Version_SuperKey);