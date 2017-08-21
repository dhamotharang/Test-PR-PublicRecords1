import doxie;

base := CALBUS.File_Calbus_Base_For_BID_Keys(bdid <> 0);				   

export Key_Calbus_BID := index(base,
							   {bdid},
							   {bdid, Account_number},
							   '~thor_data400::key::Calbus::'+doxie.Version_SuperKey+'::bid');
