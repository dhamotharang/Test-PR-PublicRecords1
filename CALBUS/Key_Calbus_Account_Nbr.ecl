import doxie, data_services;

base := Calbus.File_Calbus_Base_For_Keys(trim(Account_Number,left,right) <> '');				   

export Key_Calbus_Account_Nbr := index(base,
							           {Account_Number},
							           {base},
							           data_services.data_location.prefix() + 'thor_data400::key::calbus::'+doxie.Version_SuperKey+'::Account_Nbr');
