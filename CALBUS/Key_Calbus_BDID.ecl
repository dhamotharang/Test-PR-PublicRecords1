import doxie;

base := Calbus.File_Calbus_Base_For_Keys(bdid <> 0);				   

export Key_Calbus_BDID := index(base,
							   {bdid},
							   {bdid, Account_number},
							   '~thor_data400::key::Calbus::'+doxie.Version_SuperKey+'::bdid');
