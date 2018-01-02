import doxie,data_services;

base := Txbus.File_Txbus_Base_For_Keys(trim(Taxpayer_Number, left, right) <> '');				   

export Key_Txbus_Taxpayer_Nbr := index(base,
							           {Taxpayer_Number},
							           {base},
							           data_services.data_location.prefix() + 'thor_data400::key::txbus::'+doxie.Version_SuperKey+'::Taxpayer_Nbr');
