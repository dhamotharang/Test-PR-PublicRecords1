import doxie, data_services;

base := Calbus.File_Calbus_Base_For_Keys(bdid <> 0);				   

export Key_Calbus_BDID := index(base,
							   {bdid},
							   {bdid, Account_number},
							   data_services.data_location.prefix() + 'thor_data400::key::Calbus::'+doxie.Version_SuperKey+'::bdid');
